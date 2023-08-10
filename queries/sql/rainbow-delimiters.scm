(subquery
    "(" @opening
    ")" @closing) @container

(invocation
    "(" @opening
    ")" @closing) @container

(list
    "(" @opening
    ")" @closing) @container

;; A parenthesized expression; the delimiters are actually outside the
;; expression, but that's OK because the nesting level only looks at containers
(
    "(" @opening
    .
    [
        (binary_expression)
        (literal)
    ] @container
    .
    ")" @closing
)
