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
