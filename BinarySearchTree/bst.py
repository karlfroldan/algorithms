def minimum(x):
    # We keep going to the left until we find such minimum
    while x.left is not None:
        x = x.left 
    return x

def maximum(x):
    # We keep going to the right until we find such maximum
    while x.right is not None:
        x = x.right 
    return x

def search(x, k):
    # If x is NULL
    #   trivially, return None
    # or if k is equal to the key of x
    #   return x
    if x is None or k == x.key:
        return x 
    if k < x.key:
        return search(x.left, k)
    else:
        return search(x.right, k)

def successor(x):
    # successor have two cases:
    #   1. There is a right node, then the successor is the minimum
    #      starting from that node.
    #   2. The node is a leaf, we will have to traverse each parent.
    #      Let p be the traversal variable
    #       a) If x is right descendant(p), then that means that x
    #          is a right child and its parent is has a lower ordering 
    #          than x. Keep traversing until we reach such a node p'
    #          where x is not right descendant(p').
    #       b) If x is left descendant of p, then the successor is p,
    #          which is the parent of x
    if x.right is not None:
        return minimum(x.right)
    p = x.parent
    while p is not None and x == p.right:
        x = p
        p = p.parent
    return p

def predecessor(x):
    # Same idea as successor
    if x.left is not None:
        return maximum(x.left)
    p = x.parent 
    while p is not None and x == p.left:
        x = p
        p = p.parent 
    return p

class Node:
    def __init__(self, k, v):
        self.key = k
        self.value = v 
        self.parent = None 
        self.left   = None 
        self.right  = None 
    def __str__(self):
        if self.key == self.value:
            return "Node ({})".format(self.key)
        else:
            return "Node (key: {}, value: {})".format(self.key, self.value)

class BinarySearchTree:
    def __init__(self):
        self.root   = None

    def inorder_tree_walk(self, x):
        if x is not None:
            self.inorder_tree_walk(x.left)
            print(str(x))
            self.inorder_tree_walk(x.right)
    
    def insert(self, k, v=None):
        if v is None:
            v = k
        n = Node(k, v)
        y = None 
        x = self.root

        # x will be None if there is no element yet
        while x is not None:
            # y will be the parent of the new node
            y = x
            # If the new n's key is less than x.key,
            # we go to the left of x
            if n.key < x.key:
                x = x.left
            else: # Otherwise, it's the right for us
                x = x.right 
        # Set the parent to y
        n.parent = y
        if y is None:
            # Tree is empty
            self.root = n
        elif n.key < y.key:
            # We will insert to the left of y
            y.left = n 
        else:
            y.right = n
    
    def search(self, k):
        # Unlike CLRS, we will begin at the root of the tree
        return search(self.root, k)
    
    def minimum(self):
        return minimum(self.root)
    def maximum(self):
        return maximum(self.root)
    def successor(self, x):
        return successor(x)
    def predecessor(self, x):
        return predecessor(x)
    
    def transplant(self, u, v):
        """
        `Transplant` replaces the subtree rooted at node `u`
        with the subtree rooted at node `v`. Node `u`'s parent
        become node `v`'s parent, and `u`'s parent ends up having
        `v` as its appropriate child
        """
        # If u is the root of tree, then simply set the root
        # as v. This will probably delete u
        if u.parent is None:
            self.root = v
        # if u is a left child replace u with v
        elif u == u.parent.left:
            u.parent.left = v 
        # if u is a right child, replace u with v too
        else:
            u.parent.right = v 
        if v is not None:
            v.parent = u.parent
    
    def delete(self, z):
        """
        We have multiple cases
        Case 1:
            If z is a leaf, simply remove it by modifying its parent
            to remove z as a child
        Case 2:
            If z has just one child, then elevate that position by taking
            z's position
        Case 3:
            If z has two children, then we find z's successor y - which must
            be in z's right subtree - and have y take z's position in the subtree.
            The rest of z's original right subtree become y's new subtree. and z's 
            left subtree become y's new subtree.
        """
        # Handle the case when has no left child
        if z.left is None:
            self.transplant(z, z.right)
        # Handle the case in whcih z has a left child
        # but no right child
        elif z.right is None:
            self.transplant(z, z.left)
        # Handle the case when z has two children
        else:
            # I use successor() instead of minimum() here
            # for readability.
            # the successor y is somewhere in the right subtree
            # of z. Hence, this will go in the first case of successor
            y = self.successor(z.right)
            if y.parent != z:
                self.transplant(y, y.right)
                # the right subtree of z will be the new
                # right subtree of y
                y.right = z.right 
                # set y to be the new parent instead of z
                y.right.parent = y
            # replace z with y. This will orphan z and 
            self.transplant(z, y)
            # we orphan z and Python will prolly just
            # garbage collect it anyways
            y.left = z.left 
            y.left.parent = y
