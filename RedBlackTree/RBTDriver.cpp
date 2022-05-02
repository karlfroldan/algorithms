#include <iostream>

#include "RBT.hpp"

int main(int argc, char* argv[]) {
    int input;
    RBTree tree;

    printtree(tree);
    
    // int_tree t = emptytree<int>();

    while (std::cin >> input) {
        insert(tree, input);        
    }

    printtree(tree);
}