'''
MITx 6.00.1x
Introduction to Computer Science and Programming Using Python

Week 1: Python Basics
Problem Set 1
'''

# Problem 1: Count the number of vowels in a string:

s = 'azcbobobegghakl'
vowels = 0
for letter in s:
    if letter in 'aeiou':
        vowels = vowels + 1
        
print('Number of vowels: ' + str(vowels))

# Problem 2: Our obsessive friend bob

out = 0
for i in range(len(s)):
    if (s[i:i+3]) == 'bob':
        out = out + 1

print('Number of times bob occurs is:', out)

# Problem 3: longest alphabetical string

s = 'azcbobbobegghakl'

longest = ''
s = s + '1'

for letter in range(len(s[:-1])):
    x = letter
    substring = s[x]
    while s[x] <= s[x+1]:
        x = x + 1
        substring = substring + s[x]
    if len(substring) > len(longest):
        longest = substring

print('Longest substring in alphabetical order is:', longest)
