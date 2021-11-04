module BreadthFirstSearch
    using DataStructures

    export Vertex, bfs

    mutable struct Vertex 
        label::Int
        π::Union{Int, Nothing}
        d::Int
    end

    function bfs(G::Array{Vector{Int}, 1}, s::Int)

        # Color sets
        white = Set{typeof(s)}()
        black = Set{typeof(s)}()
        gray  = Set{typeof(s)}()

        G′ = Vector{Vertex}(undef, length(G))
        Q = Queue{Int}()

        # Loop through all vertices in G.
        # If we see, s, we mark it as gray instead of white.
        for (idx, adj) ∈ enumerate(G) 
            if s == idx 
                G′[s] = Vertex(s, nothing, 0)
                push!(gray, s)
            else
                G′[idx] = Vertex(idx, nothing, typemax(Int))
                push!(white, idx)
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
                if v ∈ white 
                    node = G′[v]
                    node.π = u 
                    node.d = G′[u].d + 1

                    # Change the color of v to gray 
                    delete!(white, v)
                    push!(gray, v)

                    enqueue!(Q, v)
                end
            end

            # We've already searched u so we change its color to black 
            delete!(gray, u)
            push!(black, u)

        end

        return G′
    end
end