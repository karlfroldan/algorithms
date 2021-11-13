include("./BinaryTree.jl")

using .BinaryTree

node = Node(1, 3, nothing, nothing, nothing)
node2 = Node(0, 10, nothing, nothing, nothing)
node3 = Node(0, 11, nothing, nothing, nothing)
node4 = Node(0, 29, nothing, nothing, nothing)
node5 = Node(0, 21, nothing, nothing, nothing)
node6 = Node(0, 100, nothing, nothing, nothing)
node7 = Node(0, 1000, nothing, nothing, nothing)
node8 = Node(0, 1012, nothing, nothing, nothing)

tree = new_tree(2)

subtree_insert_right!(tree.root, node)
subtree_insert_right!(tree.root, node2)
subtree_insert_left!(tree.root, node4)
subtree_insert_right!(tree.root, node5)
subtree_insert_left!(tree.root, node3)
subtree_insert_right!(node, node6)
subtree_insert_right!(node2, node7)
subtree_insert_left!(node5, node8)

print_tree(tree)

subtree_delete!(tree, tree.root)

println(successor(tree.root))

