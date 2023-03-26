.. default-role:: code


###############################
 Rainbow delimiters for Neovim
###############################

This Neovim plugin provides alternating syntax highlighting (“rainbow
parentheses”) for Neovim, powered by `Tree-sitter`_.  The goal is to have a
hackable plugin which allows for different configuration of queries and
strategies, both globally and per file type.  Users can override and extend the
built-in defaults through their own configuration.


Installation and setup
######################

Installation
============

The plugin depends on `nvim-treesitter`_.  Other than that it is installed like
any other Neovim plugin.

Setup
=====

Since this is a module for nvim-treesitter you need to setup everything in its
configuration.  Here is an example:

.. code:: lua

   require("nvim-treesitter.configs").setup {
     rainbow = {
       enable = true,
       -- list of languages you want to disable the plugin for
       disable = { "jsx", "cpp" }, 
       -- Which query to use for finding delimiters
       query = 'rainbow-parens',
       -- Highlight the entire buffer all at once
       strategy = require 'ts-rainbow'.strategy.global,
     }
   }

Please refer to the documentation for more details.


Help wanted
###########

There are only so many languages which I understand to the point that I can
write queries for them.  If you want support for a new language please consider
contributing code.  See the CONTRIBUTING_ for details.


Status of the plugin
####################

Tree-sitter support in Neovim is still experimental.  This plugin and its API
should be considered stable insofar as breaking changes will only happen if
changes to Neovim necessitates them.

.. warning::

   There is currently a shortcoming in Neovim's Tree-sitter API which makes it
   so that only the first node of a capture group can be highlighted.  Please
   see `neovim/neovim#17099`for details.  Affected queries:

   - HTML `rainbow-parens`
   - JSX (Javascript + React.js) `rainbow-parens-react` (affects React tags
     only)
   - Python (`rainbow-parens`) (affects only the `for ... in` inside
     comprehensions)
   - TSX (Typescript + React.js) `rainbow-parens-react` (affects React tags
     only)
   - Vue.js `rainbow-parens`

   Most of these are related to HTML-like tags, so you can use an alternative
   query instead.  See the manual_ (`:h ts-rainbow-query`) for a list of extra
   queries.


Screenshots
###########

Bash
====

.. image:: https://user-images.githubusercontent.com/4954650/212133420-4eec7fd3-9458-42ef-ba11-43c1ad9db26b.png

C
=

.. image:: https://user-images.githubusercontent.com/4954650/212133423-8b4f1f00-634a-42c1-9ebc-69f8057a63e6.png

Common Lisp
===========

.. image:: https://user-images.githubusercontent.com/4954650/212133425-85496400-4e24-4afd-805c-55ca3665c4d9.png

Java
====

.. image:: https://user-images.githubusercontent.com/4954650/212133426-7615f902-e39f-4625-bb91-2e757233c7ba.png

LaTeX
=====

Using the `blocks` query to highlight the entire `\begin` and `\end`
instructions.

.. image:: https://user-images.githubusercontent.com/4954650/212133427-46182f57-bfd8-4cbe-be1f-9aad5ddfd796.png


License
#######

Licensed under the Apache-2.0 license. Please see the `LICENSE`_ file for
details.


Attribution
###########

This is a fork of a previous Neovim plugin, the original repository is
available under https://sr.ht/~p00f/nvim-ts-rainbow/.

Attributions from the original author
=====================================

Huge thanks to @vigoux, @theHamsta, @sogaiu, @bfredl and @sunjon and
@steelsojka for all their help


.. _Tree-sitter: https://tree-sitter.github.io/tree-sitter/
.. _nvim-treesitter: https://github.com/nvim-treesitter/nvim-treesitter
.. _CONTRIBUTING: CONTRIBUTING.rst
.. _LICENSE: LICENSE
.. _manual: doc/ts-rainbow.txt
.. _neovim/neovim#17099: https://github.com/neovim/neovim/pull/17099
