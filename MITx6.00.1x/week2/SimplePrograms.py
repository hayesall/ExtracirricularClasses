# -*- coding: utf-8 -*-

# Week 2: Simple Programs
# 4: Functions

"""
Exercise: square
Write a Python function `square` that takes a number and returns its square.
"""

def square(x):
    return x * x

"""
Exercise: eval quadratic
"""

def evalQuadratic(a, b, c, x):
    return a * (x * x) + b * x + c

"""
Exercise: power iter
Write an iterative function `iterPower(base, exp)` that calculates the exponen-
tial base**exp by simply using successive multiplication. For example,
`iterPower(base, exp)` should compute base**exp by multiplying base by itself
exp times. Write such a function below.

The function should take in two values - `base` can be a float or an integer
>= 0. It should return one numerical value. Your code must be iterative - use
of the `**` operator is not allowed.
"""

def iterPower(base, exp):
    """My definition of iterPower"""
    result = 1
    for i in range(exp):
        result = result * base
    return result

def iterPower2(base, exp):
    """This uses the same form as the iterative multiplication example."""
    result = 1
    while exp > 0:
        result = result * base
        exp -= 1
    return result

"""
Exercise: power recur
In Problem 1, we computed an exponential by iteratively executing successive
multiplications. We can use the same idea, but in a recursive function. Write
a function `recurPower(base, exp)` which computes base**exp
"""

def recurPower(base, exp):
    """Recursive definition of recurPower."""
    if exp == 0:
        return 1
    else:
        return base * recurPower(base, exp - 1)

"""
Video: Towers of Hanoi

"What I want you to see here are two things:
    - I can have multiple recursive calls inside a function body.
    - This is a problem that I suggest is really hard to solve iteratively,
      but elegantly easy to solve recursively.
"""   

def printMove(fr, to):
    print("Move from " + str(fr) + " to " + str(to))
    
def Towers(n, fr, to, spare):
    if n == 1:
        printMove(fr, to)
    else:
        Towers(n - 1, fr, spare, to)
        Towers(1, fr, to, spare)
        Towers(n - 1, spare, to , fr)
        
#Towers(4, 'P1', 'P2', 'P3')

"""
Exercise: gcd iter
The greatest common divisor of two positive integers is the largest integer
that divides each of them without a remainder. Write an iterative function
`gcdIter(a,b)`, that implements this idea. One easy way to do this is to begin
with a test value equal to the smaller of the two input arguments, and itera-
tively reduce this test value by 1 until you either reach a case where the
test divides both `a` and `b` without remainder, or you reach 1.
"""

def gcdIter(a, b):
    """
    a, b: positive integers
    returns: a positive integer, the greatest common divisor of a & b
    """
    test = min(a, b)
    for gcd in range(test, 1, -1):
        if (a % gcd == 0 and b % gcd == 0):
            return gcd
    return 1

"""
Exercise: gcd recur
A clever mathematical trick (due to Euclid) makes it easy to find greatest
common divisors. Suppose that `a` and `b` are two positive integers:
    - if b=0, then the answer is a
    - otherwise, gcd(a, b) is the same as gcd(b, a%b)
"""

def gcdRecur(a, b):
    """
    a, b: positive integers
    returns: a positive integer, the greatest common divisor of a & b
    """
    if b == 0:
        return a
    else:
        return gcdRecur(b, a%b)
    
"""
Video: Fibonacci
"""

def fib(x):
    if x == 0 or x == 1:
        return 1
    else:
        return fib(x-1) + fib(x - 2)
    
"""
Exercise: is in
We can use the idea of `bisection search` to determine if a character is in
a string, so long as the string is sorted in alphabetical order.

First, test if the middle character of a string you're looking for (the "test
character"). If they are the same, we are done - we've found the character!

If they're not the same, check if the string is "smaller" than the middle char-
acter. If so, we need only consider the lower half of the string; otherwise
we only consider the upper half of the string.
"""

def isIn(char, aStr):
    if aStr == '':
        return False
    elif (aStr[len(aStr) // 2]) == char:
        return True
    elif len(aStr) == 1:
        return False
    elif (aStr[len(aStr) // 2]) > char:
        return isIn(char, aStr[0:(len(aStr)//2)])
    else:
        return isIn(char, aStr[(len(aStr)//2):])
    
