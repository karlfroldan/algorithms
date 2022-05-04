#include <iostream>
#include "rbt.hpp"

int main() {
    RBTree tree;
    int input;

    

    while (std::cin >> input) {

        insert(tree, input);

    }

    inorder(tree);
    std::cout << "\n";

    printtree(tree);

    std::cout << '\n';
    check_rbt_property(tree);

    return 0;
}