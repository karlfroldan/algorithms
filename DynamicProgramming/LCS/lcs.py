def lcs(X, Y):
    m, n = len(X), len(Y)

    # Table in row-major order.
    c = [[0 for _ in range(n + 1)] for _ in range(m + 1)]

    for i in range(1, m + 1):
        for j in range(1, n + 1):
            a, b = i - 1, j - 1

            if X[a] == Y[b]:
                # Move diagonally.
                c[i][j] = c[i - 1][j - 1] + 1
            else:
                c[i][j] = max(c[i - 1][j], c[i][j - 1])

    _lcs = []

    # We start from the right-most-bottom.
    i, j = m, n
    while i > 0 and j > 0:
        if X[i - 1] == Y[j - 1]:
            _lcs.append(X[i - 1])
            i, j = i - 1, j - 1
        elif c[i - 1][j] > c[i][j - 1]:
            i = i - 1
        else:
            j = j - 1

    _lcs.reverse()
    return ''.join(_lcs)

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

    _lcs = lcs(s1, s2)

    print(f'LCS: {_lcs}')