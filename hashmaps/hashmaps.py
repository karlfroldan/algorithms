from linked_list import LinkedList

def hash_this(x):
    if isinstance(x, int):
        x = (x >> 2) % 128
    else:
        x = hash(x) % 128
    print(x)
    return x

class Hashmap:
    def __init__(self):
        self.bins = [LinkedList() for i in range(128)]
    
    def put(self, k, v):
        key = hash_this(k)
        self.bins[key].insert(k, v)
    def remove(self, k):
        key = hash_this(k)
        self.bins[key].delete(k)
    def get(self, k):
        key = hash_this(k)
        return self.bins[key].search(k)

hs = Hashmap()
hs.put(10, "wallet")
hs.put(120, "is so awesome")
hs.put(1000, "fucking awesome")

print("key: {} | value: {}".format(10, hs.get(10).value))