(subquery
    "(" @opening
    ")" @closing) @container

(invocation
    "(" @opening
    ")" @closing) @container

(list
    "(" @opening
    ")" @closing) @container

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
