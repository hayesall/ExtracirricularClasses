'''
MITx 6.00.1x
Introduction to Computer Science and Programming Using Python

Week 2: 
Computer Programming Exercise: polysum

A regular polygon has n number of sides. Each side has length s.

Write a function called polysum that takes two arguments, n and s. This function
should sum the area and square the perimeter of the regular polygon. The function
returns sum, rounded to 4 decimal places.
'''

from math import tan
from math import pi

def polysum(n, s):
    area = (0.25 * n * s**2)/(tan(pi/n))
    perimeter = n * s
    return round(area + (perimeter**2), 4)

print(polysum(5, 10))
