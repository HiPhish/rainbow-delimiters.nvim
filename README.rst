.. default-role:: code


###############################
 Rainbow delimiters for Neovim
###############################

This Neovim plugin provides alternating syntax highlighting (“rainbow
parentheses”) for Neovim, powered by `Tree-sitter`_.  The goal is to have a
hackable plugin which allows for different configuration of queries and
strategies, both globally and per file type.  Users can override and extend the
built-in defaults through their own configuration.

This is a fork of `nvim-ts-rainbow2`_, which was implemented as a module for
`nvim-treessiter`_.  However, since nvim-treesitter has deprecated the module
system I had to create this standalone plugin.


Installation and setup
######################

Installation
============

Install it like any other Neovim plugin.  You will need a Tree-sitter parser
for each language you want to use rainbow delimiters with.

Setup
=====

Configuration is done by setting entries in the Vim script dictionary
`g:rainbow_delimiters`.  Here is an example for the default configuration:

.. code:: vim

   let g:rainbow_delimiters = {
       \ 'strategy': {
           \ '': rainbow_delimiters#strategy.global,
           \ 'vim': rainbow_delimiters#strategy.local,
       \ },
       \ 'query': {
           \ '': 'rainbow-delimiters',
           \ 'lua': 'rainbow-blocks',
       \ },
       \ 'highlight': [
           \ 'RainbowDelimiterRed',
           \ 'RainbowDelimiterYellow',
           \ 'RainbowDelimiterBlue',
           \ 'RainbowDelimiterOrange',
           \ 'RainbowDelimiterGreen',
           \ 'RainbowDelimiterViolet',
           \ 'RainbowDelimiterCyan',
       \ ], 
   \ }

The equivalent code in Lua:

.. code:: lua

   -- This module contains a number of default definitions
   local rainbow_delimiters = require 'rainbow-delimiters'

   vim.g.rainbow_delimiters = {
       strategy = {
           [''] = rainbow_delimiters.strategy['global'],
           vim = rainbow_delimiters.strategy['local'],
       },
       query = {
           [''] = 'rainbow-delimiters',
           lua = 'rainbow-blocks',
       },
       highlight = {
           'RainbowDelimiterRed',
           'RainbowDelimiterYellow',
           'RainbowDelimiterBlue',
           'RainbowDelimiterOrange',
           'RainbowDelimiterGreen',
           'RainbowDelimiterViolet',
           'RainbowDelimiterCyan',
       },
   }

Please refer to the `manual`_ for more details.  For those who prefer a `setup`
function there is the module `rainbow-delimiters.setup`.


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
   see `neovim/neovim#17099`_ for details.  Affected queries:

   - HTML `rainbow-delimiters`
   - JSX (Javascript + React.js) `rainbow-delimiters-react` (affects React tags
     only)
   - Python (`rainbow-delimiters`) (affects only the `for ... in` inside
     comprehensions)
   - TSX (Typescript + React.js) `rainbow-delimiters-react` (affects React tags
     only)
   - Vue.js `rainbow-delimiters`

   Most of these are related to HTML-like tags, so you can use an alternative
   query instead.  See the manual_ (`:h ts-rainbow-query`) for a list of extra
   queries.


Screenshots
###########

Bash
====

.. image:: https://user-images.githubusercontent.com/4954650/212133420-4eec7fd3-9458-42ef-ba11-43c1ad9db26b.png
   :alt: Screenshot of a Bash script with alternating coloured delimiters

C
=

.. image:: https://user-images.githubusercontent.com/4954650/212133423-8b4f1f00-634a-42c1-9ebc-69f8057a63e6.png
   :alt: Screenshot of a C program with alternating coloured delimiters

Common Lisp
===========

.. image:: https://user-images.githubusercontent.com/4954650/212133425-85496400-4e24-4afd-805c-55ca3665c4d9.png
   :alt: Screenshot of a Common Lisp program with alternating coloured delimiters

Java
====

.. image:: https://user-images.githubusercontent.com/4954650/212133426-7615f902-e39f-4625-bb91-2e757233c7ba.png
   :alt: Screenshot of a Java program with alternating coloured delimiters

LaTeX
=====

Using the `blocks` query to highlight the entire `\begin` and `\end`
instructions.

.. image:: https://user-images.githubusercontent.com/4954650/212133427-46182f57-bfd8-4cbe-be1f-9aad5ddfd796.png
   :alt: Screenshot of a LaTeX document with alternating coloured delimiters


License
#######

Licensed under the Apache-2.0 license. Please see the `LICENSE`_ file for
details.


Migrating from nvim-ts-rainbow2
###############################

Rainbow-Delimiters uses different settings than nvim-ts-rainbow2, but
converting the configuration is straight-forward.  The biggest change is where
the settings are stored.

- Settings are stored in the global variable `g:rainbow-delimiters`, which has
  the same keys as the old settings
- The default strategy and query have index `''` (empty string) instead of `1`
- Default highlight groups have the prefix `RainbowDelimiter` instead of
  `TSRainbow`, e.g. `RainbowDelimiterRed` instead of `TSRainbowRed`
- The default query is now called `rainbow-delimiters` instead of
  `rainbow-parens`
- The public Lua module is called `rainbow-delimiters` instead of `ts-rainbow`

The name of the default query is now `rainbow-delimiters` because for some
languages like HTML the notion of "parentheses" does not make any sense.  In
HTML the only meaningful delimiter is the tag.  Hence the generic notion of a
"delimiter".


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
.. _manual: doc/rainbow-delimiters.txt
.. _neovim/neovim#17099: https://github.com/neovim/neovim/pull/17099
.. _nvim-ts-rainbow2: https://gitlab.com/HiPhish/nvim-ts-rainbow2
.. _nvim-treessiter: https://github.com/nvim-treesitter/nvim-treesitter
