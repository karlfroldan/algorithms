#pragma once 

enum Color {
    RED, BLACK
};

struct Node {
    int data;
    Node *parent, *left, *right;
    Color color;

    Node() : data {0} {}
    Node(int k) : data {k} {}
};

struct RBTree {
    Node* root;
    Node* nil;

    RBTree() {
        Node* empty { new Node };
        empty->color = BLACK;
        this->root = empty;
        this->nil = empty;
    }
};

void printtree(RBTree&);
void insert(RBTree&, int);