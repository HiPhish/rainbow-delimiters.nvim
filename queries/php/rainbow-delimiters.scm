(parenthesized_expression
    "(" @delimiter
    ")" @delimiter) @container

(arguments
    "(" @delimiter
    ")" @delimiter) @container

(formal_parameters
    "(" @delimiter
    ")" @delimiter) @container

(declaration_list
    "{" @delimiter
    "}" @delimiter) @container

(compound_statement
    "{" @delimiter
    "}" @delimiter) @container

(encapsed_string
    ("{" @delimiter
      (variable_name)
     "}" @delimiter
     (string_content)?)+) @container

(array_creation_expression
    "[" @delimiter
    "]" @delimiter) @container

(subscript_expression
    "[" @delimiter
    "]" @delimiter) @container
