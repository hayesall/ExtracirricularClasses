# Copyright © 2019 Alexander L. Hayes
# Copyright © 2019 Ben Lauwens & Allen B. Downey

module Exercises06

    using ExportPublic

    """
        area(radius)

    Area of a circle

    ```math
    A = \\pi \\cdot radius^{2}
    ```
    """
    function area(radius)
        π * radius^2
    end

    """
        distance(x₁, y₁, x₂, y₂)

    2-D Euclidean Distance

    Parameters
    ----------
    - `x₁::Int`:
    - `y₁::Int`:
    - `x₂::Int`:
    - `y₂::Int`:

    Computes the Euclidean Distance in two dimensions:

    ```math
    d = \\sqrt{(x_{2} - x_{1})^{2} + (y_{2} - y_{1})^{2}}
    ```
    """
    function distance(x₁, y₁, x₂, y₂)
        dx = x₂ - x₁
        dy = y₂ - y₁
        d² = dx^2 + dy^2
        sqrt(d²)
    end

    """
        circlearea(xc, yc, xp, yp)

    `circlearea` computes the area of a circle given two points on the radius
    (the *center* and the other *position*).

    Parameters
    ----------
    - `xc::Int`:
    - `yc::Int`:
    - `xp::Int`:
    - `yp::Int`:
    """
    function circlearea(xc, yc, xp, yp)
        area(distance(xc, yc, xp, yp))
    end

    function _fact_safe(n)
        # "Dangerous" Factorial Function.
        # `fact(n)` calls this if the arguments are valid.
        if n == 0
            1
        else
            n * _fact_safe(n - 1)
        end
    end

    """
        fact(n::Int64)

    Compute `n!`
    """
    function fact(n::Int64)
        if n < 0
            throw(DomainError("Factorial is not defined for negative integers"))
        else
            _fact_safe(n)
        end
    end

    """
        fib(n::Int64)

    Calculate the n-th fibonacci number.
    """
    function fib(n::Int64)
        if n == 0 || n == 1
            n
        else
            fib(n - 1) + fib(n - 2)
        end
    end

    """
        exercise_6_1(x, y)

    Task
    ----

    Write a `compare` function that takes two values `x` and `y`, and returns
    `1` if `x > y`, `0` if `x == y`, and `-1` if `x < y`.
    """
    function exercise_6_1(x, y)
        if x > y
            1
        elseif x < y
            -1
        else
            0
        end
    end

    """
        exercise_6_2(o, a)

    Parameters
    ----------
    - `o`: Length of the "other" side
    - `a`: Length of the "adjacent" side

    Task
    ----

    Use incremental development to a function called `hypotenuse` that returns
    the length of the hypotenuse of a right triangle given the lengths of the
    two other legs as arguments. Record each stage of the development.
    """
    function exercise_6_2(o, a)
        distance(0, o, a, 0)
    end

    """
        exercise_6_3(x, y, z)

    Task
    ----

    Write a function `isbetween(x, y, z)` that returns `true` if `x ≤ y ≤ z`
    or `false` otherwise.
    """
    function exercise_6_3(x, y, z)
        x ≤ y ≤ z
    end

    """
        exercise_6_5(m::Int64, n::Int64)

    Task
    ----

    The Ackermann function, ``A(m,n)``, is defined:

    ```math
    A(m, n) = \\begin{cases}
    n + 1 & \\text{if } m = 0 \\cr
    A(m - 1, 1) & \\text{if } m > 0~\\text{and } n = 0 \\cr
    A(m - 1, A(m, n - 1)) & \\text{if } m > 0~\\text{and } n > 0
    \\end{cases}
    ```

    See [Wikipedia: Ackermann Function](https://en.wikipedia.org/wiki/Ackermann_function).
    Write a function named `ack` that evaluates the Ackermann function. Use your
    to evaluate `ack(3, 4)`, which should be 125.
    """
    function exercise_6_5(m::Int64, n::Int64)
        if m == 0
            n + 1
        elseif m > 0 && n == 0
            exercise_6_5(m - 1, 1)
        else
            exercise_6_5(m - 1, exercise_6_5(m, n - 1))
        end
    end

    function _first(word)
        word[firstindex(word)]
    end

    function _last(word)
        word[lastindex(word)]
    end

    function _middle(word)
        word[nextind(word, firstindex(word)) : prevind(word, lastindex(word))]
    end

    """
        exercise_6_6(word)

    Task
    ----

    A palindrome is a word that is spelled the same backward and forward, like "noon"
    and "redivider". Recursively, a word is a palindrome if the first and last letters
    are the same and the middle is a palindrome.

    ```julia
    _first(word)
    _last(word)
    _middle(word)
    ```

    The following are functions that take a string argument and return the first, last
    and middle letters.

    1. Test these functions out. What happens if you call middle with a string with two
       letters? One letter? What about the empty string, which is written `""` and
       contains no letters?
    2. Write a function called `ispalindrome` that takes a string argument and returns
       `true` if it is a palindrome and `false` otherwise. Remember that you can use
        the built-in function `length` to check the length of a string.
    """
    function exercise_6_6(word)
        if length(word) == 0 || length(word) == 1
            true
        elseif _first(word) == _last(word)
            exercise_6_6(_middle(word))
        else
            false
        end
    end

    """
        exercise_6_7(a::Int64, b::Int64)

    Task
    ----

    A number, ``a``, is a power of ``b`` if it is divisible by ``b`` and
    ``\\frac{a}{b}`` is a power of ``b``. Write a function called `ispower`
    that takes parameters `a` and `b` and returns `true` if `a` is a power of `b`.
    """
    function exercise_6_7(a::Int64, b::Int64)

        left = a % b
        right = a ÷ b

        if a == 1
            b == 1
        elseif b == 1
            false
        elseif a == b
            true
        else
            left == 0 && exercise_6_7(right, b)
        end
    end

    """
        exercise_6_8()

    The greatest common divisor (GCD) of ``a`` and ``b`` is the largest number that
    divides both of them with no remainder.

    One way to find the GCD of two numbers is based on the observation that if ``r``
    is the remainder when ``a`` is divided by ``b``, then `gcd(a, b) = gcd(b, r)`.
    As a base case, we can use `gcd(a, 0) = a`.

    Task
    ----

    Write a function that takes parameters `a` and `b` and returns their greatest
    common divisor.
    """
    function exercise_6_8(a, b)
        if b == 0
            a
        else
            exercise_6_8(b, a % b)
        end
    end

    @exportPublic
end
