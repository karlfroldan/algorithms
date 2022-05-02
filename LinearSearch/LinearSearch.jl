module LinearSearch
    export linearsearch

    function linearsearch(arr::Array{T, 1}, key::T) where T <: Any 
        for (i, e) ∈ enumerate(arr)
            if e == key 
                return i
            end
        end
        Nothing
    end
end