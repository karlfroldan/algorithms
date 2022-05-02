module DepthFirstSearch

    using DataStructures

    export Vertex
    export dfs!, print_tree

    mutable struct Vertex 
        key::Int
        label::Any
        π::Union{Int, Nothing}
        d::Int
        color::Symbol
        f::Int
        adj::Vector{Int}
    end

    function dfs!(G::Array{Vertex, 1}; topo_sort=false, topo_list::Union{Nothing, MutableLinkedList{Vertex}}=nothing)
        global time = 0

        # This for loop creates a forest, if the 
        # graph is not connected.
        for u ∈ G 

            if u.color == :white 
                dfs_visit!(G, u, topo_sort=topo_sort, topo_list=topo_list)
            end

        end
    end

    function dfs_visit!(G::Array{Vertex, 1}, u::Vertex; 
        topo_sort=false, topo_list::Union{Nothing, MutableLinkedList{Vertex}}=nothing)
        # vertex u has been discovered
        global time += 1
        # Time since discovery and between searching its neighbors
        u.d = time 
        u.color = :gray

        # Search all the neighbor vertices of u
        for v ∈ u.adj
            v = G[v]
            if v.color == :white 
                # v has been discovered...
                v.π = u.key
                # search deeply on the descendants of v
                dfs_visit!(G, v, topo_sort=topo_sort, topo_list=topo_list)
            end
        end

        # we have finished with u. We don't need it anymore.
        u.color = :black 
        global time = time + 1
        u.f = time
        
        if topo_sort 
            pushfirst!(topo_list, u)
        end
    end

end