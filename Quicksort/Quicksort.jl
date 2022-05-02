module Quicksort
    export quicksort!

    function swap!(arr::Array{T, 1}, p::Int, q::Int) where {T <: Union{Number, Char}}
        temp = arr[p]
        arr[p] = arr[q]
        arr[q] = temp
    end

    function partition(arr::Array{T, 1}, p::Int, q::Int) where {T <: Union{Number, Char}}
        # Get the pivot element
        pivot = arr[q]

        # Start the indicator of the lower elements to the left of the array
        i = p - 1

        for j ∈ p:(q - 1)
            # if the current element is smaller than the pivot
            if arr[j] < pivot
                i += 1
                swap!(arr, i, j)
            end
        end

        # Swap the pivot to the part where the lower numbers indicator just ended.
        swap!(arr, i + 1, q)
        return i + 1
    end

    function qsort!(arr::Array{T, 1}, p::Int, q::Int) where {T <: Union{Number, Char}}
        if p < q 
            mid = partition(arr, p, q)
            qsort!(arr, p, mid - 1)
            qsort!(arr, mid + 1, q)
        end
    end

    function quicksort!(arr::Array{T, 1}) where {T <: Union{Number, Char}}
        qsort!(arr, 1, length(arr))
    end
end