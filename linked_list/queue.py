from copy import deepcopy
from linked_list import LinkedList

class Queue:
    def __init__(self):
        self.list = LinkedList()
        self.tail = self.list.tail 
    def __len__(self):
        return len(self.list)
    def __str__(self):
        return str(self.list)
    def enqueue(self, x):
        self.list.insert(x, None)
        self.tail = self.list.tail 
    def dequeue(self):
        x = deepcopy(self.list.head)
        self.list.remove(self.list.head)
        return x 

q = Queue()
q.enqueue(60)
q.enqueue(100)
q.enqueue(120)
q.enqueue(150)
print(q)
x = q.dequeue()
print(x)
x = q.dequeue()
print(x)
print(q)