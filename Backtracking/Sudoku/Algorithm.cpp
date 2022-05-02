#include "Algorithm.h"
#include <iomanip>
#include <iostream>

bool group_possible(Board* b, int r, int c, int color)
{
    int r_lower = r / 3; // Lower bounds
    int c_lower = c / 3;

    // std::cout << r_lower * 3 << " " << r_lower * 3 + 2 << std::endl;
    // std::cout << c_lower * 3 << " " << c_lower * 3 + 2 << std::endl;

    // We check if any of the numbers in the group are equal to the color
    for (int i = r_lower * 3; i < r_lower * 3 + 3; ++i)
    {
        //std::cout << r_lower * 3 << " " << r_lower * 3 + 2 << std::endl;
        for (int j = c_lower * 3; j < c_lower * 3 + 3; ++j)
        {
            //std::cout << c_lower * 3 << " " << c_lower * 3 + 2 << std::endl;
            //std::cout << i << " " << j << " | ";
            //std::cout << "b[" << i << "][" << j << "] = " << (*b)[i][j] << std::endl;
            if ((*b)[i][j] == color)
                return false;
        }
    }
    return true;
}

bool row_possible(Board* b, int r, int c, int color)
{
    for (int i = 0; i < 9; ++i)
    {
        if ((*b)[r][i] == color)
            return false;
    }
    return true;
}

bool column_possible(Board* b, int r, int c, int color)
{
    for (int i = 0; i < 9; ++i)
    {
        if ((*b)[i][c] == color)
            return false;
    }
    return true;
}

bool possible(Board* b, int r, int c, int color)
{
    return group_possible(b, r, c, color) &&
        row_possible(b, r, c, color) && 
        column_possible(b, r, c, color);
}

void find_empty_location(Board* b, int* r, int* c)
{
    for (int i = 0; i < 9; ++i)
    {
        for (int j = 0; j < 9; ++j)
        {
            if ((*b)[i][j] == 0)
            {
                *r = i;
                *c = j;
            }
        }
    }
}

bool is_solved(Board* b)
{
    for (int i = 0; i < 9; ++i)
    {
        for (int j = 0; j < 9; ++j)
        {
            if ((*b)[i][j] == 0)
                return false;
        }
    }
    return true;
}

void print_board(Board* b)
{
    size_t b_size = b->size();

    for (int i = 0; i < b_size; ++i)
    {
        for (int j = 0; j < b_size; ++j)
        {
            std::cout << std::left << std::setw(5) << (*b)[i][j];
        }
        std::cout << std::endl;
    }
}

void init_board(Board* b)
{
    size_t b_size = 9;

    for (int i = 0; i < b_size; ++i)
    {
        std::vector<int>* r = new std::vector<int>(b_size, 0);
        b->push_back(*r);
    }
}

bool solve(Board* b)
{
    int x, y;
    x = -1;
    y = -1;

    find_empty_location(b, &x, &y);

    // No more location
    if (x == -1 && y == -1)
        return true;

    // Find color 
    for (int k = 1; k < 10; ++k)
    {
        if (possible(b, x, y, k))
        {
            (*b)[x][y] = k;
            if (solve(b))
                return true;
            (*b)[x][y] = 0; // backtrack
        }
    }
    return false;
}