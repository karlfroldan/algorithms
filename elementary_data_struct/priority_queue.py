class PriorityQueue:
    def __init__(self):
        self.A = []
        self.length = len(self.A)
        self.heap_size = len(self.A)
    def __str__(self):
        return str(self.A)

    def from_list(self, A):
        self.A = A
        self.length = len(A) - 1
        self.build_max_heap()
    
    def max_heapify(self, i):
        """
        Maintains the heap property of a subtree
        """
        l = i << 1
        r = (i << 1) + 1
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

heap = PriorityQueue()
heap.from_list([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
print(heap)