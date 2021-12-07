module WeightedGraphs 

    export new_graph, add_edge!, neighbors, weight, print_graph
    export vertices, order, edges, edge_elements

    mutable struct WeightedGraph
        adjacency :: Dict{Int, Set{Int}}
        weights :: Dict{Set{Int}, Number}
    end

    vertices(g::WeightedGraph) = keys(g.adjacency) |> collect

    order(g::WeightedGraph) = length(keys(g.adjacency))

    function edges(g::WeightedGraph) 
        es = Set{Set{Int}}()

        for v ∈ vertices(g)
            ns = neighbors(g, v) |> collect 
            for n ∈ ns 
                s = Set([v, n])
                push!(es, s)
            end
        end
        es
    end

    function edge_elements(edge :: Set{Int})
        edge = edge |> collect |> sort 
        u, v = edge[1], edge[2]
        u, v
    end

    function new_graph()
        WeightedGraph(Dict(), Dict())
    end

    function new_graph(x :: Int)
        adj = Dict()
        for i ∈ 1:x 
            adj[i] = Set{Int}() 
        end
        WeightedGraph(adj, Dict())
    end

    function add_edge!(g :: WeightedGraph, src, dest, weight)
        push!(g.adjacency[src], dest)
        push!(g.adjacency[dest], src)

        weights = g.weights 
        weights[Set([src, dest])] = weight 
    end

    function neighbors(g :: WeightedGraph, v :: Int) 
        g.adjacency[v]
    end

    function weight(g :: WeightedGraph, src, dest)
        ns = g.adjacency[src]
        if dest ∈ ns 
            return g.weights[Set([src, dest])]
        else 
            return nothing 
        end
    end

    function print_graph(g :: WeightedGraph)
        ks = vertices(g) |> sort

        for key ∈ ks 
            print("vertex $key: neighbors: ")
            ns = neighbors(g, key) |> collect |> sort 
            for n ∈ ns 
                w = weight(g, key, n)
                print("($n, $w)  ")
            end
            println()
        end
    end

    

end