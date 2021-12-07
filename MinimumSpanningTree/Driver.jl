include("./WeightedGraphs.jl")
#include("./Kruskal.jl")

using .WeightedGraphs 
using DataStructures
#using .Kruskal

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

function kruskal(g)
    A = Set{Set{Int}}() # A set of edges 
    T = IntDisjointSets(order(g)) # trees in the forest
    
    pq = PriorityQueue{Set{Int}, Number}()
    # We want to sort the edges in non-decreasing order by weight
    for edge ∈ edges(g)
        u, v = edge_elements(edge)
        w = weight(g, u, v)
        enqueue!(pq, Set(edge), w)
    end
    
    # Take elements from the priority queue
    while !isempty(pq)
        u, v = edge_elements(dequeue!(pq))
        if !in_same_set(T, u, v)
            push!(A, Set([u, v]))
            union!(T, u, v)
        end
    end

    return A
end

g = new_graph(9)

for (s, d, w) ∈ get_edge_list("graph") 
    add_edge!(g, s, d, w)
end

println("Initial graph")
print_graph(g)


@show kruskal(g)