# [Chapter 10: Arrays](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html#chap10)

## Getting Started

```julia
] activate .
```

### Testing

Run unit tests:

```julia
] test Exercises10
```

### Run code coverage

```julia
julia> using LocalCoverage

julia> using Exercises10

julia> generate_coverage("Exercises10")

julia> open_coverage("Exercises10")
```

### Documentation

```bash
cd docs/
julia --project=".." make.jl
xdg-open build/index.html
```

## Exercises

```@docs
exercise10_1
exercise10_2
exercise10_3
exercise10_4!
exercise10_5
exercise10_6
exercise10_7
exercise10_8
exercise10_9
exercise10_10
```
