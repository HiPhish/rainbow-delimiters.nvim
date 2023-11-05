(parenthesized_expression
    "(" @delimiter
    ")" @delimiter @sentinel) @container

(arguments
    "(" @delimiter
    ")" @delimiter @sentinel) @container

(formal_parameters
    "(" @delimiter
    ")" @delimiter @sentinel) @container

(declaration_list
    "{" @delimiter
    "}" @delimiter @sentinel) @container

(compound_statement
    "{" @delimiter
    "}" @delimiter @sentinel) @container

(encapsed_string
    "{" @delimiter
    "}" @delimiter @sentinel) @container

(array_creation_expression
    "[" @delimiter
    "]" @delimiter @sentinel) @container

(subscript_expression
    "[" @delimiter
    "]" @delimiter @sentinel) @container
