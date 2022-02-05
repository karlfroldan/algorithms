#include <iostream>
#include <string>
#include "Algorithm.h"

int main(int argc, char* argv[])
{
    int r = 0;
    int c = 0;
    int in;
    Board board;

    // if (argc < 2)
    // {
    //     std::cerr << "Please input a filename... Exiting...\n";
    //     return EXIT_FAILURE;
    // }

    init_board(&board);

    while (std::cin >> in)
    {
        // //std::cout << in << " ";
        // std::cout << r << " " << c << " | ";
        board[r][c] = in;
        c++;

        if (c == 9)
        {
            r++;
            c = 0;
        }
    }

    print_board(&board);

    std::cout << "-----------------------------------------" << std::endl;
    if (solve(&board))
        print_board(&board);
    else 
        std::cout << "No solution found...\n";

    return EXIT_SUCCESS;
}