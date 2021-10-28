include("Mergesort.jl")

using .Mergesort 

n = 10000000

arr₁ = [1, 2, 3, 4, 1, 2, 3]
arr₂ = [1, 6, 4, 2, π]
rand1 = rand(50)
rand2 = rand(n)

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