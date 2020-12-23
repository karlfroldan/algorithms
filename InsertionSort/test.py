from insertionsort import isort

def test_empty():
    a = []
    isort(a)
    assert a == []

def test_singleton():
    a = [1]
    isort(a)
    assert a == [1]

def test_ordered():
    a = [1,2,3,4,5,6,7,8,9,10]
    isort(a)
    assert a == [1,2,3,4,5,6,7,8,9,10]

def test_unordered():
    a = [10, 9, 8, 7, 6, 5, 4, 3, 2, 1]
    isort(a)
    assert a == [1,2,3,4,5,6,7,8,9,10]

tests = [test_empty, test_singleton, test_ordered, test_unordered]

for f in tests:
    print('Executing {}...'.format(f.__name__))
    f()
print("Done...")