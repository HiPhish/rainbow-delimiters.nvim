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

Highlight testing
=================

Highlights are tested by comparing the current highlights of a sample file with
previously recorded highlights known to be correct.  Of course this does
nothing when defining new patterns or making changes to a sample file; in this
case a human has to initially approve of the highlighting.  Once that is done
the current state can be recorded.  Automated highlighting tests are useful
when making changes to the highlighting logic itself to ensure the results
remain unchanged.

Execute `make highlight-test` to run highlighting tests.

Definitions
-----------

Sample file
    A file in the language we want to highlight.  The contents have to be
    syntactically correct, and ideally the file should compile, but it does not
    have to make sense.  Sample files are stored under an arbitrary name
    (although `regular` is the most common) in `test/highlight/samples/<lang>`.

Specification or spec
    A Lua file which records all rainbow delimiter extmarks for a given
    combination of sample file and query.  Why Lua?  It could have been JSON,
    but generating nicely formatted Lua was simpler, that's all.  Each spec is
    just a table, there is no logic.

Recording
    The act of reading a sample file, extracting all highlighting information
    and writing it to a spec.  You could write all the specs by hand, but there
    is a helper function for that instead.


Recording highlighting
----------------------

First make the necessary changes to the sample file or query.  Then build the
`record-highlight` target in the makefile and pass the language as a variable.

.. code:: sh

   make record-highlight LANGUAGE=lua


Running highlight tests
-----------------------

Build the `highlight-test` target.



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
according to the visitor patter, but matches are created whenever the match is
complete.  This happens upon exiting the node if the child nodes are sandwiched
in-between delimiters, as is the case with delimiters like parentheses or
`begin`/`end` blocks.  However, if the child nodes are outside the delimiters
(e.g. when using Python keywords like `def` or `while` as delimiters) the child
nodes are not sandwiched between delimiters and the match will be returned upon
entering the node.

Sandwiching delimiters
----------------------

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
   the popped matches (excluding `m'`) onto a new set `s_m` (order does not
   matter)
#) Set `s_m` as the child match set of `m`
#) Add `m` to `s`

Eventually `s` will only contain root-level matches, i.e. matches of nesting
level one.  To apply the highlighting we can then traverse the match tree,
incrementing the highlighting level by one each time we descend a level.

The order of matches among siblings in the tree does not matter.  The stack
`s` is important for determining the relationship between nodes: since we know
that no ancestors will be skipped we can be certain that we can stop checking
the stack for descendants of `m` once we encounter the first non-descendant
match.  Otherwise we would have to compare each match with each other match,
which would tank the performance.

Here is a step-by-step illustration of the algorithm applied to the above
example.  The left-hand side is the current stack (with the bottom of the stack
on the left) and current node, the right-hand side is the resulting stack for
that iteration.  If a match has no children I have omitted the braces for
brevity.

+-------------------------+-------+--------------------------------------------+
| Current stack           | Match | New stack and popped-of match              |
+=========================+=======+============================================+
| `[]`                    | `D`   | `[D]`                                      |
+-------------------------+-------+--------------------------------------------+
| `[D]`                   | `C`   | `[]`, `C{D}`                               |
|                         |       +--------------------------------------------+
|                         |       | `[C{D}]`                                   |
+-------------------------+-------+--------------------------------------------+
| `[C{D}]`                | `B`   | `[]`, `B{C{D}}`                            |
|                         |       +--------------------------------------------+
|                         |       | `[B{C{D}}]`                                |
+-------------------------+-------+--------------------------------------------+
| `[B{C{D}}]`             | `F`   | `[B{C{D}}, F]`                             |
+-------------------------+-------+--------------------------------------------+
| `[B{C{D}}, F]`          | `G`   | `[B{C{D}}, F, G]`                          |
+-------------------------+-------+--------------------------------------------+
| `[B{C{D}}, F, G]`       | `E`   | `[B{C{D}}, F]`, `E{G}`                     |
|                         |       +--------------------------------------------+
|                         |       | `[B{C{D}}]`, `E{G, F}`                     |
|                         |       +--------------------------------------------+
|                         |       | `[B{C{D}}, E{F, G}]`                       |
+-------------------------+-------+--------------------------------------------+
| `[B{C{D}}, E{F, G}]`    | `A`   | `[B{C{D}}]`, `A{E{F, G}}`                  |
|                         |       +--------------------------------------------+
|                         |       | `[]`, `A{B{C{D}}, E{F, G}}`                |
|                         |       +--------------------------------------------+
|                         |       | `[A{B{C{D}}, E{F, G}}]`                    |
+-------------------------+-------+--------------------------------------------+
| `[A{B{C{D}}, E{F, G}}]`                                                      |
+------------------------------------------------------------------------------+


Without sandwiching
-------------------

In some languages like Python it makes sense to define block-level delimiters
which have only one delimiter.  Here is an example:

.. code:: python

   def derp():
       for (k, v) in {'a': 1, 'b': 2}:
           print(k, v)

We want to highlight the `def` of the function definition and the `for`/`in` of
the loop.  This means we have a mix of sandwiching and no sandwiching.  The
order of matches is:

#) `def` (because it is completed first)
#) `()` (the parentheses of `def`)
#) `(k, v)` (because it is completed before `for`/`in`)
#) `for`/`in`
#) `{...}`
#) `print(k, v)`

The intended match tree should look like this according to the syntax tree:

.. code::

   def
   ├ ()
   └ for/in
     ├ (k, v)
     ├ {...}
     └ print(k, v)

Eyeballing the code however suggest a match tree like this:

.. code::

   ├def
   └ ()
     ├ for/in
     │ ├ (k, v)
     │ └ print(k, v)
     └ {...}

The idea is that matches which logicaly appear together (such as the head of a
for-loop) should be cousins.  This raises the question of what belongs
together.  I will probably need to add a new capture like `@body` which matches
the delimited content.  In the sandwich case the body was implicitly that which
is between both delimiters, but here we would need to be explicit about it.
Example:

.. code:: query

   (for_statement
     "for" @delimiter
     "in" @delimiter
     body: _ @body) @container

   (list
     "[" @delimiter
     _ @body
     "]" @delimiter) @container

Then a match is a child of a parent if and only if the `@container` of the
child is contained inside the `@body` of the parent.

Not only can the parent-child order be reversed, we can also skip over
generations.  In the above example `(k, v)` is a grandchild of `def`, but it
comes directly after it.  We need to revise the algorithm to account for this
case.  All in all we have the following cases:

- The new node and the top of the stack are cousins
- The new node is an ancestor of the top node
- The new node is a descendant of the top node

Here the term “cousin” is cross-generational, i.e. if A is the parent of B and
C, and D the child of C, then B and D are considered cousins.  They have a
common ancestor, but share no lineage from one to the other.  Siblings are also
considered cousins.


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
