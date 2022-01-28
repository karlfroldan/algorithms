#include("./BinaryTree.jl")
include("./BinarySearchTree.jl")

#using .BinaryTree
using .BinarySearchTree

tree = BinarySearchTree.new(20)

insert_bst!(tree, 10)
insert_bst!(tree, 11)
insert_bst!(tree, 7)
insert_bst!(tree, 8)
insert_bst!(tree, 7)
insert_bst!(tree, 9)
insert_bst!(tree, 10)
insert_bst!(tree, 24)
insert_bst!(tree, 21)
insert_bst!(tree, 25)


print_tree(tree)

n = find(tree, 9)
delete_bst!(tree, n)

println()
println("Inorder property should hold")

print_space(s) = print("$(s.item) ")

inorder_traversal(tree.root, print_space)
println()
print_tree(tree)
println()
delete_bst!(tree, tree.root)
inorder_traversal(tree.root, print_space)
println()
print_tree(tree)
