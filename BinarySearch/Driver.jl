include("BinarySearch.jl")

using .BinarySearch 

arr1 = [1, 2, 3, 4, 5]
arr2 = 1:5:2000 |> collect

@show binarysearch(arr1, 5)
@show binarysearch(arr2, 17)
@show binarysearch(arr2, 96)