#include <iostream>
#include "AVL.hpp"

int main()
{
    AVLTree<int> tree = emptytree<int>();
    int input;

    while (std::cin >> input)
    {
        insert(&tree, input);
    }

    inorder(&tree);

    print_tree(&tree);

    remove(&tree, 4);
    remove(&tree, 7);
    remove(&tree, 2);
    print_tree(&tree);

    return EXIT_SUCCESS;
}