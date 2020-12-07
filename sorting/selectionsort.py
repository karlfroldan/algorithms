import time 
import random
import sys

def selectionsort(A): 
    for i in range(len(A)):
        min_idx = i
        for j in range(i + 1, len(A)):
            if A[min_idx] > A[j]:
                min_idx = j 
        # Swap
        A[i], A[min_idx] = A[min_idx], A[i]

xs = open("random.txt", "r")
xs = list(map(int, list(xs)[0].split()))
begin = time.time_ns()
selectionsort(xs)
end = time.time_ns()
end = time.time_ns()
ns = end - begin
s = ns / 1000000000
n = len(xs)
print("selection sort finished sorting {} elements in {}ns or {}s".format(n, ns, s))