# [Chapter 11: Dictionaries](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html#chap11)

## Getting Started

```julia
] activate .
```

### Testing

Run unit tests:

```julia
] test Exercises11
```

### Run code coverage

```julia
julia> using LocalCoverage

julia> using Exercises11

julia> generate_coverage("Exercises11")

julia> open_coverage("Exercises11")
```

### Documentation

```bash
cd docs/
julia --project=.. make.jl
xdg-open build/index.html
```
