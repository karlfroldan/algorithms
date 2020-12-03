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


n = int(sys.argv[1])
b = []
for i in range(n):
    r = random.randint(0, 1000)
    b.append(r)
begin = time.time_ns()
isort(b)
end = time.time_ns()
end = time.time_ns()
ns = end - begin
s = ns / 1000000000
print("insertion sort finished sorting {} elements in {}ns or {}s".format(n, ns, s))