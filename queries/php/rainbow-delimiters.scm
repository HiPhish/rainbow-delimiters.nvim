(parenthesized_expression
    "(" @opening
    ")" @closing) @container

(arguments
    "(" @opening
    ")" @closing) @container

(formal_parameters
    "(" @opening
    ")" @closing) @container

(declaration_list
    "{" @opening
    "}" @closing) @container

(compound_statement
    "{" @opening
    "}" @closing) @container

(array_creation_expression
    "[" @opening
    "]" @closing) @container

(subscript_expression
    "[" @opening
    "]" @closing) @container
