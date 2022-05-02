include("DepthFirstSearch.jl")

using .DepthFirstSearch
using DataStructures 

# Adjacency List 
G = Array{Vertex, 1}()
topos = MutableLinkedList{Vertex}()

function print_topo_sort(list :: MutableLinkedList{Vertex})
    for v ∈ list 
        println("$(v.label) | in=$(v.d) | out=$(v.f)")
    end
end

# Each line in the file is one vertex
# vertex_id, vertex_name, <adjacent vertices>
open("graph_topo", "r") do file 
    lines = readlines(file)

    for line in lines 
        line = split(line)
        idx = parse(Int64, line[1])
        label = line[2]
        len = length(line)
        adj = line[3:len] .|> s -> parse(Int64, s)

        v = Vertex(idx, label, nothing, 0, :white, 0, adj)
        push!(G, v)
    end
end

dfs!(G, topo_sort=true, topo_list=topos)

print_topo_sort(topos)

#@show G