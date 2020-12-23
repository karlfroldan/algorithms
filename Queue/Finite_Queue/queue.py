class Queue:
    def __init__(self):
        self.A = [None for i in range(1000)]
        self.head = 0
        self.tail = 0
    def __str__(self):
        return str(self.A[self.head : self.tail])
    def enqueue(self, x):
        self.A[self.tail] = x
        if self.tail == len(self.A):
            self.tail = 0
        else:
            self.tail = self.tail + 1
    def dequeue(self):
        x = self.A[self.head]
        if self.head == len(self.A):
            self.head = 0
        else:
            self.head = self.head + 1
        return x
            


q = Queue()

q.enqueue(30)
q.enqueue(60)
q.enqueue(90)
q.enqueue(120)
q.enqueue(4)
q.enqueue(2)
print(q)
x = q.dequeue()


print(x)
print(q)