module RodCutting

    export recursive_rod_cutting, memoized_cut_rod

    function recursive_rod_cutting(p::Vector{T}, n::Int) where T <: Number 
        if n == 0 # Base case  r₀ = 0
            return 0
        end

        q = typemin(T) # We compare the max against this 

        for i ∈ 1:n
            q = max(q, p[i] + recursive_rod_cutting(p, n - i))
        end
        return q
    end

    function memoized_cut_rod(p::Vector{T}, n::Int) where T <: Number 
        r = zeros(n + 1)

        r[1] = 0

        for j ∈ 1:n 
            q = typemin(T)
            for i ∈ 1:j 
                q = max(q, p[i] + r[j - i + 1])
            end
            r[j + 1] = q 
        end

        return trunc(Int64, r[n + 1])
    end
end