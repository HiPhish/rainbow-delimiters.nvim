.. default-role:: code

#######################
 Plans for this plugin
#######################


Performance of the local strategy
#################################

The local strategy can get quite slow in large files.  This is due to the
frequent ancestry checks when iterating through the matches.  There needs to be
some way of cutting down on ancestry checks by using the order of matches.


Built-in queries
################

Queries for all languages I know have now been ported.


Queries which I cannot port
===========================

I do not know enough about the following languages in order to write good
queries.  Contributions are welcome.

- clojure
- cuda
- dart
- devicetree
- elixir
- elm
- fennel
- fish
- gdscript
- go
- graphql
- haskell
- hcl
- julia
- kotlin
- meson
- nix
- ocaml
- ocaml_interface
- php
- r
- ruby
- scala
- scss
- solidity
- sparql
- supercollider
- svelte
- tsx
- turtle
- verilog
- vue
- zig
