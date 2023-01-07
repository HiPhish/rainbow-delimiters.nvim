.. default-role:: code


###############################
 Rainbow delimiters for Neovim
###############################

This Neovim plugin provides alternating syntax highlighting (“rainbow
parentheses”) for Neovim, powered by `Tree-sitter`_.  The goal is to have a
hackable plugin which allows for different configuration of queries and
strategies, both globally and per file type.


.. warning::

   The original plugin has been declared abandoned by its author as of
   2023-01-02. This is a hard fork which aim to make the plugin more hackable
   and flexible. This will mean breaking the configuration API.

   As long as this notice in place the plugin is in a limbo state between
   original and fork and breaking changes can occur at any moment.  Please
   stick with the original for the time being, there is a lot to refactor at
   the moment.


Installation and setup
######################

The queries might be out of date at any time, keeping up with them for
languages I don't use is not feasible. If you get errors like `invalid node at
position xxx`, try removing this plugin first before opening an issue in
nvim-treesitter. If it fixes the problem, open an issue/PR here.

Installation
============

The plugin depends on `nvim-treesitter`_.  Other than that it is installed like
any other Neovim plugin.

Setup
=====

Since this is a module for nvim-treesitter you need to setup everything there.
Here is an example:

.. code:: lua

   require("nvim-treesitter.configs").setup {
     highlight = {
         -- ...
     },
     -- ...
     rainbow = {
       enable = true,
       -- list of languages you want to disable the plugin for
       disable = { "jsx", "cpp" }, 
       -- Which query to use for finding delimiters
       query = 'parens',
       -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
       extended_mode = true,
       -- Do not enable for files with more than n lines, int
       max_file_lines = nil,
     }
   }

If you want to enable it only for some filetypes and disable it for everything
else, see
https://github.com/p00f/nvim-ts-rainbow/issues/30#issuecomment-850991264

Colours
-------

Colours are defined by the highlight listed in the `hlgroups` setup parameter.
The plugin will cycle through these groups in the given order.  The default
groups are

.. code:: lua

   require('nvim-treesitter.configs').setup {
     rainbow = {
       -- Setting colors
       hlgroups = {
         'TSRainbowRed',
         'TSRainbowYellow',
         'TSRainbowBlue',
         'TSRainbowGreen',
         'TSRainbowCyan',
         'TSRainbowOrange',
         'TSRainbowViolet',
       },
     }
   }

The order is intentionally different from the colours of a rainbow to ensure a
hard contras between adjacent delimiters.  You can change the order, remove or
add highlight groups and even specify your own groups.

To customise the colours I recommend redefining the standard groups.

.. code:: vim

   " Link a highlight group from a theme
   highlight link TSRainbowRed MyThemeRed
   " Define your own colours
   highlight TSRainbowRed guifg=#ff0000 ctermfg=Red

You will probably want to have different colours per theme.  Since most themes
will lack definitions for the above groups you will need to hook in somehow.  A
simple solution is the use of an autocommand.

.. code:: vim

   autocmd ColorSchemePre MyTheme highlight link TSRainbow MyThemeRed
   " and so on...


Query
-----

In order to know what exactly constitutes a delimiter the plugin needs a
Tree-sitter query.  The name of the query is given in the `query` configuration
option.  The value can be one of the following:

- A string applies the same query for all languages
- A table where the first item is the name of the universal query
- A table where the key is the name of the language and the value is the name
  of the query

The latter two can be combined together.

Example:

.. code:: lua

   -- One query for all languages
   'parens'

   -- Same as above
   {'parens'}

   -- Use 'whatever' for Lua, the default query otherwise
   {html = 'tags'}

   -- Explicit default with override for Lua
   {'parens', html = 'tags'}

The following queries are defined by default:

`parens`
   Parentheses, works for all languages. These can be round, square, curly or
   angular depending on the particular languages.
`tags` (HTML)
   HTML tags
`blocks` (LaTeX, Verilog)
   Blocks made up of pairs of words like `begin` and `end`

Currently it is not possible to combine queries on the fly, so all queries
include the `parens` query.  This means for example if you choose `blocks` as
the query for LaTeX you will get rainbow highlighting for `\begin` and `\end`
blocks, as well as for parentheses.  You will have to create a custom query
(let's call it `only-blocks`) and copy-paste the queries you want from the
`blocks` query.


Screenshots
###########

Java
====

.. image:: https://raw.githubusercontent.com/p00f/nvim-ts-rainbow/master/screenshots/java.png

![alt text]()

The screenshots below use a different color scheme.

Fennel
======

.. image:: https://raw.githubusercontent.com/p00f/nvim-ts-rainbow/master/screenshots/fnlwezterm.png
.. image:: https://raw.githubusercontent.com/p00f/nvim-ts-rainbow/master/screenshots/fnltreesitter.png


C++
===

.. image:: https://raw.githubusercontent.com/p00f/nvim-ts-rainbow/master/screenshots/cpp.png

Latex
=====

With tag begin-end matching

.. image:: https://raw.githubusercontent.com/p00f/nvim-ts-rainbow/master/screenshots/latex_.png


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
.. _LICENSE: LICENSE
   
