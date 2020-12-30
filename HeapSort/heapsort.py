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
        """
        Maintains the heap property of a subtree
        """
        l = left(i)
        r = right(i)
        if l <= self.heap_size and self.A[l] > self.A[i]:
            largest = l
        else:
            largest = i
        if r <= self.heap_size and self.A[r] > self.A[largest]:
            largest = r
        
        if largest != i:
            self.A[i], self.A[largest] = self.A[largest], self.A[i]
            self.max_heapify(largest)     

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