include("./LinearSearch.jl")


using .LinearSearch

arr1 = [1, 2, 3, 4, 5]
arr2 = ["Hello", "World", "I", "Don't", "Know"]

@show linearsearch(arr1, 5)
@show linearsearch(arr2, "My name")
@show linearsearch(arr2, "Know")