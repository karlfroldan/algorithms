from quicksort import qsort

def test_none():
    arr = []
    qsort(arr)
    assert [] == arr

def test_singleton():
    arr = [1]
    qsort(arr)
    assert [1] == arr

def test_ascending():
    arr = [1,2,3,4,5,6,7,8,9,10]
    qsort(arr)
    assert [1,2,3,4,5,6,7,8,9,10] == arr

def test_descending():
    arr = [10, 9, 8, 7, 6, 5, 4,  3, 2, 1]
    qsort(arr)
    assert [1,2,3,4,5,6,7,8,9,10] == arr

def test_random():
    arr = [10,5,6,2,3,1,4,8,9,7]
    qsort(arr)
    assert [1,2,3,4,5,6,7,8,9,10] == arr

tests = [test_none, test_singleton, test_ascending, test_descending, test_random]

for test in tests:
    print('Executing {}...'.format(test.__name__))
    test()

print("Done...")