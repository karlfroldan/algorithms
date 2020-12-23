def binary_search(A, p, r, k):
    if p < r:
        q = (p + r) // 2
        if A[q] == k:
            return q 
        elif A[q] < k:
            return binary_search(A, q + 1, r, k)
        else:
            return binary_search(A, p, q - 1, k)
    else:
        return -1

a = [i**2 for i in range(100)]

x = binary_search(a, 0, len(a), 6561)
assert x == 81
x = binary_search(a, 0, len(a), 1000)
assert x == -1