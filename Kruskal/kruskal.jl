mutable struct Graph
    matrix::Matrix{Real}
    edges::Array{Tuple{Int, Int, Real}}
    idx::Array{Int}
end

function kruskal(graph::Graph)
end

function build_graph(n::Int)

    return Graph(zeros(n, n), [], [])
end

function build_graph(n::Int, edges::Vector{Tuple{Int, Int, Real}})
    third((x₁, x₂, x₃)) = x₃
    sorted = sortperm(edges, by=third)

    g = Graph(zeros(n, n), edges, sorted)

    for (a, b, w) ∈ edges
        g.matrix[a, b] = w
    end

    return g
end


println(build_graph(4, [(4, 3, -9.0), (2, 1, π), (1, 1, π/2)]))