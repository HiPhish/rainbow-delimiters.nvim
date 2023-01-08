.. default-role:: code

#################################
 Hacking on Rainbow Delimiters 2
#################################


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
belong to `Bravo`.  Furthermore, we do now know that `Bravo` is the lowest node
to still contain the cursor.

Therefore we first have to iterate through all captures and fine the lowest
container node which contains the cursor.  Then if a captured node does not
contain the cursor we can check whether it is a descendant of the cursor
container node.
