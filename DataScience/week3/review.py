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
    '''Map:'''

    # Transform function: "let's write a method called 'transform' that takes a list
    # and a function as parameters and applies the function to each element of the list.
    
    x = [1, 2, 3]
    def mult_2(x):
        return x * 2
    
    def transform(arr, func):
        for i in range(len(arr)):
            arr[i] = func(arr[i])

    transform(x, mult_2)
    #print(map(mult_2, [1, 2, 3]))
    print(x)

class HigherOrderDemo:
    '''Defining functions within functions.'''
    
    # def within def
    
    def greet(name):
        def get_message():
            return "Hello "
        
        result = get_message() + name
        return result

    print(greet("John"))

    # Functions can be passed as parameters to other functions

    def greet(name):
        return "Hello " + name
    def call_func(func):
        other_name = "John"
        return func(other_name)
    print(call_func(greet))

    # Functions can return other functions:

    def compose_greet_func():
        def get_message():
            return "Hello there!"
        return get_message

    greet = compose_greet_func()
    print(greet())

