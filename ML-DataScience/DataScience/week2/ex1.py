from math import sqrt
# First example

'''
def remove_lowercase(infile, outfile):
    output = open(outfile, 'w')
    for line in open(infile):
        if line[0].isupper():
            output.write(line)
    output.close()

input_file = input('What is the input file? ')
output_file = input('What is the output file? ')
remove_lowercase(input_file, output_file)
'''

# Second example

'''
class Foo():
    """A function that will be useful."""
    def __init__(self):
        self.__helper()
    def __helper(self):
        print('sneaky')

x = Foo()
x._Foo__helper()
print(Foo.__doc__) # emacs highlighting is a little odd
#x.__helper() --> results in an AttributeError
'''

# Third example

'''
class MovieTicket():
    basePrice = 10
    def __init__(self, fee, movie):
        self.price = self.basePrice + fee
        self.movie = movie

x = MovieTicket(5, "Shawshank Redemption")
y = MovieTicket(10, "Avengers")
print(x.price)
print(y.price)
print(x.movie)
print(y.movie)
'''

# Fourth example

class Point():
    """This class defines a point in 2D space."""
    def __init__(self, x, y):
        self.x = x
        self.y = y
        
    @staticmethod
    def distance(p1, p2):
        d = sqrt((p1.x - p2.x)**2 + (p1.y - p2.y)**2)
        return d

    @classmethod
    def help(cls):
        for attr in cls.__dict__:
            print(str(attr) + ': ' + cls.__dict__[attr].__doc__)

x = Point(0, 0)
y = Point(0, 5)
print(Point.distance(x, y))
x.help()
