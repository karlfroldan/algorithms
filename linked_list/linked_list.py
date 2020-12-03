class Node:
    def __init__(self, k, v):
        self.next = None
        self.prev = None 
        self.key  = k 
        self.value= v 
    def __str__(self):
        return "{} ".format(self.key)

class LinkedList:
    def __init__(self):
        self.head = None
        self.tail = None
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
            return_str += "{} ".format(node)
            node = node.next
        return return_str

n = LinkedList()
n.insert("hello", 10)
n.insert("I am", 1)
n.insert("Wallet", 20)

find = n.search("Wallet")
print("find: {}={}".format(find, find.value))

n.delete("Wallet")

print("The node is: \"{}\"".format(n))