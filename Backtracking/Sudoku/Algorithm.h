#ifndef ALGORITHM_H
#define ALGORITHM_H

#include <vector>

typedef std::vector<std::vector<int>> Board;

void print_board(Board*);
void init_board(Board*);
bool solve(Board*);

#endif 