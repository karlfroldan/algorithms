def parent(i):
    return i // 2
def left(i):
    return i << 1
def right(i):
    return (i << 1) + 1

class PriorityQueue:
    def __init__(self):
        self.A = [0 for i in range(100)]
        self.length = len(self.A)
        self.heap_size = 0
    def __str__(self):
        return str(self.A[0:self.heap_size])
    def __len__(self):
        return self.heap_size

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
    
    def heap_maximum(self):
        """
        Gets the maximum key from the heap
        """
        return self.A[0]
    def heap_extract_max(self):
        if self.heap_size < 1: # Empty heap
            raise Exception("underflow")
        # The return value
        max = self.A[0]
        # Replace the root
        self.A[0] = self.A[self.heap_size - 1]
        # Decrement the heap size
        self.heap_size -= 1
        # Rebuild the binary heap
        # with the new maximum element
        self.max_heapify(0)
        return max
    def heap_increase_key(self, i, key):
        """
        For some given index i, we can increase its
        priority order in the priority queue by increasing
        its key.
        """
        if key < self.A[i]:
            raise Exception("new key is smaller than current key")\
        # Change the key
        self.A[i] = key
        # And fix the heap
        while i > 0 and self.A[parent(i)] < self.A[i]:
            self.A[i], self.A[parent(i)] = self.A[parent(i)], self.A[i]
            i = parent(i)
    def max_heap_insert(self, key):
        self.heap_size = self.heap_size + 1
        self.A[self.heap_size] = -10000000
        self.heap_increase_key(self.heap_size, key)

heap = PriorityQueue()
heap.max_heap_insert(89)
heap.max_heap_insert(100)
heap.max_heap_insert(3)
heap.max_heap_insert(4)

print("priority queue: {}".format(heap))
print("length: {}".format(len(heap)))