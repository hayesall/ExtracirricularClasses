# Chapter 5 Exercises

Solutions to Chapter 3 Exercises should be implemented in `src/Exercises05.jl`
of this folder. The `src/main.jl` script can be used to run each of these
in sequence.

## Solutions

### Exercise 5-1

I'm not going to draw the diagram, but here is the solution:

```@docs
exercise_5_1
```

It might be a good exercise to think through whether the type signature
on this can be made better. `exercise_5_1(f::Function, n::Int)` seemed
like the obvious choice, but I'm curious if it could be specialized
to something like `exercise_5_1(f::Function{String}, n::Int)`.

### Exercise 5-2

```@docs
exercise_5_2
```

### Exercise 5-3

```@docs
exercise_5_3
```

### Exercise 5-4

```@docs
exercise_5_4
```

### Exercise 5-5

What is the output of the following program?

```julia
function recurse(n, s)
    if n == 0
        println(s)
    else
        recurse(n-1, n+s)
    end
end
recurse(3, 0)
```

1. What would happen if you called this function with: `recurse(-1, 0)`
2. Write a docstring that explains everything someone would need to know
   in order to use this function (and nothing else).

```@docs
exercise_5_5
```
