# Copyright © 2019 Alexander L. Hayes

push!(LOAD_PATH, ".")
# using ThinkJulia
using Luxor
using Colors
using Exercises04

Drawing(200, 200, "my-drawing.svg")
origin()
background("white")
🐢 = Turtle(0, 0)

Exercises04.polyline(🐢, 10, 5, 1)
finish()
preview()
