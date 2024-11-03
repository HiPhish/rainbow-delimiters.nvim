; match blocks

(seq_block
  "begin" @delimiter
  "end"   @delimiter @sentinel) @container

; match parentheses

(packed_dimension
  "[" @delimiter
  "]" @delimiter @sentinel) @container

(data_type
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(parameter_port_list
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(named_port_connection
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(list_of_port_declarations
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(parameter_value_assignment
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(named_parameter_assignment
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(hierarchical_instance
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(cast
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(conditional_statement
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(event_control
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(primary
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(constant_primary
  "(" @delimiter
  ")" @delimiter @sentinel) @container

(concatenation
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(constant_concatenation
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(multiple_concatenation
  "{" @delimiter
  "}" @delimiter @sentinel) @container

(bit_select
  "[" @delimiter
  "]" @delimiter @sentinel) @container
