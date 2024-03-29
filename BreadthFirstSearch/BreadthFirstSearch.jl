module BreadthFirstSearch
    using DataStructures

    export Vertex, bfs, to_adjacency_list, print_adjacency_list
    export get_path, ecc, radius

    mutable struct Vertex 
        label::Int
        π::Union{Int, Nothing}
        d::Int
    end

    function get_path(G::Vector{Vertex}, s::Int, v::Int)
        P = Vector{Int}()

        get_path!(G, P, s, v)
        return P
    end

    function get_path!(G::Vector{Vertex}, P::Vector{Int}, s::Int, v::Int)
        if s == v 
            push!(P, s)
        elseif G[v].π === nothing 
            nothing 
        else 
            get_path!(G, P, s, G[v].π)
            push!(P, v)
        end
    end

    function print_adjacency_list(G::Array{Vector{Int}, 1})
        for (i, v) ∈ enumerate(G)
            println("vertex ($i): $v")
        end
    end

    function to_adjacency_list(G′::Vector{Vertex})
        G = Array{Vector{Int}, 1}(undef, length(G′))

        for i ∈ 1:length(G′)
            G[i] = Vector{Int}()
        end

        for node ∈ G′

            # If node has a parent,
            # we make those vertices adjacent of each other.
            if node.π ≠ nothing 
                π = node.π 
                push!(G[π], node.label)
                push!(G[node.label], π)
            end
        end
        return G
    end

    function radius(G::Array{Vector{Int}, 1})
        min_ecc = typemax(Int64) # similar to min_ecc = ∞

        for idx ∈ 1:length(G)
            eccentricity = ecc(G, idx)
            min_ecc = min(min_ecc, eccentricity)
        end

        return min_ecc
    end

    function ecc(G::Array{Vector{Int}, 1}, s::Int)
        # Color sets
        searched     = Set{Int}()
        not_searched = Set{Int}()

        G′ = Vector{Vertex}(undef, length(G))
        Q = Queue{Int}()

        max_dist = 0
        # Loop through all vertices in G.
        # If we see, s, we mark it as gray instead of white.
        for idx ∈ 1:length(G) 
            if s == idx 
                G′[s] = Vertex(s, nothing, 0)
                push!(searched, s)
            else
                G′[idx] = Vertex(idx, nothing, typemax(Int))
                push!(not_searched, idx)
            end
        end

        # We add s to the Queue
        enqueue!(Q, s)

        # If the queue is empty, it means that we have searched every searchable node.
        while !isempty(Q)

            u = dequeue!(Q)
            adjacency = G[u]
            
            # For each neighbor v of u, 
            # we see if v had already been searched (gray or black)
            for v ∈ adjacency
                
                # If v hasn't been searched yet 
                if v ∈ not_searched 
                    node = G′[v]
                    node.π = u 
                    node.d = G′[u].d + 1

                    max_dist = max(node.d, max_dist)

                    # Change the color of v to gray 
                    delete!(not_searched, v)
                    push!(searched, v)

                    enqueue!(Q, v)
                end
            end
        end

        return max_dist
    end

    function bfs(G::Array{Vector{Int}, 1}, s::Int)

        # Color sets
        searched     = Set{Int}()
        not_searched = Set{Int}()

        G′ = Vector{Vertex}(undef, length(G))
        Q = Queue{Int}()

        # Loop through all vertices in G.
        # If we see, s, we mark it as gray instead of white.
        for idx ∈ 1:length(G) 
            if s == idx 
                G′[s] = Vertex(s, nothing, 0)
                push!(searched, s)
            else
                G′[idx] = Vertex(idx, nothing, typemax(Int))
                push!(not_searched, idx)
            end
        end

        # We add s to the Queue
        enqueue!(Q, s)

        # If the queue is empty, it means that we have searched every searchable node.
        while !isempty(Q)

            u = dequeue!(Q)
            adjacency = G[u]
            
            # For each neighbor v of u, 
            # we see if v had already been searched (gray or black)
            for v ∈ adjacency
                
                # If v hasn't been searched yet 
                if v ∈ not_searched 
                    node = G′[v]
                    node.π = u 
                    node.d = G′[u].d + 1

                    # Change the color of v to gray 
                    delete!(not_searched, v)
                    push!(searched, v)

                    enqueue!(Q, v)
                end
            end
        end

        return G′
    end
end