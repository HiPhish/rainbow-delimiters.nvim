.. default-role:: code

###########
 Changelog
###########

All notable changes to this project will be documented in this file. The format
is based on `Keep a Changelog`_ and this project adheres to `Semantic
Versioning`_.


Unreleased
##########

Fixed
=====

- Highlighting wrong in global strategy after making changes inside a nested
  node

Changed
=======

- Queries no longer need the `@sentinel` capture group


[0.6.2] - 2024-09-26
####################

Maintenance release which fixes a number of subtly broken queries.

Added
=====

- SQL: `parenthesized_expression` pattern

Fixed
=====

- Go query: upstream query change, use `var_spec_list` instead of
  `var_declaration`
- C++ query: missing `@container` capture in one pattern
- C++ query: duplicate pattern for `initializer_list`
- Common Lisp query: duplicate extmarks on some delimiters
- Luadoc query: Remove broken pattern for dictionary key type
- Ruby query: duplicate extmarks on some delimiters
- Rust query: duplicate pattern for `closure_parameters`
- SQL query: Remove broken patterns
- Zig query: duplicate extmarks on some delimiters, renamed nodes in updated
  parser
- Make a better effort to make parentheses in Vim script expressions work (there
  is only so much that can be done though)


[0.6.1] - 2024-08-11
####################

Fixed
=====

- Health check is not aware of new `condition` configuration option


[0.6.0] - 2024-08-07
####################

Added
=====

- New option `condition`: allows users to dynamically enable or disable rainbow
  delimiters for a buffer.


[0.5.0] - 2024-07-29
####################

Mostly a maintenance support with added support for a few new languages.

Added
=====
   
- Recipes section in the manual

- New languages:

  - Awk
  - WebGL Shading Language (WGSL)
  - Django HTML (preliminary, will only pass through injected languages)

- Missing patterns:

  - C++

    - `condition_clause`
    - `for_statement`
    - `cast_expression`
    - `array_declarator`

  - C#:
  
    - `tuple_pattern`
  
  - Common Lisp:
  
    - `loop_macro`
  
  - Cue:
  
    - `dynamic`
    - `index_expression`
  
  - Javascript:
  
    - `array_pattern`
    - `for_in_statement`
    - `for_statement`
  
  - Rust:
  
    - `bracketed_type`
  
  - Typescript:
  
    - `enum_body`
    - `interface_body`
  
  - Haskell:
  
    - `children`
    - `fields`
    - `list`
    - `parens`
    - `prefix_id`
    - `record`
    - `tuple`
    - `unit`

Changed
=======

- Renamed patterns:

  - C#:
  
    - `for_each_statement` to `foreach_statement`
    - `type_of_expression` to `typeof_expression`
    - `size_of_expression` to `sizeof_expression`
    - `implicit_stack_alloc_array_creation_expression` to `implicit_stackalloc_expression`

- Updated R patterns for current parser

Removed
=======

- Deprecated patterns:

  - C#:

    - `interpolation`

  - Java:

    - `condition`

  - Haskell:

    - `con_list`
    - `context`
    - `deriving`
    - `exp_arithmetic_sequence`
    - `exp_lambda`
    - `exp_list_comprehension`
    - `exp_list`
    - `exp_name`
    - `exp_record`
    - `exp_section_right`
    - `pat_fields`
    - `pat_list`
    - `pat_parens`
    - `pat_tuple`
    - `record_fields`
    - `type_list`
    - `type_parens`
    - `type_tuple`
    - `type_tuple`


[0.4.0] - 2024-05-07
####################

Added
=====

- Public API function `is_enabled`
- Rasi support
- Svelte support
- Teal support
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

- Missing patterns for Julia:

  - `curly_expression`
  - `tuple_expression`

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

- Missing patterns for R:

  -  `for`
  -  `while`
  -  `switch`
  -  `function_definition`

- Missing patterns for Rust:

  - `array_type`

- Missing patterns for Starlark:

  - `tuple_pattern`

Fixed
=====

- Default configuration settings override custom settings if the configuration
  value was used before setting the custom value
- Switched Fennel queries to new upstream grammar (`#6132`_)
- Deleted obsolete Julia pattern `parameter_list`

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
