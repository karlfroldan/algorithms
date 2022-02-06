#ifndef BST_HPP
#define BST_HPP

#include <iostream>
#include <string>

template <typename T>
struct Node
{
    T key;
    Node* parent;
    Node* left;
    Node* right;
};

template <typename T>
struct Tree {
    Node<T>* root;
};

template <typename T>
bool has_no_children(Node<T>* n)
{
    return n->left == nullptr && n->right == nullptr;
}

template <typename T>
bool has_one_child(Node<T>* n)
{
    if (n->left == nullptr && n->right != nullptr)
        return true;
    else if (n->right == nullptr && n->left != nullptr)
        return true;
    else 
        return false;
}

template <typename T>
void print_tree(Node<T>* t, int depth)
{
    if (t != nullptr)
    {
        std::string blanks(depth * 2, ' ');
        std::cout << blanks << "> " << t->key << std::endl;
        print_tree(t->left, depth + 1);
        print_tree(t->right, depth + 1);
    }
}

template <typename T>
void print_tree(Tree<T>* t) { print_tree(t->root, 0); }

// Tree search
template <typename T>
Node<T>* search(Node<T>* t, T key)
{
    if (t == nullptr)
        return nullptr;

    if (t->key == key)
        return t;

    if (t->key < key)
        return search(t->right, key);
    else 
        return search(t->left, key);
}

template <typename T>
Node<T>* search(Tree<T>* t, T key) { return search(t->root, key); }

template <typename T>
Node<T>* minimum(Node<T>* t)
{
    Node<T>* min;
    if (t == nullptr)
        return nullptr;
    
    min = t;
    while (min->left != nullptr)
        min = min->left;
    return min;
}

template <typename T>
Node<T>* maximum(Node<T>* t)
{
    Node<T>* max;
    if (t == nullptr)
        return nullptr;
    
    max = t;
    while (max->right != nullptr)
        max = max->right;
    return max;
}

template <typename T>
Node<T>* maximum(Tree<T>* t) { return maximum(t->root); }

template <typename T>
Node<T>* minimum(Tree<T>* t) { return minimum(t->root); }

template<typename T>
void insert(Tree<T>* t, T key)
{
    Node<T>* n = new Node<T> {
        key, nullptr, nullptr, nullptr
    };

    if (t->root == nullptr)
        t->root = n;
    else 
        insert(t->root, n);
}

template <typename T>
void insert(Node<T>* p, Node<T>* n) 
{
    if (n->key < p->key)
    {
        if (p->left == nullptr)
        {
            n->parent = p;
            p->left = n;
        }
        else 
            insert(p->left, n);
    }
    else if (n->key > p->key)
    {
        if (p->right == nullptr)
        {
            n->parent = p;
            p->right = n;
        }
        else
            insert(p->right, n);
    }
}

template <typename T>
void swap_keys(Node<T>* n, Node<T>* m)
{
    T temp = n->key;
    n->key = m->key;
    m->key = temp;
}



template <typename T>
void remove(Tree<T>* t, Node<T>* n)
{
    // Leaf nodes have no children
    if (has_no_children(n))
    {
        // Check if n is root
        if (n == t->root)
            t->root = nullptr;
        // Check if n is the left child 
        else if (n->parent->left == n)
        {
            n->parent->left = nullptr;
            n->parent = nullptr;
        }
        else 
        {
            n->parent->right = nullptr;
            n->parent = nullptr;
        }

        // We are done.
    }
    else if (has_one_child(n))
    {
        // Check if the child is right or left
        if (n->left != nullptr)
        {
            if (n->parent == nullptr)
            {
                t->root = n->left;
                n->left->parent = nullptr;
                n->left = nullptr;
            }
            else
            {
                n->parent->left = n->left;
                n->left->parent = n->parent;
                n->left = nullptr;
                n->parent = nullptr;
            }
        }
        else 
        {
            if (n->parent == nullptr)
            {
                t->root = n->right;
                n->right->parent = nullptr;
                n->right = nullptr;
            }
            else
            {
                n->parent->right = n->right;
                n->right->parent = n->parent;
                n->right = nullptr;
                n->parent = nullptr;
            }
        }
    }
    else // Has two children 
    {
        // We find the successor by getting the leftmost descendant
        // in its right subtree.
        Node<T>* successor = minimum(n->right);
        swap_keys(n, successor);

        // We have reduced the problem to the first case
        remove(t, successor);
    }
}

template <typename T>
void remove(Tree<T>* t, T key)
{
    Node<T>* n = search(t, key);

    if (n != nullptr)
        remove(t, n);
}

#endif // BST_HPP