(jsx_opening_element
   "<" @left-tag-start
   name: _ @left
   ">" @left-tag-end) 

(jsx_self_closing_element
   "<"+ @self-closing-tag-start
   name: _ @self-closing (#jsx-extended-rainbow-mode?)
   ; Combining "/" with "<" results in no JSX highlights
   ["/" ">"]+ @self-closing-tag-end) 

(jsx_closing_element
   ; Combining "/" with "<" results in no JSX highlights
   ["<" "/"]+ @right-tag-start
   name: _ @right
   ">" @right-tag-end) 
