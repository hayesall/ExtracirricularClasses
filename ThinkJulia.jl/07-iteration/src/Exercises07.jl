# Copyright © 2019 Alexander L. Hayes
# Copyright © 2019 Ben Lauwens & Allen B. Downey

module Exercises07

    using PrettyTables
    using ExportPublic

    """
        exercise_7_1_1(a)

    Returns the square root of `a`.

    Task
    ----

    Copy the loop from the "Square Roots" section and encapsulate it in a function called
    `mysqrt` that takes `a` as a parameter, chooses a reasonable value of `x`, and returns
    an estimate of the square root of `a`.
    """
    function exercise_7_2_1(a)
        ε = eps(Float64)
        x = 2
        while true
            y = (x + a/x) / 2
            if abs(x - y) < ε
                break
            end
            x = y
        end
        x
    end

    """
        exercise_7_1_2(array_of_values)

    Prints a `PrettyTable` of input values, the result of calling the `mysqrt`
    implementation, the result of calling Julia's built-in `sqrt` function, and the
    difference between the two.

    Task
    ----

    To test your `mysqrt` implementation, write a function named `testsquareroot` that
    prints a table where the first column is a number `a`, the second column is the square
    root of `a` computed with `mysqrt`; the third column is the square root computed by
    `sqrt`; the fourth is the absolute value of the difference between the two estimates.

    Examples
    --------

    ```julia
    julia> exercise_7_2_2(collect(1.0:4.0))
    ┌─────┬─────────┬─────────┬─────────────┐
    │   a │  mysqrt │    sqrt │        diff │
    ├─────┼─────────┼─────────┼─────────────┤
    │ 1.0 │     1.0 │     1.0 │         0.0 │
    │ 2.0 │ 1.41421 │ 1.41421 │ 2.22045e-16 │
    │ 3.0 │ 1.73205 │ 1.73205 │         0.0 │
    │ 4.0 │     2.0 │       2 │         0.0 │
    └─────┴─────────┴─────────┴─────────────┘
    ```
    """
    function exercise_7_2_2(array_of_values)
        output = []

        for v in array_of_values
            _v_sqrt = sqrt(v)
            _my_sqrt = exercise_7_2_1(v)

            push!(output, v)
            push!(output, _v_sqrt)
            push!(output, _my_sqrt)
            push!(output, abs(_v_sqrt - _my_sqrt))
        end

        pretty_table(
            transpose(reshape(output, 4, :)),
            header=["a", "mysqrt", "sqrt", "diff"]
        )
    end


    """
        exercise_7_3()

    Little REPL thing. Enter "done" to exit.

    Overview
    --------

    The built-in function `Meta.parse` takes a string and transforms it into an expression.
    This expression can be evaluated in Julia with the function `Core.eval`. For example:

    ```julia
    julia> expr = Meta.parse("1+2*3")
    :(1 + 2 * 3)
    julia> eval(expr)
    7
    julia> expr = Meta.parse("sqrt(π)")
    :(sqrt(π))
    julia> eval(expr)
    1.7724538509055159
    ```

    Task
    ----

    Write a function called `evalloop` that iteratively prompts the user, takes the
    resulting input and evalutes it using `eval`, and prints the result. It should continue
    until the user enters `done`, and then return the value of the last expression it
    evaluated.

    Usage
    -----

    ```julia
    julia> exercise_7_3()
       [[ Toy REPL. Type "done" to exit. ]]
    > x = 5
    5
    > y = 10
    10
    > x * y
    50
    > done

    julia>
    ```
    """
    function exercise_7_3()
        println("   [[ Toy REPL. Type \"done\" to exit. ]]")
        while true
            print("> ")
            expression = readline()
            if expression == "done"
                break
            else
                println(eval(Meta.parse(expression)))
            end
        end
    end

    function _lhs()
        (2 * sqrt(2)) / 9801
    end

    function _rhs(k)
        factorial(big(4 * k)) * (1103 + (26390 * k)) / (((factorial(k)) ^ 4) * (396 ^ (4 * k)))
    end

    """
    The mathematician Srinivasa Ramanujan found an infinite series can be used to generate
    a numerical approximation of ``\\frac{1}{\\pi}``.

    ```math
    \\frac{1}{\\pi} = \\frac{2 \\sqrt{2}}{9801} \\sum_{k=0}^{\\infty} \\frac{(4k)! (1103 + 26390k)}{(k!)^{4} 396^{4k}}
    ```

    Task
    ----

    Write a function called `estimatepi` that uses this formula to compute and return an
    estimate of ``\\pi``. It should use a while loop to compute terms of the summation
    until the last term is smaller than `1e-15`. You can check the result by comparing it
    to `π`.

    Notes
    -----

    I ran into a lot of overflow errors while implementing, likely related to the factorial
    terms in `factorial(4 * k)`. I modified the expression to calculate
    `factorial(big(4 * k))` at the suggestion of an error message, but this still seems to
    run into math errors. Doing the summation `while k < 2` seems to provide a good
    approximation without overflowing.

    ```console
    estimated = 3.141592653590491743026...
    Julia-π   = 3.141592653589793
    ```

    It's possible the intended phrasing of the question was:
    `while π - (1 \\ estimate)`, but it feels like cheating to say
    "I used the π to estimate the π."
    """
    function exercise_7_4()
        k = 0
        _sum_term = _rhs(k)

        while k < 2
            k += 1
            _sum_term += _rhs(k)
        end
        1 / (_lhs() * _sum_term)
    end

    @exportPublic
end
