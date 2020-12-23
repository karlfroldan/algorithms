class Stack:
    def __init__(self):
        self.A = [None for i in range(1000)]
        self.top = 0
    def __str__(self):
        return str(self.A[0:self.top])
    def stack_empty(self):
        return self.top == 0
    def push(self, x):
        self.A[self.top] = x
        self.top += 1
    def pop(self):
        if self.stack_empty():
            raise Exception("underflow")
        else:
            self.top = self.top - 1
            return self.A[self.top]

s = Stack()

s.push(60)
s.push(100)
s.push(120)
x = s.pop()
x = s.pop()
x = s.pop()
assert s.stack_empty()