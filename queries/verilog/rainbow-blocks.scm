; match blocks

(seq_block
    "begin" @opening
    "end" @closing
) @container

; match parentheses

(packed_dimension
    "[" @opening
    "]" @closing
) @container

(data_type
    "{" @opening
    "}" @closing
) @container

(named_port_connection
    "(" @opening
    ")" @closing
) @container

(named_parameter_assignment
    "(" @opening
    ")" @closing
) @container

(hierarchical_instance
    "(" @opening
    ")" @closing
) @container

(parameter_value_assignment
    "(" @opening
    ")" @closing
) @container

(parameter_port_list
    "(" @opening
    ")" @closing
) @container

(list_of_port_declarations
    "(" @opening
    ")" @closing
) @container

(cast
    "(" @opening
    ")" @closing
) @container

(conditional_statement
    "(" @opening
    ")" @closing
) @container

(event_control
    "(" @begin
    ")" @end
) @container

(primary
    "(" @begin
    ")" @end
) @container

