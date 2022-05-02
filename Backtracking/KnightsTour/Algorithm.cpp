#include "Algorithm.hpp"
#include <vector>
#include <iostream>
#include <iomanip>
#include <cmath>

typedef std::vector<std::vector<int>> Board;

void print_board(Board* board)
{
    // Row
    for (int i = 0; i < board->size(); ++i)
    {
        // Col
        for (int j= 0; j < board->size(); ++j)
        {
            std::cout
                << std::left
                << std::setw(5)
                << (*board)[i][j];
        }

        std::cout << std::endl;
    }
}

bool allowed(int x, int y, Board* board)
{
    size_t board_size = board->size();
    return x >= 0 && y >= 0 && // we're still inside the board's boundaries
        x < board_size && y < board_size && 
        (*board)[x][y] == -1; // we still haven't visited that part of the board
}

bool solver_util(int n, Board* board, int current_x, int current_y, int move_x[], int move_y[], int pos)
{
    // A recursive utility function

    if (pos == pow(n, 2))
        return true;
    
    // We want to try all the possible moves from the current
    // coordinates
    for (int i = 0; i < 8; i++)
    {
        int x = current_x + move_x[i];
        int y = current_y + move_y[i];

        if (allowed(x, y, board))
        {
            // Then we change this part of the board 
            (*board)[x][y] = pos;

            if (solver_util(n, board, x, y, move_x, move_y, pos + 1))
                return true;
            
            // Backtrack
            (*board)[x][y] = -1;
        }
    }

    return false;
}

void solver(int n)
{
    int pos;
    Board board;
    // Initialize to zeros

    for (int i = 0; i < n; ++i)
    {
        std::vector<int>* col = new std::vector<int>(n, -1);
        board.push_back(*col);
    }

    int move_x[] = {2, 1, -1, -2, -2, -1, 1, 2};
    int move_y[] = {1, 2, 2, 1, -1, -2, -2, -1};

    // The knight is initially at the first block.
    board[0][0] = 0;

    // step counter for knight's position
    pos = 1;

    if (!solver_util(n, &board, 0, 0, move_x, move_y, pos))
        std::cout << "Solution does not exist!\n";
    else
        print_board(&board);
}

