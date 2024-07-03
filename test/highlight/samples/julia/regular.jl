a = Vector{Int}([1, 2, 3, 4, 5, 6]);
A = [
    28 32
    11 70
];

f(x) = abs((x-4)*(x+2))
b = [f(x) for x ∈ A]
x = (1, 2)
