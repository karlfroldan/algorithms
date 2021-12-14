module BellmanFord
    using Graphs, SimpleWeightedGraphs

    export bellmanford, isinfty, isneginfty, get_path

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

    function relax!(G :: SimpleWeightedDiGraph, u :: Int, v :: Int, d, π)
        if d[v] > d[u] + get_weight(G, u, v)
            d[v] = d[u] + get_weight(G, u, v)
            π[v] = u 
        end
    end

    function find_cycles!(G :: SimpleWeightedDiGraph, u, v, d, π)
        if d[v] > d[u] + get_weight(G, u, v)
            d[v] = -∞
            π[v] = nothing
        end
    end

    # Obviously, this is not a very efficient implementation
    function bellmanford(G :: SimpleWeightedDiGraph, s :: Int)
        d, π = initialize(G, s)

        # Iterate |V| - 1 times 
        for i ∈ 1 : (nv(G) - 1)
            # Then color each edge 
            for edge ∈ edges(G)
                src, dst = edge.src, edge.dst
                relax!(G, src, dst, d, π)
            end
        end

        # Find the negative cycles
        for i ∈ 1 : (nv(G) - 1)
            for edge ∈ edges(G)
                src, dst = edge.src, edge.dst 
                find_cycles!(G, src, dst, d, π)
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