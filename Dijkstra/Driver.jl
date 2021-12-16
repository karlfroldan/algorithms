include("./Dijkstra.jl")

using Graphs, SimpleWeightedGraphs, Cairo, GraphPlot, Compose
using .Dijkstra

function new_edge!(G :: SimpleWeightedDiGraph, u :: Int, v :: Int, w :: Int)
    e = SimpleWeightedDiGraphEdge(u, v, w)
    add_edge!(G, e)
end

function graph_from_file(filename)
    lines2 = Vector{Tuple{Int, Int, Int}}()

    lines = readlines(filename) .|> split 

    for line in lines 
        line = line .|> s -> parse(Int, s)
        u, v, w = line[1], line[2], line[3]
        push!(lines2, (u, v, w))
    end
    n_nodes = maximum(lines2 .|> ((u, v, w), ) -> max(u, v))
    g = SimpleWeightedDiGraph(n_nodes)
    
    for (u, v, w) ∈ lines2 
        new_edge!(g, u, v, w)
    end
    return g
end

g = graph_from_file("edges")

p = gplot(g, nodelabel=1:nv(g), linetype="curve")
draw(PNG("init.png", 16cm, 16cm), p)

d, π = dijkstra(g, 1)

for (idx, (dist, parent)) ∈ enumerate(zip(d, π))
    dist′ = dist == -typemax(Int) ? "-∞" : string(dist)
    if isinfty(dist)
        dist′ = "∞"
    elseif isneginfty(dist)
        dist′ = "-∞"
    else 
        dist′ = string(dist)
    end

    println("Node $idx: $dist′ - parent: $parent")
    path = get_path(2, idx, d, π)
    println("Path: $path")
    println()
end