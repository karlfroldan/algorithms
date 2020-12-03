from copy import deepcopy
from linked_list import LinkedList

class Stack:
    def __init__(self):
        self.list = LinkedList()
        self.top = None
    def __len__(self):
        return len(self.list)
    def __str__(self):
        return str(self.list)
    def push(self, x):
        self.list.insert(x, None)
        self.top = self.list.tail 
    def stack_empty(self):
        return self.top is None
    def pop(self):
        if self.stack_empty():
            raise Exception("underflow")
        else:
            x = deepcopy(self.top)
            self.list.remove(self.list.tail)
            return x

s = Stack()

s.push(60)
s.push(100)
s.push(120)
print(s)
x = s.pop()
print(x)
x = s.pop()
print(x)
print(s)
x = s.pop()