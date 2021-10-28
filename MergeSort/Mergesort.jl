module Mergesort 
    export mergesort!

    function merge!(arr::Array{T, 1}, p::Int, m::Int, q::Int) where (T <: Number)
        n₁ = m - p + 1
        n₂ = q - m

        # Create temporary arrays 
        left = zeros(n₁ + 1)
        right = zeros(n₂ + 1)

        # Save everything from the left side of the array to the left array 
        for i ∈ 1:n₁
            left[i] = arr[p + i - 1] 
        end

        for j ∈ 1:n₂
            right[j] = arr[m + j]
        end

        # Create sentinel values
        # The for loop later will never reach this because
        # we only have to look at p-q elements while the arrays has (p-q)+2 elements.
        left[n₁ + 1] = Inf
        right[n₂ + 1] = Inf 

        i, j = (1, 1)
        
        # for each k in {p, p + 1,…, q}
        for k ∈ p:q
            if left[i] ≤ right[j]
                arr[k] = left[i]
                i += 1
            else
                arr[k] = right[j]
                j += 1
            end
        end
    end

    function msort!(arr::Array{T, 1}, p::Int, q::Int) where (T <: Number)
        if p < q 
            mid = (p + q) ÷ 2

            msort!(arr, p, mid)
            msort!(arr, mid+1, q)
            merge!(arr, p, mid, q)
        end
    end

    function mergesort!(arr::Array{T, 1}) where (T <: Number)
        msort!(arr, 1, length(arr))
    end
end