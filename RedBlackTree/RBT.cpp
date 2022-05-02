#include "RBT.hpp"

#include <iostream>
#include <string>

void printtree(RBTree* tree, Node* n, size_t depth) {
    if (n != tree->nil) {
        std::string spaces(depth * 2, ' ');
        std::cout << spaces << "- " << n->data << '\n';
        printtree(tree, n->left, depth + 1);
        printtree(tree, n->right, depth + 1);
    }
}

void printtree(RBTree& tree) {
    printtree(&tree, tree.root, 0);
    // if (tree.nil == tree.root) {
    //     std::cout << "Empty tree\n";
    // } else {
    //     printtree(&tree, tree.root, 0);
    // }
}

void left_rotate(RBTree& tree, Node* x) {
    /*
        x            z
       / \          / \
      T1  z    =>  x   T3
         / \      / \
        T2  T3   T1  T2     
     */
    auto z { x->right };
    auto T2 { z->left };

    x->right = T2;

    if (T2 != tree.nil) {
        T2->parent = x;
    }

    auto p = x->parent;
    
    x->parent = z;
    z->left = x;

    if (p != nullptr) {
        if (p->left == x) {
            p->left = z;
        } else {
            p->right = z;
        }
    } else {
        tree.root = z;
    }
}

void right_rotate(RBTree& tree, Node* x) {
    /*
        x            x
       / \          / \
      T1  z    <=  z   T3
         / \      / \
        T2  T3   T1  T2     
     */
    auto z { x->left };
    auto T2 { z->right };

    x->left = T2;

    if (T2 != tree.nil) {
        T2->parent = x;
    }

    auto p = x->parent;
    
    x->parent = z;
    z->right = x;

    if (p != nullptr) {
        if (p->left == x) {
            p->left = z;
        } else {
            p->right = z;
        }
    } else {
        tree.root = z;
    }
}

void insert_fix_up(RBTree& tree, Node* n) {
    while (n->parent->color == RED) {

        auto gparent { n->parent->parent };

        // if n's parent is the left child.
        if (n->parent == gparent->left) {
            auto y { gparent->right };

            if (y->color == RED) {
                n->parent->color = BLACK;
                y->color = BLACK;
                gparent->color = RED;
                // This is guaranteed to exist.
                n = gparent;
            } else {
                if (n == n->parent->right) {
                    n = n->parent;
                    left_rotate(tree, n);
                }

                n->parent->color = BLACK;
                n->parent->parent->color = RED;
                right_rotate(tree, n->parent->parent);
            }
        } else {

            auto y { gparent->left };

            if (y->color == RED) {
                n->parent->color = BLACK;
                y->color = BLACK;
                gparent->color = RED;
                // This is guaranteed to exist.
                n = gparent;
            } else {
                if (n == n->parent->left) {
                    n = n->parent;
                    right_rotate(tree, n);
                }

                n->parent->color = BLACK;
                n->parent->parent->color = RED;
                left_rotate(tree, n->parent->parent);
            }       

        }

    }

    tree.root->color = BLACK;
}

void insert(RBTree& tree, Node* n) {
    // Do the normal BST insert
    Node* y { tree.root };
    Node* p { y };

    // While we haven't reached the leaves.
    while (y != tree.nil) {
        p = y;

        if (y->data == n->data) {
            // early return
            return;
        } else if (y->data < n->data) {
            y = y->right;
        } else {
            y = y ->left;
        }
    }

    //std::cout << p->data << '\n';

    // p is now the parent of n
    n->parent = p;
    n->left = tree.nil;
    n->right = tree.nil;

    // we are guaranteed that p is not a nullptr;
    if (p->data < n->data) {
        p->right = n;
    } else {
        p->left = n;
    }

    insert_fix_up(tree, n);
}

void insert(RBTree& tree, int k) {
    Node* n { new Node(k) };

    if (tree.root == tree.nil) {
        n->color = BLACK;
        n->left = tree.nil;
        n->right = tree.nil;
        tree.root = n;
    } else {
        
        insert(tree, n);
    }
}