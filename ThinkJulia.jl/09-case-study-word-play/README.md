# [Chapter 9: Case Study - Word Play](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html#chap09)

## Getting Started

```julia
] activate .
```

### Testing

Run unit tests:

```julia
] test Exercises09
```

### Run code coverage

```julia
julia> using LocalCoverage

julia> using Exercises09

julia> generate_coverage("Exercises09")

julia> open_coverage("Exercises09")
```

### Documentation

```bash
cd docs/
julia --project=".." make.jl
xdg-open build/index.html
```
