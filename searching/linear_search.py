def linear_search(A, k):
    for i in range(len(A)):
        if k == A[i]:
            return i 
    return -1

a = [3, 4, 6, 8, 2, 5, 8, 9, 2, 5, 8, 4, 6, 2, 2, 7, 2]
x = linear_search(a, 4)
assert x==1