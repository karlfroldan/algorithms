from time import time 

def cut_rod(p, n):
    r = [0 for _ in range(n + 1)]
    s = [0 for _ in range(n + 1)]
    # Revenue at 0-inch is $0
    r[0] = 0
    # For all j-inch from 1 to n-inch
    for j in range(1, n + 1):
        # We have a sentinel value
        q = -1 
        # We have to check all subproblems before j
        for i in range(1, j + 1):
            # Consider whether the running maximum is greater than the current subproblem revenue
            if q < p[i - 1] + r[j - i]:
                q = p[i - 1] + r[j - i]
                s[j] = i
        r[j] = q
    return r, s

def print_solution(p, n):
    (r, s) = cut_rod(p, n)
    while n > 0:
        print('right rod is {} inches'.format(s[n]))
        n = n - s[n]

table = [
    1,  # $1 for 1-inch
    5,  # $3 for 2-inch
    8,  # $4 for 3-inch
    9,  # $6 for 4-inch
    10,  # $9 for 5-inch
    17,  # $13 for 6-inch
    17, # $17 for 7-inch
    20, # 8
    24, # 9
    28, # 10
    30, # 11
    31, # 12
    32, # 13
    38, # 14
    39, # 15
    42, # 16
    44, # 17
    48, # 18
    50, # 19
    51, # 20
    52, # 21
    57, # 22
    61, # 23
    65, # 24
    67, # 25
    68, # 26
    80, # 27
]

begin = time()
r, s = cut_rod(table, 21)
end = time()

print('Price of most optimal: {}'.format(r[len(r) - 1]))

n = int(input('Input a number <= 27: '))

print('SOLUTION of {}'.format(n))
print_solution(table, n)

print('executed in {}s'.format(end - begin))