# Chapter 3 Exercises

Solutions to Chapter 3 Exercises should be implemented in `src/Exercises.jl`
of this folder. The `src/main.jl` script can be used to run each of these
in sequence.

## Exercise 3-2:

Write a function named `rightjustify` that takes a string named `s` as a
parameter and returns the string with enough leading spaces so that the last
letter of the string is in column 70 of the display:

```julia
julia> justifyright("monty")
```

*Hint*: Use string concatenation and repitition. Also, Julia provides a
built-in function called length that returns the length of a string, so
the value of `length("monty")` is `5`.

```@docs
justifyright(s)
```

## Exercise 3-3:

A function object is a value you can assign to a variable or pass as an
argument. For example, `dotwice` is a function that takes a function object
as an argument and calls it twice:

```julia
function dotwice(f)
    f()
    f()
end
```

Here's an example that uses `dotwice` to call a function named `printspam`
twice:

```julia
function printspam()
    println("spam")
end

dotwice(printspam)
```

1. Type this example into a script and test it.
2. Modify `dotwice` so that it takes two arguments, a function and a value,
   and calls the function twice, passing the value as an argument.
3. Copy the definition of `printtwice` from earlier in this chapter to your
   script.
4. Use the modified version of `dotwice` to call `printtwice` twice, passing
   "spam" as an argument.
5. Define a new function called `dofour` that takes a function object and a
   value and calls the function four times, passing the value as a parameter.
   There should be only two statements in the body of this function, not four.

```@docs
dotwice(f, value)
```

```@docs
dofour(f, value)
```

## Exercise 3-4

Write a function `printgrid` that draws a grid like the following:

```julia
julia> printgrid()
+ - - - - + - - - - +
|         |         |
|         |         |
|         |         |
|         |         |
+ - - - - + - - - - +
|         |         |
|         |         |
|         |         |
|         |         |
+ - - - - + - - - - +
```

Adapt your `printgrid` function to take a number-of-rows and
number-of-columns as input. Call it `returngrid`, and make it return the
string instead of printing it.

```julia
julia> print(returngrid(2, 2))
+ - - - - + - - - - +
|         |         |
|         |         |
|         |         |
|         |         |
+ - - - - + - - - - +
|         |         |
|         |         |
|         |         |
|         |         |
+ - - - - + - - - - +
```

```@docs
returngrid(number_rows, number_cols)
```

## Bonus Question:

Write a function `justifygridright` that uses `returngrid` and `justifyright`.

```@docs
justifygridright(number_rows, number_cols)
```

### Alternative Solution with Function Composition

How would you modify the implementation of `justifyright` to handle inputs
with multiple lines?

```julia
julia> print(rightjustify(returngrid(2, 2)))
```

*Hint*: The built-in `split` function may help here:
`split("hello\nthere", "\n")`
