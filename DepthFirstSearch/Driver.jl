include("DepthFirstSearch.jl")

using .DepthFirstSearch

# Our Adjacency List
# (Vertex, Predecessor π, distance)
G = Array{Vertex, 1}()

# Each line in the file is one graph
open("graph", "r") do file 
    μ = typemax(Int64)
    lines = readlines(file)
    for (idx, line) ∈ enumerate(lines)
        line = split(line)
        adjacent_vertices = line .|> s -> parse(Int, s)
        push!(G, (Vertex(idx, nothing, 0, :white, 0, adjacent_vertices)))
    end
end

@show G

# print_adjacency_list(G)
dfs!(G)
# println()
println("After DFS")
@show G
# G′ = bfs(G, 10)
# G = to_adjacency_list(G′)
# print_adjacency_list(G)
# println()
# @show get_path(G′, 10, 11)