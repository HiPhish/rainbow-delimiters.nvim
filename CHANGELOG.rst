.. default-role:: code

###########
 Changelog
###########

All notable changes to this project will be documented in this file. The format
is based on `Keep a Changelog`_ and this project adheres to `Semantic
Versioning`_.


Unreleased
##########

Added
=====

- Public API function `is_enabled`
- Rasi support
- Svelte support
- Typst support
- XML support
- Missing patterns for Java:
   - `array_initializer`
   - `annotation_argument_list`
   - `catch_clause`
   - `condition`
   - `constructor_body`
   - `dimensions_expr`
   - `enhanced_for_statement`
   - `for_statement`
   - `inferred_parameters`
   - `parenthesized_expression`
   - `resource_specification`
   - `cast_expression`
- Missing patterns for Go:
   - `type_assertion_expression`
- Missing patterns for Lua:
   - `field`
- Missing patterns for Luadoc:
   - `indexed_field`
   - `tuple_type`
- Missing patterns for Python:
   - `dict_pattern`
   - `import_from_statement`
   - `interpolation` (literal string interpolation)
   - `list_pattern`
   - `tuple_pattern`
- Missing patterns for Rust:
   - `array_type`
- Missing patterns for Starlark:
   - `tuple_pattern`

Fixed
=====

- Default configuration settings override custom settings if the configuration
  value was used before setting the custom value
- Switched Fennel queries to new upstream grammar (`#6132`_)

.. _#6132: https://github.com/nvim-treesitter/nvim-treesitter/pull/6132


[0.3.0] 2023-12-24
##################

This release brings a plethora of missing patterns to existing queries and lets
you specify priorities and queries dynamically at runtime.  This means that it
is possible to set different queries for the same language depending on
external conditions, such as whether a buffer is read-only.

And as a little extra given the date of this release, there is a new Christmas
strategy module.  This will let you decorate your syntax tree in an especially
festive mood.  The module is just a joke, so it will not be loaded by default
and you will have to figure out yourself how to set it up.

Added
=====

- Starlark support
- Missing patterns for Bash:
   - `array`
   - `function_definition`
   - `arithmetic_expansion`
   - `compound_statement`
   - `subscript`
- Missing patterns for C:
   - `enumerator_list`
   - `macro_type_specifier`
   - `preproc_params`
   - `compound_literal_expression`
   - `parenthesized_declarator`
- Missing patterns for Elixir:
   - `access_call`
- Missing patterns for Fennel:
   - `table_binding`
- New query for language `query`:
   - `rainbow-blocks`
- New query for language `javascript`:
   - `rainbow-tags-react`
- New query for language `tsx`:
   - `rainbow-tags-react`
- New Christmas strategy module `rainbow-delimiters.strategy.christmas` (not
  loaded by default)

Fixed
=====

- Query can be a function in configuration
- Priority can be a function in configuration
- Functions in configuration take buffer number as argument
- Updated Nim queries


[0.2.0] - 2023-11-26
####################

Added
=====

- Ability to set highlight priority
- Cue support
- Luadoc support
- Nim support
- Kotlin support
- templ support
- Terraform support
- TOML support

Fixed
=====

- Type error in local strategy
- Log error in local strategy (Neovim <0.10 only)
- Missing patterns for CSS
   - `feature_query`
   - `arguments`
   - `attribute_selector`
- Missing patterns for Go
   - `array_type`
   - `slice_expression`
- Missing patterns for HCL
   - `for_tuple_expr`
   - `new_index`
   - `expression`
   - `binary_operation`
   - `for_object_expr`
   - `template_interpolation`
   - `unary_operation`
- Missing pattern for Javascript and Typescript
   - `switch_body`
- Missing patterns for Nix
   - `rec_attrset_expression`
   - `inherit_from`
- Missing pattern for SCSS
   - `parameters`

Changed
=======

- Default highlight priority is 110 instead of 210, which is between
  Tree-sitter and LSP semantic tokens


[0.1.0] - 2023-11-12
####################

Initial release



.. ----------------------------------------------------------------------------
.. _Keep a Changelog: https://keepachangelog.com/en/1.0.0/,
.. _Semantic Versioning: https://semver.org/spec/v2.0.0.html
