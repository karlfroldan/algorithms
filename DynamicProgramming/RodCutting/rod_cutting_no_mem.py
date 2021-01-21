from time import time 

def cut_rod(p, n):
    if n == 0:
        return 0
    q = -1 # sentinel value
    for i in range(1, n + 1):
        idx = i - 1
        q = max(q, p[idx] + cut_rod(p, n - i))
    return q


table = [
    1,  # $1 for 1-inch
    3,  # $3 for 2-inch
    5,  # $4 for 3-inch
    6,  # $6 for 4-inch
    9,  # $9 for 5-inch
    9, # $13 for 6-inch
    12, # $17 for 7-inch
    13, # 8
    16, # 9
    26, # 10
    28, # 11
    30, # 12
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
n = cut_rod(table, 21)
end = time()
print(n)
print('executed in {}s'.format(end - begin))