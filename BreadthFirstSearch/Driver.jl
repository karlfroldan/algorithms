include("BreadthFirstSearch.jl")

using .BreadthFirstSearch

# Our Adjacency List
# (Vertex, Predecessor π, distance)
G = Array{Vector{Int}, 1}()

# Each line in the file is one graph
open("graph", "r") do file 
    μ = typemax(Int64)
    lines = readlines(file)
    for line ∈ lines 
        line = split(line)
        adjacent_vertices = line .|> s -> parse(Int, s)
        push!(G, adjacent_vertices)
    end
end

@show G

G′ = bfs(G, 1)
@show G′