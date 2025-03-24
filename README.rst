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

No configuration is needed to get started, this plugin has reasonable defaults
which you can override.  Configuration is done by setting entries in the Vim
script dictionary `g:rainbow_delimiters`.  Here is an example configuration:

.. code:: vim

   let g:rainbow_delimiters = {
       \ 'strategy': {
           \ '': 'rainbow-delimiters.strategy.global',
           \ 'vim': 'rainbow-delimiters.strategy.local'
       \ },
       \ 'query': {
           \ '': 'rainbow-delimiters',
           \ 'lua': 'rainbow-blocks',
       \ },
       \ 'priority': {
           \ '': 110,
           \ 'lua': 210,
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

   ---@type rainbow_delimiters.config
   vim.g.rainbow_delimiters = {
       strategy = {
           [''] = 'rainbow-delimiters.strategy.global',
           vim = 'rainbow-delimiters.strategy.local',
       },
       query = {
           [''] = 'rainbow-delimiters',
           lua = 'rainbow-blocks',
       },
       priority = {
           [''] = 110,
           lua = 210,
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
function there is the module `rainbow-delimiters.setup` that accepts all the
same parameters as `g:rainbow-delimiters`.

.. code:: lua

   require('rainbow-delimiters.setup').setup {
       strategy = {
           -- ...
       },
       query = {
           -- ...
       },
       highlight = {
           -- ...
       },
   }


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


Screenshots
###########

Bash
====

.. image:: https://github.com/HiPhish/rainbow-delimiters.nvim/assets/4954650/514ed2a2-68a4-427e-aef6-7ac3a02a2ba0
   :alt: Screenshot of a Bash script with alternating coloured delimiters

C
=

.. image:: https://github.com/HiPhish/rainbow-delimiters.nvim/assets/4954650/45f8e727-d507-43df-b112-a269e7262533
   :alt: Screenshot of a C program with alternating coloured delimiters

Common Lisp
===========

.. image:: https://github.com/HiPhish/rainbow-delimiters.nvim/assets/4954650/5e7e15bb-a4e3-41e5-b3fc-3c4150ffd252
   :alt: Screenshot of a Common Lisp program with alternating coloured delimiters

HTML
====

.. image:: https://github.com/HiPhish/rainbow-delimiters.nvim/assets/4954650/371d310c-d5a7-490d-bb55-d3fe4bd8b1a8
   :alt: Screenshot of an HTML document with alternating coloured delimiters

Java
====

.. image:: https://github.com/HiPhish/rainbow-delimiters.nvim/assets/4954650/bb372051-ec5f-4c0b-a9b9-3cd37edafa4f
   :alt: Screenshot of a Java program with alternating coloured delimiters

LaTeX
=====

Using the `rainbow-blocks` query to highlight the entire `\begin` and `\end`
instructions.

.. image:: https://github.com/HiPhish/rainbow-delimiters.nvim/assets/4954650/0176cc0d-b729-417e-8f85-c31da70d49f5
   :alt: Screenshot of a LaTeX document with alternating coloured delimiters

Lua
===

Using the `rainbow-blocks` query to highlight the entire keywords like
`function`, `if`, `else` and `end`.

.. image:: https://github.com/HiPhish/rainbow-delimiters.nvim/assets/4954650/a915f7e0-b1c9-4af2-ae1d-f2f48aa325e5
   :alt: Screenshot of a Lua script with alternating coloured delimiters
