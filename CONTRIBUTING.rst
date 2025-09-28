.. default-role:: code

#####################
 Contributor's guide
#####################


Developer's setup
#################

You will need the following on your system:

- `tree-sitter` CLI tool
- LuaRocks_
- `busted` installed from LuaRocks for Lua 5.1

Next, install the development dependencies from Git submodules.

.. code:: sh

   git submodule init
   git submodule update --checkout

The first test run will install and compile Tree-sitter parsers as needed,
which may take a while.


Adding support for a new language
#################################

Languages are supported through language-specific queries.  Each language needs
at lease one query which matches the most common delimiters, usually `(`, `)`,
`[`, `]`, `{`, `}`, `<` and `>`.  Read `:h rb-delimiters-custom-query` in the
manual first to understand how to write queries.  Your query should meet the
following criteria:

- Named `rainbow-delimiters`
- Few `@delimiter` capture groups per `@container`; we do not want the default
  query to be too vibrant
- Write one or more files in the language under `test/highlight/<lang>` (where
  `<lang>` is the language); the standard file name is `regular.<ext>`
- The test code must have at least one instance of each pattern in the query
- The test code must not have parsing errors
- The test code should ideally have multiple levels of nesting
- The test code should compile and have no linter errors if that is feasible
  (this is not a hard rule though)

If there are many test cases or if the code becomes too verbose feel free to
create multiple test files.

In addition to the queries and test file(s), please consider adding the type
annotations in `lua/rainbow-delimiters.types.lua` if you are adding queries
for a new language. You will need to update:

- `@class rainbow_delimiters.config.strategies`
- `@class rainbow_delimiters.config.queries`
- `@class rainbow_delimiters.config.priorities`
- `@alias rainbow_delimiters.language`


.. _LuaRocks: https://luarocks.org/
