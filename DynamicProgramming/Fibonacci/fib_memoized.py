from time import time

# This memoized function takes a global dictionary
# to check if fib(n) is already stored in there.
# Check `fib_bottoms_up.py` for a version that
# does not use global variables at all.
def fib(n):
    if n in memo:
        return memo[n]
    if n <= 2:
        f = 1
    else:
        f = fib(n - 1) + fib(n - 2)
    memo[n] = f 
    return f
    
memo = {}

begin = time()
print('fib({})={}'.format(999, fib(999)))
end = time() 
print('Time elapsed: {}s'.format(end - begin))