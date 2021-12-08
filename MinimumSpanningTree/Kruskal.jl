module Kruskal 
    using DataStructures
    using Graphs, SimpleWeightedGraphs

    export kruskal 

    function kruskal(g :: SimpleWeightedGraph)
        get_edges(edge::AbstractEdge)        = edge.src, edge.dst

        A = Vector{AbstractEdge}() # A set of edges 
        T = IntDisjointSets(nv(g)) # trees in the forest
        
        Q = Vector{SimpleWeightedEdge}()

        # We want to sort the edges in non-decreasing order by weight
        for edge ∈ edges(g)
            push!(Q, edge)
        end

        # Pick the edge with the lowest weight first 
        permvec = sortperm(Q, by=e -> e.weight)

        for idx ∈ permvec
            edge = Q[idx]   
            u, v = get_edges(edge)

            # The logic is that, if two vertices are in the same set, then 
            # they are connected. Hence, this prevents cycles from being formed.
            if !in_same_set(T, u, v)
                push!(A, edge)
                union!(T, u, v)
            end
        end

        return A
    end
end