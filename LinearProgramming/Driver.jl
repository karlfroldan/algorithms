include("./SimplexAlgorithm.jl")

using .SimplexAlgorithm

A = [
    -3 -7 -1;
    -1 2 -3
]

b = [15, 20]
c = [6, 1, 4]

m = new_model(A, b, c)

@show m