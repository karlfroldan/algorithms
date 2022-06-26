def lcs(X, Y):
    m, n = len(X), len(Y)

    # Table in row-major order.
    c = [[0 for _ in range(n + 1)] for _ in range(m + 1)]
    # 1 for diagonal, 2 for up, and 3 for left.
    d = [[0 for _ in range(n)] for _ in range(m)]

    for i in range(1, m + 1):
        for j in range(1, n + 1):
            a, b = i - 1, j - 1

            if X[a] == Y[b]:
                # Move diagonally.
                c[i][j] = c[i - 1][j - 1] + 1
                d[i - 1][j - 1] = 1

            elif c[i][j - 1] >= c[i - 1][j]:
                # Move up
                c[i][j] = c[i][j - 1]
                d[i - 1][j - 1] = 2
            else:
                # move left.
                c[i][j] = c[i - 1][j]
                d[i - 1][j - 1] = 3
    return c, d

def get_lcs(X, b, i, j):
    if i < 0 or j < 0:
        return
    
    if b[i][j] == 1:
        get_lcs(X, b, i - 1, j - 1)
        print(X[i], sep=' ')
    elif b[i][j] == 2:
        get_lcs(X, b, i - 1, j)
    else:
        get_lcs(X, b, i, j - 1)

if __name__ == '__main__':
    s1 = input()
    s2 = input()

    print(f'string 1: {s1}\nstring 2: {s2}')

    l, m = lcs(s1, s2)

    a, b = len(m), len(m[0])

    get_lcs(s1, l, a, b)