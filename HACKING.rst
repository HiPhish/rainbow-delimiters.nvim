.. default-role:: code

#################################
 Hacking on Rainbow Delimiters 2
#################################


Testing
#######


A test setup must meet the following criteria:

- Test definitions must be run by with Neovim as the Lua interpreter to get
  access to all Neovim APIs
- Tests must not be affected by the user's own plugins and configuration
- Each test which mutates editor state must run in its own Neovim process

The first two points are achieved through a small command-line interface
adapter script (a shim).  The shim exposes the command-line interface of a Lua
interpreter, and internally it sets up environment variable to point Neovim at
a prepared blank directory structure.  Neovim is then called with the `-l`
flag.

We do have to use some plugins though:

- This plugin itself
- nvim-treesitter_ to install parsers for some languages

Both plugins are stored under the `$XDG_DATA_HOME` directory, the former as a
symlink and the latter as a Git submodule.

As for process isolation, this is achieved inside the tests.  We start a
headless embedded Neovim instance which we control through MsgPack RPC from
inside the test.  We can control and probe this process only indirectly, which
is awkward, but this is the best solution I could find.


Unit testing
============

We use busted_ for unit testing.  A unit is a self-contained module which can
be used on its own independent of the editor.  Execute `make unit-test` to run
unit tests.  The `busted` binary must be available on the system `$PATH`.

End to end testing
==================

End-to-end tests run in a separate Neovim instance which we control via RPC.
These are tests which mutate the state of the editor, such as adding
highlighting on changes.  Execute `make e2e-test` to run all end to end tests.

Running tests with Neotest-busted
=================================

To run tests the `g:bustedprg` variable must be set to `'./test/busted'`, which
is the path to the shim script.  If the `exrc` option is set the variable will
be set automatically.



Design decisions
################

Tables over strings for configuration
=====================================

Strategies are given as a complex table, but a string identifier would have
been much more pleasant on the eye. Which of these two is easier to read and
write?

.. code:: lua

   -- This?
   settings = {
      strategy = {
         'global'
         html = 'local'
      }
   }

   -- Or this?
   settings = {
      strategy = {
         require 'ts-rainbow.strategy.global'
         html = require 'ts-rainbow.strategy.local'
      }
   }

Using strings might seem like the more elegant choice, but it it makes the code
more complicated to maintain and less flexible for the user.  With tables a
user can create a new custom strategy and assign it directly without the need
to "register" them first under some name.

More importantly though, we have unlimited freedom where that table is coming
from.  Suppose we wanted to add settings to a strategy.  With string
identifiers we now need much more machinery to connect a string identifier and
its settings.  On the other hand, we can just call a function with the settings
are arguments which returns the strategy table.

.. code:: lua

   settings = {
       strategy = {
           require 'ts-rainbow.strategy.global',
           -- Function call evaluates to a strategy table
           latext = my_custom_strategy {
               option_1 = true,
               option_2 = 'test'
           }
       }
   }


Strategies
##########

On container nodes
==================

Every query has to define a `container` capture in addition to `opening` and
`closing` captures.  As humans we understand the code at an abstract level, but
Tree-sitter works on a more concrete level.  To a human the HTML tag `<div>` is
one atomic object, but to Tree-sitter it is actually a container with further
elements.

Consider the following HTML snippet:

.. code:: html

   <div>
     Hello
   </div>

The tree looks like this (showing anonymous nodes):

.. code::

   element [0, 0] - [2, 6]
     start_tag [0, 0] - [0, 5]
       "<" [0, 0] - [0, 1]
       tag_name [0, 1] - [0, 4]
       ">" [0, 4] - [0, 5]
     text [1, 1] - [1, 6]
     end_tag [2, 0] - [2, 6]
       "</" [2, 0] - [2, 2]
       tag_name [2, 2] - [2, 5]
       ">" [2, 5] - [2, 6]

We want to highlight the lower-level nodes like `tag_name` or `start_tag` and
`end_tag`, but we want to base our logic on the higher-level nodes like
`element`.  The `@container` node will not be highlighted, we use it to
determine the nesting level or the relationship to other container nodes.


Determining the level of container node
=======================================

In order to correctly highlight containers we need to know the nesting level of
each container relative to the other containers in the document.  We can use
the order in which matches are returned by the `iter_matches` method of a
query.  The iterator traverses the document tree in a depth-first manner
according to the visitor patter, but matches are created upon exiting a node.

Let us look at a practical example.  Here is a hypothetical tree:

.. code::

   A
   ├─B
   │ └─C
   │   └─D
   └─E
     ├─F
     └─G

The nodes are returned in the following order:

#) D
#) C
#) B
#) F
#) G
#) E
#) A

We can only know how deeply nodes are nested relative to one another.  We need
to build the entire tree structure to know the absolute nesting levels.  Here
is an algorithm which can build up the tree, it uses the fact that the order of
nodes never skips over an ancestor.

Start with an empty stack `s = []`.  For each match `m` do the following:

#) Keep popping matches off `s` up until we find a match `m'` whose
   `@container` node is not a descendant of the container node of `m`. Collect
   the popped matches (excluding `m'`) onto a new stack `s_m` (order does not
   matter)
#) Set `s_m` as the child match stack of `m`
#) Add `m` to `s`

Eventually `s` will only contain root-level matches, i.e. matches of nesting
level one.  To apply the highlighting we can then traverse the match tree,
incrementing the highlighting level by one each time we descend a level.

The order of matches among siblings in the tree does not matter.  The above
algorithm uses a stack when collecting children, but any unordered
one-dimensional sequence will do.  The stack `s` is important for determining
the relationship between nodes: since we know that no ancestors will be skipped
we can be certain that we can stop checking the stack for descendants of `m`
once we encounter the first non-descendant match.  Otherwise we would have to
compare each match with each other match, which would tank the performance.


The local highlight strategy
============================

Consider the following bit of contrived HTML code:

.. code:: html

   <div id="Alpha">
     <div id="Bravo">
        <div id="Charlie">
        </div>
     </div>
     <div id="Delta">
     </div>
   </div>

Supposed the cursor was inside the angle brackets of `Bravo`, which tags
should we highlight?  From eyeballing the obvious answer is `Alpha`, `Bravo`
and `Charlie`.  Obviously `Alpha` and `Bravo` both contain the cursor within
the range, but how do we know that we need to highlight `Charlie`?  `Charlie`
is contained inside `Bravo`, which contains the cursor, but on the other hand
`Delta` is contained inside `Alpha`, which also contains the cursor.  We cannot
simply check whether the parent contains the cursor.

When working with the Tree-sitter API and iterating through matches and
captures we have no way of knowing that any of the captures within `Charlie`
are contained within `Bravo`.  However, due to the order of traversal we do
know that `Bravo` is the lowest node to still contain the cursor.

Therefore we that the first match which contains the cursor is the lowest one.
If a match does not contain the cursor we can check whether it is a
descendant of the cursor container match.


The problem with nested languages
#################################

The language tree of a buffer is a tree of parsers.  Some languages like
Markdown can contain other languages, which complicates things.


Foreign extmarks
================

Extmarks move along with the text they belong to.  This is generally a good
thing, but it can become a problem if we move text from one language to
another.  Consider the following Markdown code:

.. code:: markdown

   Hello world

   ```lua
   print {{{{}}}}
   print {{{{}}}}
   ```

We can move the cursor to line 4 and move that line out of the Lua block by
executing `:move 1` to move it to the second line.  However, this will preserve
the extmarks and we will end up with Lua delimiter highlighting inside
Markdown.

My solution is on every change to delete all rainbow delimiter extmarks which
do not belong to the current language.


Overwritten extmarks
====================

Take the following Markdown code:

.. code:: markdown

   Hello world

   ```c
   puts("This is an injected language")
   {
       {
           {
               {
                   {
                       return ((((((2)))))) + ((((3))))
                   }
               }
           }
       }
   }
   ```

If we put the cursor on the line with the `puts` statement and move it up one
line (`:move -2`) we get the following changes:

- Markdown
  - `{ 2, 0, 3, 0 }` 

This means lines 3 and 4 of the Markdown tree have changed; we have changed the
contents of the fifth line and added one more line.  This is all as expected.
However, let us now move the line back down by executing `:move +1`.  We get
the following changes:

- Markdown
  - `{ 3, 0, 15, 0 }`
- C
  - `{ 3, 0, 4, 0 }`

The changes to the C tree are what we expect. However, the changes to the
Markdown tree span the code block as well.  This is a problem when we start
deleting foreign extmarks (see above).  If we work from the outside we wipe out
all non-Markdown extmarks in the range, which includes the C extmarks.  Then we
apply the C extmarks inside the C block, but the C change does not span the
entire C tree.  Thus we will only apply highlighting to the changed C line, but
not the remainder of the C block.

The solution at the moment is to overwrite the changes of nested languages.  If
the changes belong to a language tree with parent language we replace all the
changes with a range that spans the entire tree for that language.



.. _busted: https://lunarmodules.github.io/busted/#defining-tests
.. _nvim-treesitter: https://github.com/nvim-treesitter/nvim-treesitter
