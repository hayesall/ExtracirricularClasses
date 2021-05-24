# [Chapter 7: Iteration](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html#chap07)

## Getting Started

```julia
] activate .
```

### Testing

Run unit tests:

```julia
] test Exercises07
```

### Run code coverage:

```julia
julia> using LocalCoverage

julia> using Exercises07

julia> generate_coverage("Exercises07")

julia> open_coverage("Exercises07")
```

### Documentation

```bash
cd docs/
julia make.jl
```
