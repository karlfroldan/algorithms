module DepthFirstSearch

    using DataStructures

    export Vertex
    export dfs!, print_tree

    mutable struct Vertex 
        label::Int
        π::Union{Int, Nothing}
        d::Int
        color::Symbol
        f::Int
        adj::Vector{Int}
    end

    function dfs!(G::Array{Vertex, 1})
        global time = 0

        # This for loop creates a forest, if the 
        # graph is not connected.
        for u ∈ G 

            if u.color == :white 
                dfs_visit!(G, u)
            end

        end
    end

    function dfs_visit!(G::Array{Vertex, 1}, u::Vertex)
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
                v.π = u.label
                # search deeply on the descendants of v
                dfs_visit!(G, v)
            end
        end

        # we have finished with u. We don't need it anymore.
        u.color = :black 
        global time = time + 1
        u.f = time
    end

end