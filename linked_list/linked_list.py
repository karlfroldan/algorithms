class Node:
    def __init__(self, k, v):
        self.next = None
        self.prev = None 
        self.key  = k 
        self.value= v 
    def __str__(self):
        return "{}".format(self.key)

class LinkedList:
    def __init__(self):
        self.head = None
        self.tail = None

    def __len__(self):
        c = 0
        n = self.head 
        while n is not None:
            c += 1
            n = n.next
        return c        

    def insert(self, k, v):
        new_node = Node(k, v)
        if self.head is None:
            self.head = new_node
            self.tail = new_node 
        else:
            # Insert into tail
            self.tail.next = new_node
            new_node.prev  = self.tail 
            self.tail      = new_node

    def search(self, k):
        node = self.head 
        while node is not None:
            if node.key == k:
                return node 
            else:
                node = node.next
        return node
    
    def remove(self, x):
        if x.next is None: #we're tail
            self.tail = self.tail.prev
        if x.prev is None: #we're head
            self.head = self.head.next
        if x.prev is not None:
            x.prev.next = x.next
        if x.next is not None:
            x.next.prev = x.prev
        

    def delete(self, k):
        node = self.head 
        while node is not None:
            if node.key == k:
                if node.next is None and node.prev is None:
                    self.head = None 
                    self.tail = None 
                elif node.next is None and node.prev is not None:
                    # We're the tail
                    node.prev.next = None
                    self.tail = node.prev
                elif node.next is not None and node.prev is None:
                    # We're the head!
                    node.next.prev = None 
                    self.head = node.next 
                else:
                    # Not none both sides
                    node.next.prev = node.prev 
                    node.prev.next = node.next
                break
            else:
                node = node.next

    def __str__(self):
        node = self.head 
        return_str = ""
        while node is not None:
            return_str += "{}".format(node)
            node = node.next
            if node is not None:
                return_str += ", "
        return "[{}]".format(return_str)
