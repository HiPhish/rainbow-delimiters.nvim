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
- Missing `switch_body` pattern for Javascript and Typescript
- Missing `rec_attrset_expression` and `inherit_from` patterns for Nix
- Missing `array_type` and `slice_expression` patterns for Go
- Missing `feature_query`, `arguments` and `attribute_selector` patterns for
  CSS
- Missing `for_tuple_expr`, `new_index`, `expression`, `binary_operation`,
  `for_object_expr`, `template_interpolation` and `unary_operation` patterns
  for HCL
- Missing `parameters` pattern for SCSS

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
