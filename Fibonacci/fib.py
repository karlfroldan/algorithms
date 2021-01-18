from time import time

def fib(n):
    if n <= 2:
        return 1
    else:
        return fib(n - 1) + fib(n - 2)

begin = time()
print('fib({})={}'.format(35, fib(35)))
end = time() 
print('Time elapsed: {}s'.format(end - begin))