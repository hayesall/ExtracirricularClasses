'''
A brief discussion on Python Lambda and higher-order functions.
'''

class LambdaDemo:
    '''Three examples of using lambda to define functions.'''
    
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
    print(my_func(5))

class MapDemo:
    '''
    Transform function: let's write a method called 'transform' that takes a
    list a function as parameters and applies the function to each list item.
    '''
    
    x = [1, 2, 3]
    def mult_2(x):
        return x * 2
    
    def transform(arr, func):
        for i in range(len(arr)):
            arr[i] = func(arr[i])

    transform(x, mult_2) # Notice that this is a backwards version of map.
    print(x)

class HigherOrderDemo:
    '''Defining functions within functions.'''
    
    # Define functions inside functions.
    def greet(name):
        def get_message():
            return "Hello "
        
        result = get_message() + name
        return result

    print(greet("John"))

    '''Functions can be passed as parameters to other functions.'''
    def greet(name):
        return "Hello " + name
    def call_func(func):
        other_name = "John"
        return func(other_name)
    print(call_func(greet))

    '''Functions can return other functions:'''
    def compose_greet_func():
        def get_message():
            return "Hello there!"
        return get_message

    greet = compose_greet_func()
    print(greet())

    '''Assign functions to variables:'''
    def greet(name):
        return "hello " + name
    greet_someone = greet
    print(greet_someone("JOHN!"))

    '''Inner functions have access to the enclosing scope.'''
    def compose_greet_func(name):
        def get_message():
            return "Hello there "+name+"!"
        return get_message

    greet = compose_greet_func('Jack')
    print(greet())

class DecoratorDemo:
    '''Composition of decorators.'''

    '''This is a cool way to create wrapper functions.'''
    def p_decorate(func):
        def func_wrapper(name):
            return "<p>{0}</p>".format(func(name))
        return func_wrapper

    @p_decorate
    def get_text(name):
        return "lorem ipsum, {0} dolor sit amet".format(name)

    print(get_text("John"))
    get_text = p_decorate(get_text)


# A global definition for p_decorate, showing that it can be used within
# the following 'Person' class.
def p_decorate(func):
    def func_wrapper(self):
        return "<p>{0}</p>".format(func(self))
    return func_wrapper
    
class Person(object):
    '''
    In Python, methods are functions that expect their first parameter to be a
    reference to the current object
    '''
    def __init__(self):
        self.name = "John"
        self.family = "Doe"
    
    @p_decorate
    def get_fullname(self):
        return self.name + ' ' + self.family

my_person = Person()
print(my_person.get_fullname())

'''
Exercise 1:

We have a class defined for vehicles. Create two new vehicles (car1 and car2).
Set car1 to be a red convertible worth $60,000.00 with a name of Fer, and car2
to be a blue van named Jump worth $10,000.00
'''

# Define the vehicle class
class Vehicle:

    def __init__(self, name, kind, color, value):
        self.name = name
        self.kind = kind
        self.color = color
        self.value = value
    
    def description(self):
        desc_str = "%s is a %s %s worth $%.2f." % \
                   (self.name, self.color, self.kind, self.value)
        return desc_str

car1 = Vehicle("Fer", "red", "Convertible", 60000.00)
car2 = Vehicle("Jump", "blue", "Van", 10000.00)

print(car1.description())
print(car2.description())

# Exercise 2:
class A(object):
    def foo(self, x):
        print("Executing foo(%s,%s)", (self, x))
    @classmethod
    def class_foo(cls, x):
        print("Executing class_foo(%s,%s)", (cls, x))
    @staticmethod
    def static_foo(x):
        print("Executing static_foo(%s)", x)

a = A()
a.foo(1)
a.class_foo(1)
A.class_foo(1)
a.static_foo(1)
A.static_foo(1)
