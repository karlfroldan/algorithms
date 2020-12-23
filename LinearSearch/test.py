from linear_search import linear_search

def test_none():
    a = [1, 10, 6, 4, 2, 8, 9, 10, 4]
    r = linear_search(a, -1)
    assert r is None 

def test_singleton():
    a = [1]
    r = linear_search(a, 1)
    assert r == 0

def test_10_list():
    a = [10, 9, 8, 6, 5, 3, 2, 1, 4, 4]
    r = linear_search(a, 5)
    assert 4 == r

# Run tests
tests = [test_none, test_singleton, test_10_list]

for f in tests:
    print('Executing {}...'.format(f.__name__))
    f()
    
print("Done...")