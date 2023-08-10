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

;; Commented out until https://github.com/neovim/neovim/pull/17099 is resolved
; (encapsed_string
;     "{" @opening
;     "}" @closing) @container

(array_creation_expression
    "[" @opening
    "]" @closing) @container

(subscript_expression
    "[" @opening
    "]" @closing) @container
