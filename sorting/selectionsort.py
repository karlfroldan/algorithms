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

n = int(sys.argv[1])
b = []
for i in range(n):
    r = random.randint(0, 1000)
    b.append(r)

begin = time.time_ns()
selectionsort(b)
end = time.time_ns()
end = time.time_ns()
ns = end - begin
s = ns / 1000000000
print("selection sort finished sorting {} elements in {}ns or {}s".format(n, ns, s))