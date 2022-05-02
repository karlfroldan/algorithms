include("Mergesort.jl")

using .Mergesort 
using Random: shuffle

n = 10000000

arr₁ = [1, 2, 3, 4, 1, 2, 3]
arr₂ = 'a':'z' |> shuffle
rand1 = rand(50)
rand2 = 1:n |> shuffle

arr₃ = deepcopy(arr₁)
arr₄ = deepcopy(arr₂)


mergesort!(arr₁)
mergesort!(arr₂)
mergesort!(rand1)


rand_array_sorted = issorted(rand1) ? "sorted" : "not sorted"

println("array: $arr₃ | sorted: $arr₁")
println("array: $arr₄ | sorted: $arr₂")
println("Random array of 50 elements is $rand_array_sorted")

println("Time it takes to sort $n elements:")
@time mergesort!(rand2)
println("Random array of $n elements is $(issorted(rand2) ? "sorted" : "not sorted")")