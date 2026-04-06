.. default-role:: code

#######################
 Plans for this plugin
#######################


Break legacy compatibility
##########################

Here are plans for dropping support for certain Neovim versions in a controlled
manner.

Neovim 0.10
===========

The `Query:iter_matches()` method in 0.10 and prior would only produce the
first matching node of the query, but from 0.11 onwards it produces a list of
nodes.  To help bridge this transition the `all` keyword parameter was
introduced (`true` would be the default behaviour, `false` the legacy
behaviour).  In 0.12 this option was removed.

We only ever use the new behaviour in our code, so we could just remove the
options and break backwards compatibility with 0.10.


Built-in queries
################

As of version 0.8.3 until (excluding) version 0.10.0 Neovim can only match one
node per query.  This is a limitation of Neovim and there is nothing that could
be done on this end.

As of version 0.10.0 we could use `iter_matches` for highlighting.

As of version 0.10.0 updating the highlighting of a nested node is messed up.
This is because the undocumented behaviour of `iter_captures` was changed.
This is a good opportunity to switch back to `iter_matches`.


Insufficient information from parsers
#####################################

Some languages do not have a container node for parenthesized expressions,
which makes it impossible to write queries which can reliable determine
nesting.  We can either just give up and not try or make a best-effort attempt
and if the highlighting messed up then so be it.

Affected languages:

- Elm
- SQL
- Vim script


Queries which I cannot port
===========================

I do not know enough about the following languages in order to write good
queries.  Contributions are welcome.

- devicetree
- gdscript
- graphql
- meson
- ocaml
- ocaml_interface
- scala
- solidity
- sparql
- supercollider
- turtle
