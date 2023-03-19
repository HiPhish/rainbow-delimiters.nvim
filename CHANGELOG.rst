.. default-role:: code

###########
 Changelog
###########

All notable changes to this project will be documented in this file. The format
is based on `Keep a Changelog`_ and this project adheres to `Semantic
Versioning`_.


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
