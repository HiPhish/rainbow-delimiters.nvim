--[[
   Copyright 2023 Alejandro "HiPhish" Sanchez

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

	   http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
--]]

local Set = require 'ts-rainbow.set'

---Maps each language to a mapping of query name to container node names.
local M = {
	bash = {
		['rainbow-parens'] = Set.new {
			'command_substitution',
			'expansion',
			'test_command',
			'subshell',
		},
	},
	c = {
		['rainbow-parens'] = Set.new {
			'parameter_list',
			'argument_list',
			'parenthesized_expression',
			'compound_statement',
			'initializer_list',
			'subscript_expression',
			'field_declaration_list',
		},
	},
	c_sharp = {
		['rainbow-parens'] = Set.new {
			'parenthesized_expression',
			'declaration_list',
			'block',
			'type_argument_list',
			'initializer_expression',
			'array_rank_specifier',
			'bracketed_argument_list',
		},
	},
	commonlisp = {
		['rainbow-parens'] = Set.new {'list_lit', 'defun'},
	},
	css = {
		['rainbow-parens'] = Set.new {'block', 'parenthesized_query'},
	},
	html = {
		['rainbow-parens'] = Set.new {'element'},
		['rainbow-tags'  ] = Set.new {'element'},
	},
	java = {
		['rainbow-parens'] = Set.new {
			'class_body',
			'block',
			'formal_parameters',
			'argument_list',
			'dimensions',
			'array_access',
			'type_arguments',
		},
	},
	javascript = {
		['rainbow-parens'] = Set.new {
			'template_substitution',
			'object',
			'statement_block',
			'class_body',
			'arguments',
			'formal_parameters',
		},
	},
	json = {
		['rainbow-parens'] = Set.new {'object', 'array'},
	},
	latex = {
		['rainbow-parens'] = Set.new {'curly_group', 'inline_formula'},
		['rainbow-blocks'] = Set.new {
			'inline_formula', 'generic_environment', 'math_environment'
		},
	},
	lua = {
		['rainbow-parens'] = Set.new {
			'arguments',
			'parenthesized_expression',
			'table_constructor',
			'bracket_index_expression',
		},
	},
	make = {
		['rainbow-parens'] = Set.new {},
	},
	python = {
		['rainbow-parens'] = Set.new {
			'list',
			'list_comprehension',
			'dictionary',
			'dictionary_comprehension',
			'set',
			'set_comprehension',
			'tuple',
			'generator_expression',
			'argument_list',
			'parenthesized_expression',
			'subscript',
		},
	},
	query = {
		['rainbow-parens'] = Set.new {'named_node', 'list'},
	},
	racket = {
		['rainbow-parens'] = Set.new {'list'},
	},
	regex = {
		['rainbow-parens'] = Set.new {
			'anonymous_capturing_group',
			'character_class',
			'count_quantifier',
			'lookahead_assertion',
		},
	},
	rust = {
		['rainbow-parens'] = Set.new {
			'parenthesized_expression',
			'declaration_list',
			'field_declaration_list',
			'ordered_field_declaration_list',
			'enum_variant_list',
			'use_list',
			'field_initializer_list',
			'parameters',
			'arguments',
			'block',
			'match_block',
			'tuple_expression',
			'tuple_type',
			'token_tree',
			'token_tree',
			'token_tree',
			'token_tree_pattern',
			'token_repetition_pattern',
			'attribute_item',
			'inner_attribute_item',
			'type_arguments',
			'type_parameters',
			'closure_parameters',
			'array_expression',
			'index_expression',
			'tuple_struct_pattern',
			'tuple_pattern',
			'struct_pattern',
			'slice_pattern',
		},
	},
	scheme = {
		['rainbow-parens'] = Set.new {'list'},
	},
	vim = {
		['rainbow-parens'] = Set.new {
			'list',
			'dictionary',
			'call_expression',
			'unary_operation',
			'binary_operation',
			'ternary_expression',
		},
	},
	yaml = {
		['rainbow-parens'] = Set.new {'flow_mapping', 'flow_sequence'},
	},
}

M.cpp = {
	['rainbow-parens'] = M.c['rainbow-parens'] + Set.new {'template_parameter_list', 'initializer_list'}
}
M.json5 = M.json
M.jsonc = M.json
M.typescript = M.javascript + Set.new{'type_parameters'}

return M
