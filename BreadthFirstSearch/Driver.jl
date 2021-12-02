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

print_adjacency_list(G)

println()
println("After BFS")
G′ = bfs(G, 10)
G = to_adjacency_list(G′)
print_adjacency_list(G)
println()
@show get_path(G′, 10, 11)

println()
println("Furthermore, the eccentricity of G from vertex 10 is $(ecc(G, 10))")
println("The radius of G is $(radius(G))")