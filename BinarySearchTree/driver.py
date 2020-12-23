from bst import BinarySearchTree

bst = BinarySearchTree()

bst.insert(120)
bst.insert(20)
bst.insert(-43)
bst.insert(100)
bst.insert(200)
bst.insert(54)
bst.insert(150)
bst.insert(-20000)

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