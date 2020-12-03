import time
import random

def isort(A):
    for j in range(1, len(A)):
        key = A[j]
        # Insert A[j] into the sorted sequence A[0..j-1].
        i = j - 1
        while i >= 0 and A[i] > key:
            A[i + 1] = A[i]
            i -= 1
        A[i + 1] = key

a = [1,2,3,4,5,0,9,7,3]
isort(a)
print(a)

n = 10000
b = []
for i in range(n):
    r = random.randint(0, 1000)
    b.append(r)
print("Begin sorting")
begin = time.time_ns()
isort(b)
end = time.time_ns()
print("merge sort finished sorting {} elements in {}ns".format(n, (end - begin)))