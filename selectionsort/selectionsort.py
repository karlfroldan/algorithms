import time 
import random

def selectionsort(A): 
    for i in range(len(A)):
        min_idx = i
        for j in range(i + 1, len(A)):
            if A[min_idx] > A[j]:
                min_idx = j 
        # Swap
        A[i], A[min_idx] = A[min_idx], A[i]

a = [1,2,3,4,5,0,9,7,3]
selectionsort(a)
print(a)

n = 10000
b = []
for i in range(n):
    r = random.randint(0, 1000)
    b.append(r)
print("Begin sorting")
begin = time.time_ns()
selectionsort(b)
end = time.time_ns()
print("selection sort finished sorting {} elements in {}ns".format(n, (end - begin)))