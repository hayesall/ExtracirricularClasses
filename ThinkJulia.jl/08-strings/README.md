# [Chapter 8: Strings](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html#chap08)

## Getting Started

```julia
] activate .
```

### Testing

Run unit tests:

```julia
] test Exercises08
```

### Run code coverage

```julia
julia> using LocalCoverage

julia> using Exercises08

julia> generate_coverage("Exercises08")

julia> open_coverage("Exercises08")
```

### Documentation

```bash
cd docs/
julia --project=".." make.jl
xdg-open build/index.html
```
