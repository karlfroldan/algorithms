import time
import random
import sys

def qsort(A):
    quicksort(A, 0, len(A) - 1)

def quicksort(A, p, r):
    if p < r:
        q = partition(A, p, r)
        quicksort(A, p, q - 1)
        quicksort(A, q + 1, r)

def swap(A, i, j):
    temp = A[i]
    A[i] = A[j]
    A[j] = temp

def partition(A, p, r):
    k = A[r]
    i = p - 1
    for j in range(p, r):
        if A[j] <= k:
            i += 1
            swap(A, i, j)
    swap(A, i + 1, r)
    return i + 1

xs = open("random.txt", "r")
xs = list(map(int, list(xs)[0].split()))
begin = time.time_ns()
qsort(xs)
end = time.time_ns()
end = time.time_ns()
ns = end - begin
s = ns / 1000000000
n = len(xs)
print("quick sort finished sorting {} elements in {}ns or {}s".format(n, ns, s))