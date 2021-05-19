# Chapter 4 Exercises

Solutions to Chapter 4 Exercises should be implemented in `src/Exercises04.jl`
of this folder. The `src/main.jl` script can be used to demo individual cases.

## Exercises

```@docs
exercise_4_1
```

```@docs
exercise_4_2
```

```@docs
exercise_4_3
```

```@docs
exercise_4_4
```

```@docs
exercise_4_5
```

```@docs
exercise_4_6
```

```@docs
exercise_4_7
```

## Provided Functions

These two functions were provided following the first seven exercises.

```@docs
polyline
```

```@docs
arc
```

## Examples

### `polygon(t, n, len)`

The `polygon` (`exercise_4_5`) method lets us draw polygons with ``n``-sided
polygons.

This means we can draw pentagons:

```@example
using Luxor # hide
using Colors # hide
push!(LOAD_PATH, "../../src/") # hide
using Exercises04 # hide
Drawing(250, 250, "polygon5.svg") # hide
origin() # hide
background("white") # hide
🐢 = Turtle()
Exercises04.exercise_4_5(🐢, 5, 25)
finish() # hide
nothing # hide
```

![](polygon5.svg)

... or dodecagons by changing a single number:

```@example
using Luxor # hide
using Colors # hide
push!(LOAD_PATH, "../../src/") # hide
using Exercises04 # hide
Drawing(250, 250, "polygon12.svg") # hide
origin() # hide
background("white") # hide
🐢 = Turtle()
Exercises04.exercise_4_5(🐢, 12, 25)
finish() # hide
nothing # hide
```

![](polygon12.svg)

### `arc(t, r, angle)`

The `arc` (`exercise_4_7`) method lets us draw portions of a circle.

```@example
using Luxor # hide
using Colors # hide
push!(LOAD_PATH, "../../src/") # hide
using Exercises04 # hide
Drawing(250, 250, "arc1.svg") # hide
origin() # hide
background("white") # hide
🐢 = Turtle()
Exercises04.exercise_4_7(🐢, 50, 250)
finish() # hide
nothing # hide
```

![](arc1.svg)

```@example
using Luxor # hide
using Colors # hide
push!(LOAD_PATH, "../../src/") # hide
using Exercises04 # hide
Drawing(250, 250, "arc2.svg") # hide
origin() # hide
background("white") # hide
🐢 = Turtle()
Exercises04.exercise_4_7(🐢, 30, 90)
finish() # hide
nothing # hide
```

![](arc2.svg)
