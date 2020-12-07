import time
import random
import sys

def isort(A):
    for j in range(1, len(A)):
        key = A[j]
        # Insert A[j] into the sorted sequence A[0..j-1].
        i = j - 1
        while i >= 0 and A[i] > key:
            A[i + 1] = A[i]
            i -= 1
        A[i + 1] = key


xs = open("random.txt", "r")
xs = list(map(int, list(xs)[0].split()))
begin = time.time_ns()
isort(xs)
end = time.time_ns()
end = time.time_ns()
ns = end - begin
s = ns / 1000000000
n = len(xs)
print("insertion sort finished sorting {} elements in {}ns or {}s".format(n, ns, s))