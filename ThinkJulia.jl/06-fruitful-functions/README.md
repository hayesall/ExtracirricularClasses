# [Chapter 6: Fruitful Functions](https://benlauwens.github.io/ThinkJulia.jl/latest/book.html#chap06)

## Getting Started

I'm getting more comfortable with my workflow.

```julia
] develop .
```

### Testing

Run unit tests:

```julia
] test Exercises06
```

### Run code coverage:

```julia
julia> using LocalCoverage

julia> using Exercises06

julia> generate_coverage("Exercises06")

julia> open_coverage("Exercises06")
```

### Documentation

```bash
cd docs/
julia make.jl
```
