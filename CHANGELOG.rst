.. default-role:: code

###########
 Changelog
###########

All notable changes to this project will be documented in this file. The format
is based on `Keep a Changelog`_ and this project adheres to `Semantic
Versioning`_.


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
