import time
import random
import sys

def left(i):
    return i << 1
def right(i):
    return (i << 1) + 1

class Heap:
    def __init__(self, A):
        self.A = A
        self.length = len(A) - 1
        self.heap_size = len(A)
        self.heapsort()

    def max_heapify(self, i):
        while i < self.heap_size:
            l, r = left(i), right(i)
            largest = i
            if l <= self.heap_size and self.A[l] > self.A[largest]:
                largest = l
            if r <= self.heap_size and self.A[r] > self.A[largest]:
                largest = r 
            if largest != i:
                # Exchange
                self.A[i], self.A[largest] = self.A[largest], self.A[i]
                i = largest
            else:
                break
    def build_max_heap(self):
        self.heap_size = self.length
        for i in range(self.length // 2, -1, -1):
            self.max_heapify(i)
    def heapsort(self):
        self.build_max_heap()
        for i in range(self.length, 0, -1):
            self.A[0], self.A[i] = self.A[i], self.A[0]
            self.heap_size -= 1
            self.max_heapify(0)

def heapsort(A):
    h = Heap(A)
    return h.A

xs = open("random.txt", "r")
xs = list(map(int, list(xs)[0].split()))
begin = time.time_ns()
heapsort(xs)
end = time.time_ns()
end = time.time_ns()
ns = end - begin
s = ns / 1000000000
n = len(xs)
print("heap sort(iterative) finished sorting {} elements in {}ns or {}s".format(n, ns, s))