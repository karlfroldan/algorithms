include("./InsertionSort.jl")

using .InsertionSort

arr = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
insertionsort!(arr)
println(arr)