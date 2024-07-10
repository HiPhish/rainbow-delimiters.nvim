# NOTE: When updating this file update the Starlark test file as well if
# applicable.

from typing import (
    Dict,
    List,
)


def sum_list(lst: List[Dict[int, int]]) -> int:
    result = 0
    tmp = {'a': (1-2), 'b': (2+1), 'c': { 'd': 1 }, 'e': { 'f': 2 }}
    assert tmp['a'] == -1
    if tmp['a']:
        pass
    if tmp['b'] == 3:
        print('good')
    elif tmp['a'] == tmp['b']:
        print('error')
    elif tmp['a'] == tmp['b'] + 1:
        print('error')
    else:
        print('bad')
    for inner in lst:
        for i in inner:
            result += i
    while True:
        if True:
            break
    return result


my_list = [[['Hello, world!']]]
my_dict = {'x': {'x': {'x': 'Hello, wold!'}}}
my_set = {{{{'Hello, wold!'}}}}
my_tuple = (((('Hello, wold!'),),),)
my_if_else = 1 if True else 0
one, two = 1, 2
my_f_str = (f"one = {one}, two = {two}")
my_lambda = lambda x: x*x

list_comp = [i for i in [j for j in range(5)] if i % 2 == 0]
dict_comp = {k: v for k, v in {k: v for k, v in {'k': 'v'}.items()}
             if k == 'k'}
set_comp = {i for i in {j for j in range(5)} if i % 2 == 0}
gen_comp = (i for i in (j for j in range(5)) if i % 2 == 0)
tuple_in_list_comp = [(i,j) for i in range(5) for j in range(5)]

match my_dict:
    case {'x': {'x': {'x': message}}}:
        print(message)
    case [[[message]]]:
        print(message)
    case (((message))):
        print(message)

while False:
    pass
else:
    print("while else")

for i in range(1):
    pass
else:
    print("for else")

try:
    print('try')
except NameError:
    print('except with err')
except:
    print('except')
else:
    print('no exception')
finally:
    print('more code')


zero = [0]

(a,b) = (1,2)
[c,d] = [3,4]

print(zero[zero[zero[0]]])

class A:
    def __init__(self) -> None: ...

class B(A):
    ...


print(2 + ((((3)))))
print(len(my_list))

# Format-string with embedded delimiters
print(f'The sum of 2 and 3 is {2 + (1 + 2)}')
