# Copyright © 2019 Alexander L. Hayes

using Pkg

dependencies = [
    "Documenter",
    "Luxor",
    "Colors",
]

Pkg.add(dependencies)
Pkg.add(url="https://github.com/BenLauwens/ThinkJulia.jl")
