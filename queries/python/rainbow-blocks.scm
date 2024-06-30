; Block specific
(function_definition
  "def" @delimiter
  "->" @delimiter
  ":" @delimiter) @container

(for_statement
  "for" @delimiter
  "in" @delimiter
  ":" @delimiter
  (else_clause
    "else" @delimiter
    ":" @delimiter)?
) @container

(for_in_clause
  "for" @delimiter
  "in" @delimiter) @container

(if_clause
  "if" @delimiter) @container

(conditional_expression
  "if" @delimiter
  "else" @delimiter) @container

(if_statement
  "if" @delimiter
  ":" @delimiter
  (elif_clause
    "elif" @delimiter
    ":" @delimiter)*
  (else_clause
    "else" @delimiter
    ":" @delimiter)?
  ) @container

(match_statement
  "match" @delimiter
  ":" @delimiter) @container

(case_clause
  "case" @delimiter
  ":" @delimiter) @container

(lambda
  "lambda" @delimiter
  ":" @delimiter) @container

(while_statement
  "while" @delimiter
  ":" @delimiter
  (else_clause
    "else" @delimiter
    ":" @delimiter)?
) @container

(try_statement
  "try" @delimiter
  ":" @delimiter
  (except_clause
    "except" @delimiter
    ":" @delimiter)*
  (else_clause
    "else" @delimiter
    ":" @delimiter)?
  (finally_clause
    "finally" @delimiter
    ":" @delimiter)?
) @container

(class_definition
  "class" @delimiter
  ":" @delimiter) @container


; Copied over from rainbow-delimiters
(list
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(list_pattern
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(list_comprehension
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(dictionary
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(dict_pattern
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(dictionary_comprehension
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(set
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(set_comprehension
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(tuple
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(tuple_pattern
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(generator_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parameters
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(argument_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parenthesized_expression
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(subscript
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(type_parameter
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(import_from_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(string
  (interpolation
    "{" @delimiter
    "}" @delimiter @sentinel) @container)
