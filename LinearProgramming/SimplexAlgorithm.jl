module SimplexAlgorithm

    export new_model

    mutable struct Model{T}
        A :: Matrix{T}  # The model matrix. This is actually the negative of the standard form
        B :: Set{Int}   # Basic variables indices
        N :: Set{Int}   # Non-basic variables indices
        b :: Vector{T}  # constants 
        c :: Vector{T}  # objective function constants 
        x :: Vector{T}  # solution
    end

    function new_model(A :: Matrix{T}, b :: Vector{T}, c :: Vector{T}) where T <: Number 
        m, n = size(A) # m constraints, n variables 
        # Non-basic variables and the basic variables 
        N, B = Set(1:n), Set(n+1:m+n)
        x    = zeros(T, n + m)
        return Model{T}(A, B, N, b, c, x)
    end

    

end