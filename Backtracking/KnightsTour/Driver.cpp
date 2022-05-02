#include <iostream>
#include "Algorithm.hpp"
#include <sstream>

int main(int argc, char* argv[])
{
    int squares = 8;

    if (argc == 2)
    {
        std::istringstream ss(argv[1]);
        if (!(ss >> squares))
        {
            std::cerr << "Invalid number! Exiting...\n";
            return EXIT_FAILURE;
        }
        else if (!ss.eof())
        {
            std::cerr << "Trailing characters after number! Exiting...\n";
            return EXIT_FAILURE;
        }
    }

    std::cout << "x = " << squares << std::endl;

    solver(squares);

    return EXIT_SUCCESS;
}