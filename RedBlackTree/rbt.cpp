#include "rbt.hpp"
#include <iostream>
#include <string>

bool isblack(Node* n) {
    return n->isblack;
}

bool isred(Node* n) {
    return !isblack(n);
}

bool isnil(RBTree& tree, Node* n) {
    return tree.nil == n;
}

bool isroot(Node* n) {
    return n->parent == nullptr;
}

void inorder(RBTree& tree, Node* n) {
    if (tree.nil != n) {
        inorder(tree, n->left);
        std::cout << n->data << ' ';
        inorder(tree, n->right);
    }
}

void inorder(RBTree& tree) {
    if (tree.root != tree.nil) {
        inorder(tree, tree.root);
    } else {
        std::cout << "Empty tree\n";
    }
}

void printtree(RBTree& tree, Node* n, size_t d) {
    if (!isnil(tree, n)) {
        std::string spaces(d * 2, ' ');
        std::string color { isblack(n) ? "black" : "red" };
        std::cout << spaces << "- " << n->data << " | COLOR: " << color << '\n';
        printtree(tree, n->left, d + 1);
        printtree(tree, n->right, d + 1);
    }
}

void printtree(RBTree& tree) {
    if (tree.nil != tree.root) {
        printtree(tree, tree.root, 0);
    } else {
        std::cout << "Empty tree\n";
    }
}

/*
  TREE ROTATIONS
  
    x      left_rotate =>     y
   / \                       / \
  a   y   <= right_rotate   x   c
     / \                   / \
    b   c                 a   b

 */

void left_rotate(RBTree& tree, Node* x) {

    // Set y
    auto y { x->right };

    // turn y's left subtree into x's right subtree
    x->right = y->left;

    if (!isnil(tree, y->left)) {
        y->left->parent = x;
    }

    // link x's parent to y
    y->parent = x->parent;

    if (isnil(tree, x->parent)) {
        tree.root = y;
    } else if (x == x->parent->left) {
        x->parent->left = y;
    } else {
        x->parent->right = y;
    }

    y->left = x;
    x->parent = y;
}

void right_rotate(RBTree& tree, Node* x) {

    // Set y
    auto y { x->left };

    // turn y's right subtree into x's left subtree
    x->left = y->right;

    if (!isnil(tree, y->right)) {
        y->right->parent = x;
    }

    // link x's parent to y
    y->parent = x->parent;

    if (isnil(tree, x->parent)) {
        tree.root = y;
    } else if (x == x->parent->right) {
        x->parent->right = y;
    } else {
        x->parent->left = y;
    }

    y->right = x;
    x->parent = y;

}

/* INSERTION */

void insert_fix_up(RBTree& tree, Node* z) {

    while (isred(z->parent)) {

        if (z->parent == z->parent->parent->left) {
            auto uncle { z->parent->parent->right };
            // CASE 1: The color of y is red.
            if (isred(uncle)) {
                z->parent->isblack = true;
                uncle->isblack = true;
                z->parent->parent->isblack = false;
                z = z->parent->parent;
            } else {
                // We have two cases
                // We only need to convert CASE 2 to CASE 3.

                // CASE 2: z is the right child
                if (z == z->parent->right) {
                    z = z->parent;
                    left_rotate(tree, z);
                }

                // CASE 3: z is the left child
                z->parent->isblack = true;
                z->parent->parent->isblack = false;
                right_rotate(tree, z->parent->parent);
            }
        } else {
            auto uncle { z->parent->parent->left };
            // CASE 1: The color of y is red.
            if (isred(uncle)) {
                z->parent->isblack = true;
                uncle->isblack = true;
                z->parent->parent->isblack = false;
                z = z->parent->parent;
            } else {
                // We have two cases
                // We only need to convert CASE 2 to CASE 3.

                // CASE 2: z is the right child
                if (z == z->parent->left) {
                    z = z->parent;
                    right_rotate(tree, z);
                }

                // CASE 3: z is the left child
                z->parent->isblack = true;
                z->parent->parent->isblack = false;
                left_rotate(tree, z->parent->parent);
            }
        }

    }

    tree.root->isblack = true;
    auto p = 0;
}

void insert(RBTree& tree, Node* n) {

    // Do the normal BST insert
    auto m { tree.root };
    auto p { m };

    while (!isnil(tree, m)) {
        p = m;

        if (m->data == n->data) {
            // early return 
            return;
        } else if (m->data > n->data) {
            m = m->left;
        } else {
            m = m->right;
        }
    }

    n->parent = p;

    if (p->data < n->data) {
        p->right = n;
    } else {
        p->left = n;
    }

    n->left = tree.nil;
    n->right = tree.nil;

    insert_fix_up(tree, n);

}

void insert(RBTree& tree, int k) {
    Node* n = new Node(k);

    if (tree.root == tree.nil) {
        n->isblack = true;
        tree.root = n;

        n->left = tree.nil;
        n->right = tree.nil;
        n->parent = tree.nil;

    } else {
        insert(tree, n);
    }
}

bool check_red_nodes(RBTree& T, Node* n) {
    bool recurse = true, satisfy = true;

    if (!isnil(T, n)) {
        if (isred(n)) {
            satisfy = n->left->isblack && n->right->isblack;
            // recurse 
        }

        return satisfy && check_red_nodes(T, n->left) && check_red_nodes(T, n->right);
    }

    return recurse;

}

int black_heights(RBTree& tree, Node* n) {

    if (isnil(tree, n)) {
        return 1;
    } else {
        auto h { n->isblack ? 1 : 0 };
        auto left { black_heights(tree, n->left) };
        auto right { black_heights(tree, n->right) };

        auto validity { (left != -1 && right != -1) && (left == right) };

        if (validity) {
            return -1;
        } else {
            return h + left;
        }
    }

}

void check_rbt_property(RBTree& T) {
    // We only need to check the following properties.
    /*
        1. The root is black
        2. If a node is red, then both its children are black
        3. For each node, all simple paths from the node to descendant leaves contain the same number of black nodes.
    */

    // PROPERTY 1
    std::string prop1 { T.root->isblack ? "black" : "red" };
    std::cout << "1. The root is " << prop1 << '\n';

    // PROPERTY 2
    std::string prop2 { check_red_nodes(T, T.root) ? "Satisfies property 2" : "Does not satisfy property 2" };
    std::cout << "2. " << prop2 << '\n';

    // PROPERTY 3
    std::string prop3 { black_heights(T, T.root) ? "Same number of black nodes." : "Does not have the same number of black nodes" };
    std::cout << "3. " << prop3 << '\n';
}