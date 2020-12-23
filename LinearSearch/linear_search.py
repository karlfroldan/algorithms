def linear_search(A, k):
    for i in range(len(A)):
        if k == A[i]:
            return i 
    return None