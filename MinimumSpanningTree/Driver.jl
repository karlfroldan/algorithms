include("./Kruskal.jl")

using DataStructures
using Graphs, SimpleWeightedGraphs, GraphPlot
using .Kruskal
using Cairo, Compose

function get_edge_list(filename)
    edges′ = Vector()
    edges = readlines(filename) .|> split
    # edges are of the form (src, edge, weight)
    for edge ∈ edges 
        edge = edge .|> s -> parse(Int, s)
        push!(edges′, (edge[1], edge[2], edge[3]))
    end
    edges′
end

function graph_from_iter(edges::Array{T, 1}) where T <: AbstractEdge
    srcs = [edge.src for edge ∈ edges]
    dsts = [edge.dst for edge ∈ edges]
    num_vert = max(maximum(srcs), maximum(dsts))

    g = SimpleWeightedGraph(num_vert)

    for edge ∈ edges 
        u, v, w = edge.src, edge.dst, edge.weight 
        add_edge!(g, u, v, w)
    end
    g
end


g = SimpleWeightedGraph(9)

for (s, d, w) ∈ get_edge_list("graph") 
    add_edge!(g, s, d, w)
end

println("Initial graph")
@show g
no_mst = gplot(g)
draw(PNG("no_mst.png", 16cm, 16cm), no_mst)

println("After Kruskal")
ks = kruskal(g)

g′ = graph_from_iter(ks)
println("\nAfter Kruskal")
@show g′
draw(PNG("kruskal.png", 16cm, 16cm), gplot(g′))