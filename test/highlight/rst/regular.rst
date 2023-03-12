.. default-role:: code

############################
 A reStructuredText example
############################

Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.


Injected languages
##################

Here we test highlighting of an injected


Lua
===

Lua is a good candidate

.. code:: lua

   -- This is a comment

   local function f1(a, b)
	   local function f2(a2, b2)
		   return a2, b2
	   end
	   return f2(a, b)
   end

   print(f1('a', 'b'))
   print((((('Hello, world!')))))

   print {
	   {
		   {
			   'Hello, world!'
		   }
	   }
   }

   local one = {1}

   print(one[one[one[1]]])

   -- Embedded Vim script
   vim.cmd [[
	   echo a(b(c(d(e(f())))))
   ]]

Let's try another embedded language

.. code:: vim

   let g:my_list = [[[1]]]
   let g:my_dict = {
	   \'a': {
		   \'b': {
			   \'c': {},
		   \}
	   \}
   \ }

   echo string(1 + (2 + (3 + 4)))
   echo string(-(3))
   echo string((5)-(3))
   echo string((1) ? (2) : (3))
   echo ((('Hello, world!')))
