#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

int longest_increasing_subsequence(std::vector<int>&);

int main() {

    int x;
    std::vector<int> s; // {10, 22, 9, 33, 21, 50, 41, 60, 80};

    while (std::cin >> x) {
        s.push_back(x);
    }

    auto lis = longest_increasing_subsequence(s);

    std::cout << "The longest increasing subsequence is: " << lis << "\n";

    return 0;
}

std::vector<size_t> smaller_indices(std::vector<int>& sequence, size_t n) {
    std::vector<size_t>* smaller = new std::vector<size_t>();
    //std::cout << "smaller: ";
    for (size_t i = 0; i < n; ++i) {
        //std::cout << sequence[i] << " `comparing with` " << sequence[n] << "\n";
        if (sequence[i] < sequence[n]) {
            //std::cout << sequence[i] << " < " << sequence[n] << "\n";
            smaller->push_back(i);
            //std::cout << sequence[i] << " ";
        }
    }
    //std::cout << std::endl;

    return *smaller;

}

int maximum(std::vector<int>& v) {
    int max = INT_MIN;

    for (int i = 0; i < v.size(); ++i) {
        if (max < v[i]) {
            max = v[i];
        }
    }
    return max;
}

int lis_aux(std::vector<int>& seq, std::vector<int>& memo, size_t n) {
    // Get the indices of numbers that are smaller than seq[n]
    std::vector<size_t> smaller_idxs = smaller_indices(seq, n);

    if (smaller_idxs.empty()) {
        memo[n] = 1;   // No such j existed.
        return 1;
    } else {
        int max = INT_MIN;
        // For each of those indices j, get the LIS.
        for (int i = 0; i < smaller_idxs.size(); ++i) {
            if (memo[smaller_idxs[i]] == -1) {
                // We haven't memoized. We need to compute the LIS first.
                memo[smaller_idxs[i]] = lis_aux(seq, memo, smaller_idxs[i]);
                max = std::max(max, memo[smaller_idxs[i]]);
            } else {
                // Just get the memoized solution.
                max = std::max(max, memo[smaller_idxs[i]]);
            }
        }
        memo[n] = 1 + max;
        return memo[n];
    }
}

int longest_increasing_subsequence(std::vector<int>& sequence) {
    size_t n = sequence.size();
    std::vector<int> memo(n, -1);

    for (int i = 0; i < n; ++i) {
        lis_aux(sequence, memo, i);
    }

    return maximum(memo);
}