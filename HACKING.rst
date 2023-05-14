.. default-role:: code

#################################
 Hacking on Rainbow Delimiters 2
#################################


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


Testing
#######

We use Vader_ for testing.  Execute `:Vader test/vader/**/*` to run all Vader
tests.  As of the time of writing this there is a bug in Vader: tests contain
Lua code, which will set the file type of the Vader result buffer to `lua`.
This is annoying, but it does not affect the test results.


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


.. _Vader: https://github.com/junegunn/vader.vim
