# Copyright © 2019 Alexander L. Hayes
# Copyright © 2019 Ben Lauwens & Allen B. Downey

module Exercises05

    export exercise_5_1
    export exercise_5_2
    export exercise_5_3
    export exercise_5_4
    export exercise_5_5

    """
    Parameters
    ----------
    - f (Function): Function object
    - n (Int): Number of times to call the function

    Draw a stack diagram for `println` called with `s = "Hello"` and
    `n = 2`. Then write a function called `do_n` that takes a function
    object and a number `n` as arguments, and that calls that function
    ``n`` times.

    Examples
    --------

    ```julia
    f() = println("Hello")
    exercise_5_1(f, 2)
    ```
    """
    function exercise_5_1(f::Function, n::Int)::Nothing
        for i in 1:n
            f()
        end
    end

    """
    The function `time` returns the current Greenwich Mean Time in seconds since
    "the epoch", which is an arbitrary time used as a reference point. On
    UNIX systems, the epoch is 1 January 1970.

    Write a script that reads the current time and converts it to a time of
    day in hours, minutes, and seconds, plus the number of days since the
    epoch.
    """
    function exercise_5_2()
        return time()
    end

    """
    Fermat's Last Theorem states that there are no positive integers
    ``a``, ``b``, and ``c`` such that

    ```math
    a^{n} + b^{n} = c^{n}
    ```

    for any value of ``n`` greater than 2.

    1. Write a function named `checkfermat` that takes four parameters
       `a`, `b`, `c`, and `n`; and checks to see if Fermat's theorem holds.
       If `n` is greater than 2 and ``a^{n} + b^{n} = c^{n}`` the program
       should print, "Holy smokes, Fermat was wrong!" Otherwise the program
       should print, "No that does not work."
    2. Write a function that prompts the user to input values for `a`, `b`,
       `c`, and `n`, converts them to integers, and uses `checkfermat` to
       check whether they violate Fermat's theorem.
    """
    function exercise_5_3(a::Int, b::Int, c::Int, n::Int)
        @assert n > 2

        if (a^n) + (b^n) == c^(n)
            return "Holy smokes, Fermat was wrong!"
        else
            return "No that does not work."
        end
    end

    """
    If you are given three sticks, you may or may not be able to arrange them
    in a triangle. For example, if one of the sticks is 12 inches long and
    the other two are one inch long, you will not be able to get the short
    sticks to meet in the middle. For any three lengths, there is a simple
    test to see if it is possible to form a triangle:

    > If any of the three lengths is greater than the sum of the other two,
    > then you cannot form a triangle. Otherwise, you can. (If the sum of two
    > lengths equals the third, they form what is called a "degenerate"
    > triangle.)

    1. Write a function named `istriangle` that takes three integers as
       arguments, and that prints either "Yes" or "No", depending on whether
       you can or cannot form a triangle from sticks with the given lengths.
    2. Write a function that prompts the user to input three stick lengths,
       converts them to integers, and uses `istriangle` to check whether sticks
       with the given lengths can form a triangle.
    """
    function exercise_5_4(a::Int, b::Int, c::Int)
        if (a + b ≤ c) || (a + c ≤ b) || (b + c ≤ a)
            return "No"
        else
            return "Yes"
        end
    end

    """
    Parameters
    ----------
    - n (Int): Number of times
    - s (Int): Initial value of return

    If `n < 0`, an `AssertionError` is raised.
    """
    function exercise_5_5(n::Int, s::Int)
        @assert n ≥ 0

        if n == 0
            s
        else
            exercise_5_5(n-1, n+s)
        end
    end
end
