--[[
   Copyright 2020-2022 Chinmay Dalal

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

---Sets of note types.  When determining the level of a node we want to skip
---through certain node types.  This set contains all the node types which need
---to be counted.
local M = {}
local set = require 'ts-rainbow.set'

local Set = set.Set

M.python = Set(
	'tuple',
	'interpolation',
	'list',
	'dictionary',
	'set',
	'subscript',
	'argument_list',
	'parameters',
	'parenthesized_expression',
	'generator_expression',
	'list_comprehension',
	'dictionary_comprehension',
	'set_comprehension'
)

M.rust = Set(
	'arguments',
	'token_tree',
	'array_expression',
	'attribute_item',
	'block',
	'closure_expression',
	'declaration_list',
	'field_declaration_list',
	'index_expression',
	'macro_definition',
	'macro_rule',
	'match_block',
	'meta_arguments',
	'parameters',
	'parenthesized_expression',
	'struct_expression',
	'tuple_expression',
	'tuple_pattern',
	'tuple_struct_pattern',
	'tuple_type',
	'type_arguments',
	'type_parameters',
	'unit_type',
	'use_list'
)

M.query = Set(
	'grouping',
	'list',
	'named_node'
)

M.c = Set(
	'array_declarator',
	'call_expression',
	'compound_statement',
	'enumerator_list',
	'field_declaration_list',
	'for_statement',
	'function_definition',
	'initializer_list',
	'parameter_list',
	'parenthesized_expression',
	'subscript_expression'
)

M.cpp = M.c + Set(
	'cast_expression',
	'condition_clause',
	'declaration_list',
	'preproc_params',
	'lambda_capture_specifier',
	'template_parameter_list',
	'template_type'
)

M.fennel = Set(
	"for",
	"local",
	'each',
	'each_clause',
	'fn',
	'global',
	'hashfn',
	'lambda',
	'let',
	'let_clause',
	'list',
	'match',
	'parameters',
	'quoted_list',
	'quoted_sequential_table',
	'sequential_table',
	'set',
	'table',
	'var'
)

M.tsx = Set(
	'array',
	'array_pattern',
	'array_type',
	'class_body',
	'call_expression',
	'formal_parameters',
	'jsx_element',
	'jsx_expression',
	'jsx_self_closing_element',
	'object',
	'object_pattern',
	'object_type',
	'parenthesized_expression',
	'statement_block',
	'type_arguments'
)

M.javascript = Set(
	'array',
	'call_expression',
	'class_body',
	'formal_parameters',
	-- NOTE: nvim-treesitter uses the javascript parser for jsx too
	'jsx_element',
	'jsx_expression',
	'jsx_self_closing_element',
	'new_expression',
	'object',
	'parenthesized_expression',
	'statement_block',
	'subscript_expression',
	'template_substitution'
)

M.elixir = Set(
	'arguments',
	'binary',
	'block',
	'interpolation',
	'list',
	'map',
	'sigil',
	'struct',
	'tuple'
)

M.html = Set('element', 'script_element', 'style_element')

M.lua = Set(
	'arguments',
	'bracket_index_expression',
	'parameters',
	'parenthesized_expression',
	'table_constructor'
)

M.commonlisp = Set('list_lit')

M.make = Set(
	'command_substitution',
	'function_call',
	'substitution_reference',
	'variable_reference'
)

return M

-- vim:tw=79:ts=4:sw=4:noet:
