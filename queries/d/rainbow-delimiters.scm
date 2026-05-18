(parameters
  "(" @delimiter
  ")" @delimiter) @container

(named_arguments
  "(" @delimiter
  ")" @delimiter) @container

(primary_expression
  "(" @delimiter
  ")" @delimiter) @container

(aggregate_body
  "{" @delimiter
  "}" @delimiter) @container

(block_statement
  "{" @delimiter
  "}" @delimiter) @container


(index_expression
  "[" @delimiter
  "]" @delimiter) @container

(array_literal
  "[" @delimiter
  "]" @delimiter) @container

(type ; string[]
  "[" @delimiter
  "]" @delimiter) @container

(if_condition
  "(" @delimiter
  ")" @delimiter) @container

(for_statement
  "(" @delimiter
  ")" @delimiter) @container

(foreach_statement
  "(" @delimiter
  ")" @delimiter) @container

(in_contract_expression
  "(" @delimiter
  ")" @delimiter) @container

(out_contract_expression
  "(" @delimiter
  ")" @delimiter) @container

(cast_expression
  "(" @delimiter
  ")" @delimiter) @container

(template_arguments
  "(" @delimiter
  ")" @delimiter) @container

(template_parameters
  "(" @delimiter
  ")" @delimiter) @container


