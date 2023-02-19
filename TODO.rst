.. default-role:: code

#######################
 Plans for this plugin
#######################


API
###

- Do we really need `get_query` in the public API? Maybe we can store the value
  in the buffer settings.
- Should `buffer_config` be a read-only proxy table for the actual config
  table?


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
