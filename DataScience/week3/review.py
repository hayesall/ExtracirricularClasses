'''
A brief discussion on Python Lambda.
'''

# Example 1:
square_func = lambda x : x**2
print(square_func(4))

# Example 2:
close_enough = lambda x, y: abs(x - y) < 3
print(close_enough(2, 4))

# Example 3:

def get_func(n):
    return lambda x : x * n + x % n

my_func = get_func(13)
for i in range(5):
    print(13, my_func(i))
