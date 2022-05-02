#include <iostream>
#include "BST.hpp"

typedef Tree<int> int_tree;

int main(int argc, char* argv[])
{
    int input;
    int_tree t = emptytree<int>();

    while (std::cin >> input)
    {
        //std::cout << input << std::endl;
        insert(&t, input);        
    }

    print_tree(&t);
    std::cout << "-------------------" << std::endl;
    std::cout << "After deletions:\n";
    remove(&t, 56); // Remove no children
    remove(&t, -56); // Remove one child.
    remove(&t, 3); // Remove two children.
    remove(&t, 1); // Remove root.
    print_tree(&t);
}