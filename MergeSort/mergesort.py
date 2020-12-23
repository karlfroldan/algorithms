import time
import random
import sys

def msort(A):
    mergesort(A, 0, len(A)) 
def mergesort(A, p, r):
    if p < r - 1:
        q = (p + r) // 2
        mergesort(A, p, q)
        mergesort(A, q, r)
        merge(A, p, q, r)

def merge(A, p, q, r):
    left = A[p:q]
    right = A[q:r]
    
    sentinel = 1001
    left.append(sentinel)
    right.append(sentinel)

    i, j = 0, 0
    for k in range(p, r):
        if left[i] <= right[j]:
            A[k] = left[i]
            i += 1
        else:
            A[k] = right[j]
            j += 1


xs = open("random.txt", "r")
xs = list(map(int, list(xs)[0].split()))
begin = time.time_ns()
msort(xs)
end = time.time_ns()
end = time.time_ns()
ns = end - begin
s = ns / 1000000000
n = len(xs)
print("merge sort finished sorting {} elements in {}ns or {}s".format(n, ns, s))