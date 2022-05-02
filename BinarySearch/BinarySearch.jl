module BinarySearch

    export binarysearch

    function binsearch(arr::Array{T, 1}, key::T, p::Int, q::Int) where T <: Union{Number, Char}
        k = (p + q) ÷ 2

        if p ≤ q
            @show if arr[k] == key 
                return k 
            elseif arr[k] > key 
                return binsearch(arr, key, p, k - 1)
            else
                return binsearch(arr, key, k + 1, q)
            end
        end

        Nothing
    end

    function binarysearch(arr::Array{T, 1}, key::T) where T <: Union{Number, Char}
        binsearch(arr, key, 1, length(arr))
    end

end