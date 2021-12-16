module Dijkstra 

    using Graphs, SimpleWeightedGraphs
    using DataStructures: PriorityQueue, enqueue!, dequeue!

    export dijkstra, isinfty, isneginfty, get_path

    const ∞ = typemax(Int)
    isinfty(x :: Int) = x == ∞ 
    isneginfty(x :: Int) = x == -∞

    function initialize(G :: SimpleWeightedDiGraph, s :: Int)
        d = Vector{Int}(undef, nv(G))
        π = Vector{Union{Nothing, Int}}(undef, nv(G))
        for v ∈ vertices(G)
            d[v] = ∞
            π[v] = nothing
        end

        d[s] = 0

        return d, π
    end

    function relax!(G :: SimpleWeightedDiGraph, Q::PriorityQueue{Int, Int}, u :: Int, v :: Int, d, π)
        if d[v] > d[u] + get_weight(G, u, v)
            d[v] = d[u] + get_weight(G, u, v)
            π[v] = u
            # Change the priority of v
            Q[v] = d[v]
        end
    end

    function create_queue(G::SimpleWeightedDiGraph, d::Vector{Int})
        Q = PriorityQueue{Int, Int}()

        for v ∈ vertices(G)
            δ = d[v]
            enqueue!(Q, v => δ)
        end
        Q
    end

    function dijkstra(G::SimpleWeightedDiGraph, s::Int)
        # Initialize the table first 
        d, π = initialize(G, s)

        # Initialize the PriorityQueue
        Q = create_queue(G, d)
        
        # Initialize the visited set 
        S = Set{Int}()

        while !isempty(Q)
            u = dequeue!(Q)
            push!(S, u)

            # Relax u for each neighbor
            for v ∈ outneighbors(G, u)
                relax!(G, Q, u, v, d, π)
            end
        end

        return d, π
    end

    function get_path(s :: Int, dest :: Int, d :: Vector{Int}, π :: Vector{Union{Nothing, Int}})
        if isinfty(dest) || isneginfty(dest)
            return []
        else 
            path = Vector{Int}()
            n = dest
            while !isnothing(π[n])
                pushfirst!(path, n)
                n = π[n]
            end
            pushfirst!(path, n)
            return path
        end
    end

end