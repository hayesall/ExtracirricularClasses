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
