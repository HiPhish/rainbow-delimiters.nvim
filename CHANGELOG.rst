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

- Support for Haskell
- Support for Nix
- Support for Julia
- Support for Dart
- Support for R (`r`)
- Support for Zig (`zig`)
- Compatibility with Tree-sitter API in Neovim 0.9
- Go queries for nodes `interface_type`, `map_type` and `var_declaration`
- Query `rainbow-tags` for Vue.js

Fixed
=====

- Lua query now includes `parameters` pattern
- LaTeX query now includes `curly_group_text` and `curly_group_text_list`
- Protection from sourcing the plugin multiple times
- Inconsistent pairs due to uncleared extmarks


[2.1.0] - 2023-03-19
####################

This release brings with it bugfixes and support for new file types.  A very
big Thank You to all who have contributed their efforts.

Fixed
=====

- Highlight groups getting cleared when colour scheme is reloaded
- Null-dereference error if an injected language does not have a query define

Added
=====

- Query `rainbow-tags` for HTML includes `style` and `script` tags
- Query `rainbow-parens` for Javascript includes `parenthesized_expression` and
  `subscript_expression`
- Support for reStructuredText (`rst`)
- Support for Markdown (`markdown`)
- Support for Vue.js (`vue`)
- Support for Fennel (`fennel`)
- Support for React.js (part of Javascript support)
- Support for React.js in Typescript (`tsx`)


[2.0.0] - 2023-03-02
####################

Initial release of the new fork from the original.



.. ----------------------------------------------------------------------------
.. _Keep a Changelog: https://keepachangelog.com/en/1.0.0/,
.. _Semantic Versioning: https://semver.org/spec/v2.0.0.html
