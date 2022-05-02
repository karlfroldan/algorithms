from time import time

def fib(n):
    a = 1
    b = 1

    if n <= 2:
        return 1
    for k in range(1, n):
        temp = a + b
        a = b
        b = temp
    return a

# 1, 1, 2, 3, 5, 8, 13, 21
    
begin = time()
print('fib({})={}'.format(999, fib(999)))
end = time() 
print('Time elapsed: {}s'.format(end - begin))