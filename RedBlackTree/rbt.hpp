#pragma once 

struct Node {
    int data;
    Node *parent, *left, *right;
    bool isblack;

    Node(int k) {
        this->data = k;
        parent = nullptr;
        left = nullptr;
        right = nullptr;
        isblack = false;
    }
};

struct RBTree {
    Node* root;
    Node* nil;

    RBTree() {
        Node* nil = new Node(int());
        nil->isblack = true;
        this->root = nil;
        this->nil = nil;
    }
};

void inorder(RBTree&);
void printtree(RBTree&);
void insert(RBTree&, int);
void check_rbt_property(RBTree&);