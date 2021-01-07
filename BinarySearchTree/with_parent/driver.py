from bst import BinarySearchTree

bst = BinarySearchTree()

bst.recursive_insert(120)
bst.recursive_insert(20)
bst.recursive_insert(-43)
bst.recursive_insert(100)
bst.recursive_insert(200)
bst.recursive_insert(54)
bst.recursive_insert(150)
bst.recursive_insert(-20000)

bst.inorder_tree_walk(bst.root)
print("root: {}".format(bst.root))

s = bst.search(100)
print("s={}".format(s))

print("bst min: {}".format(bst.minimum()))
print("bst max: {}".format(bst.maximum()))
print("successor of {} is {}".format(s, bst.successor(s)))
print("predecessor of {} is {}".format(s, bst.predecessor(s)))

bst.delete(s)
print("\nnew root: {}".format(bst.root))
bst.inorder_tree_walk(bst.root)