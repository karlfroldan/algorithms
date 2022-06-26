#include <iostream>
#include <queue>

#include <vector>

using Matrix = std::vector<std::vector<int>>;

Matrix build_preferences(int);

int main(int argc, char* argv[]) {

    int n;

    std::cin >> n;

    auto men {build_preferences(n)};
    std::cin >> n;
    auto women {build_preferences(n)};


    return EXIT_SUCCESS;

}

Matrix build_preferences(int n) {

    int m;
    // an nxn matrix.
    Matrix preferences(n, std::vector<int>(n));

    for (auto i {0}; i < n; ++i) {
        for (auto j {0}; j < n; ++j) {
            // First one is the index of the person.
            // second one is their preference.
            std::cin >> m;
            preferences[i][j] = m;
        }
    }
    return preferences;
}