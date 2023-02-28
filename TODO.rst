.. default-role:: code

#######################
 Plans for this plugin
#######################


Opt-out functionality
#####################

If the query or strategy is `nil` the plugin should not be enabled for that
langauge.  This can remove the need for the `max_file_lines` setting.


Built-in queries
################

Queries for all languages I know have now been ported.

A buffer may contain injected languages, I need to make sure this is supported
as well.

As of version 0.8.3 Neovim can only match one node per query.  This is a
limitation of Neovim and there is nothing that can be done on this end.


Queries which I cannot port
===========================

I do not know enough about the following languages in order to write good
queries.  Contributions are welcome.

- cuda
- dart
- devicetree
- elixir
- elm
- fennel
- fish
- gdscript
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
