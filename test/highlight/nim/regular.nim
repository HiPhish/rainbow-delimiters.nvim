# parameter_declaration_list and generic_parameter_list
proc p[T: seq[int]](a: seq[seq[int]]): int =
  result = 1

let
  # array
  a = [[[1], [1]], [[1], [1]]]
  # tuple and tuple_deconstruct_declaration
  (((q), (_)), ((p), (_))) = (((1, ), (1, )), ((1, ), (1, )))
  # set
  c = {'a'}
  # table
  d = {1: {1: {: }, 2: {: }}, 2: {1: {: }, 2: {: }}}
  # parenthesized
  e = (((
    discard;
    discard;
    1)))
  # call and bracket_expression
  f = p[seq[int]](@[@[p[seq[int]](@[@[1]])]])

# cast and field_declaration_list
cast[tuple[a: seq[int], ]](p[seq[int]](@[@[1]]))

# term_rewriting_pattern and curly_expression
template t{(0|1|2){x}}(x: untyped): untyped = x + 1
