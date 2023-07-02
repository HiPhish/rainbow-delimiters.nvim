.. default-role:: code

#####################
 Contributor's guide
#####################


Adding support for a new language
#################################

Languages are supported through language-specific queries.  Each language needs
at lease one query which matches the most common delimiters, usually `(`, `)`,
`[`, `]`, `{`, `}`, `<` and `>`.  Read `:h ts-rainbow-custom-queries` in the
manual first to understand how to write queries.  Your query should meet the
following criteria:

- Named `rainbow-delimiters`
- Few if any `@intermediate` capture groups; we do not want the default query
  to be too vibrant
- Write one or more files in the language under `test/highlight/<lang>` (where
  `<lang>` is the language)
- The test code must have at least one instance of each pattern in the query
- The test code must not have parsing errors
- The test code should ideally have multiple levels of nesting
- The test code should compile and have no linter errors if that is feasible
  (this is not a hard rule though)

If there are many test cases or if the code becomes too verbose feel free to
created multiple test files.
