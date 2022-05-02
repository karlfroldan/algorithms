#include <iostream>
#include <iomanip>

void display_matrix(int**, int, int);
int** slow_multiply(int**, int**, int, int, int);

int main() {
    int m1, n1, m2, n2;

    std::cin >> m1 >> n1;

    int** A = new int*[m1];
    
    for (int i = 0; i < m1; ++i) {
        A[i] = new int[n1];
    }

    for (int i = 0; i < m1; ++i) {
        for (int j = 0; j < n1; ++j) {
            std::cin >> A[i][j];
        }
    }

    std::cin >> m2 >> n2;
    
    int** B = new int*[m2];

    for (int i = 0; i < m2; ++i) {
        B[i] = new int[n2];
    }

    for (int i = 0; i < m2; ++i) {
        for (int j = 0; j < n2; ++j) {
            std::cin >> B[i][j];
        }
    }

    display_matrix(A, m1, n1);
    std::cout << "\n";
    display_matrix(B, m2, n2);
    std::cout << "\n";

    int** C = slow_multiply(A, B, m1, n1, n2);

    std::cout << "A * B = \n";
    display_matrix(C, m1, n2);
    
    return 0;
}

void display_matrix(int** A, int m, int n) {
    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            std::cout << std::left << std::setw(5) << A[i][j] << " ";
        }
        std::cout << "\n";
    }
}

int** slow_multiply(int** A, int** B, int m, int n, int p) {
    // A is (m, n) and B is (n, p). C will be (m, p)
    int** C = new int*[m];
    for (int i = 0; i < m; ++i) {
        C[i] = new int[p];
    }

    // For each row of A
    for (int i = 0; i < m; ++i) {
        // For each column of B
        for (int j = 0; j < p; ++j) {
            int result = 0;
            // For each row of B and column of A
            for (int k = 0; k < n; ++k) {
                result += A[i][k] * B[k][j];
            }

            C[i][j] = result;
        }
    }

    return C;
}