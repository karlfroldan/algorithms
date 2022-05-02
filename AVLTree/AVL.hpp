#ifndef AVL_HPP
#define AVL_HPP

#include <iostream>
#include <algorithm>

template <typename T>
struct Node {
    T key;
    Node<T>* left;
    Node<T>* right;
    int height;
};

template <typename T>
struct AVLTree {
    Node<T>* root;
};


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
void print_tree(AVLTree<T>* t) { print_tree(t->root, 0); }

template <typename T>
void inorder(Node<T>* n)
{
    if (n != nullptr)
    {
        inorder(n->left);
        std::cout << n->key << " ";
        inorder(n->right);
    }
}

template <typename T>
void inorder(AVLTree<T>* t)
{
    inorder(t->root);
    std::cout << std::endl;
}

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
Node<T>* search(AVLTree<T>* t, T key) { return search(t->root, key); }

template <typename T>
AVLTree<T> emptytree()
{
    AVLTree<T>* t = new AVLTree<T> {nullptr};
    return *t;
}

template <typename T>
int height(Node<T>* n)
{
    if (n == nullptr)
        return 0;
    return n->height;
}

template <typename T>
int balance(Node<T>* n)
{
    if (n == nullptr)
        return 0;
    return height(n->left) - height(n->right);
}

template <typename T>
Node<T>* left_rotate(Node<T>* n)
{
    Node<T>* m = n->right;
    Node<T>* temp = m->left;

    // Rotate 
    m->left = n;
    n->right = temp;

    // Update heights 
    n->height = 1 + std::max(height(n->left), height(n->right));
    m->height = 1 + std::max(height(m->left), height(m->right));

    // Return the new root
    return m;
}

template <typename T>
Node<T>* right_rotate(Node<T>* n)
{
    Node<T>* m = n->left;
    Node<T>* temp = m->right;

    // Rotate 
    m->right = n;
    n->left = temp;

    // Update heights 
    n->height = 1 + std::max(height(n->left), height(n->right));
    m->height = 1 + std::max(height(m->left), height(m->right));

    // Return the new root
    return m;
}

template <typename T>
Node<T>* insert(Node<T>* n, T key)
{
    if (n == nullptr)
    {
        Node<T>* n = new Node<T> {
            key, nullptr, nullptr, 1
        };
        return n;
    }
    else if (key < n->key)
        n->left = insert(n->left, key);
    else if (key > n->key)
        n->right = insert(n->right, key);
    else // When there are the same keys
        return n;

    // Update the height of the ancestor
    n->height = 1 + std::max(
        height(n->left), height(n->right)
    );

    // Get the balance factor
    int b = balance(n);

    // If the node is unbalanced, try the four cases 
    if (b > 1 && key < n->left->key)
        return right_rotate(n);
    if (b < -1 && key > n->right->key)
        return left_rotate(n);
    if (b > 1 && key > n->left->key)
    {
        n->left = left_rotate(n->left);
        return right_rotate(n);
    }
    if (b < -1 && key < n->right->key)
    {
        n->right = right_rotate(n->right);
        return left_rotate(n);
    }
    return n;
}

template <typename T>
void insert(AVLTree<T>* t, T k)
{
    t->root = insert(t->root, k);
}

template <typename T>
Node<T>* minimum(Node<T>* n)
{
    if (n == nullptr || n->left == nullptr)
        return n;
    
    return minimum(n->left);
}

template <typename T>
Node<T>* maximum(Node<T>* n)
{
    if (n == nullptr || n->right == nullptr)
        return n;
    
    return maximum(n->right);
}

template <typename T>
Node<T>* remove(Node<T>* n, T key)
{
    // Perform BST delete
    if (n == nullptr)
        return n;
    else if (key < n->key)
        n->left = remove(n->left, key);
    else if (key > n->key)
        n->right = remove(n->right, key);  
    else 
    {
        if (n->left == nullptr)
        {
            Node<T>* temp = n->right;
            n = nullptr;
            return temp;
        }
        else if (n->right == nullptr)
        {
            Node<T>* temp = n->left;
            n = nullptr;
            return temp;
        }

        Node<T>* temp = minimum(n->left);
        n->key = temp->key;
        n->right = remove(n->right, temp->key);
    }

    // If key only has one node
    if (n == nullptr)
        return n;

    // Update the height
    n->height = 1 + std::max(height(n->left), height(n->right));

    // get balance
    int b = balance(n);

    if (b > 1 && balance(n->left) >= 0)
        return right_rotate(n);

    if (b < -1 && balance(n->right) <= 0)
        return left_rotate(n);

    if (b > 1 && balance(n->left) < 0)
    {
        n->left = left_rotate(n->left);
        return right_rotate(n);
    }

    if (b < -1 && balance(n->right) > 0)
    {
        n->right = right_rotate(n->right);
        return left_rotate(n);
    }

    return n;
}

template <typename T>
void remove(AVLTree<T>* t, T k)
{
    t->root = remove(t->root, k);
}

#endif 