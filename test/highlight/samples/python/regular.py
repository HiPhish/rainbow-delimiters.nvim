# NOTE: When updating this file update the Starlark test file as well if
# applicable.

from typing import (
    Dict,
    List,
)


def sum_list(lst: List[Dict[int, int]]) -> int:
    result = 0
    for inner in lst:
        for i in inner:
            result += i
    return result


my_list = [[['Hello, world!']]]
my_dict = {'x': {'x': {'x': 'Hello, wold!'}}}
my_set = {{{{'Hello, wold!'}}}}
my_tuple = (((('Hello, wold!'),),),)

list_comp = [i for i in [j for j in range(5)] if i % 2 == 0]
dict_comp = {k: v for k, v in {k: v for k, v in {'k': 'v'}.items()}
             if k == 'k'}
set_comp = {i for i in {j for j in range(5)} if i % 2 == 0}
gen_comp = (i for i in (j for j in range(5)) if i % 2 == 0)

match my_dict:
    case {'x': {'x': {'x': message}}}:
        print(message)
    case [[[message]]]:
        print(message)
    case (((message))):
        print(message)

zero = [0]

(a,b) = (1,2)
[c,d] = [3,4]

print(zero[zero[zero[0]]])


print(2 + ((((3)))))
print(len(my_list))

# Format-string with embedded delimiters
print(f'The sum of 2 and 3 is {2 + (1 + 2)}')
