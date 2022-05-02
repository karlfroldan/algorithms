include("./RodCutting.jl")

using .RodCutting

# Read the file first
open("input", "r") do f
    line = readline(f)
    global numbers = split(line) .|> s -> parse(Int64, s)
end

ns = (10, 20, 27)
println("Naive implementation")
for (idx, n) ∈ enumerate(ns)
    @time println("n_$idx = $n | $(recursive_rod_cutting(numbers, n))")
end
println()
ns = (10, 20, 50)
println("Dynamic Programming implementation")
for (idx, n) ∈ enumerate(ns)
    @time println("n_$idx = $n | $(memoized_cut_rod(numbers, n))")
end