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

n = find(tree, 24)
print(n.item)