# Copyright © 2019 Alexander L. Hayes

push!(LOAD_PATH, ".")
using Exercises05

f() = println("Hello")
Exercises05.exercise_5_1(f, 2)

println(Exercises05.exercise_5_2())

println(Exercises05.exercise_5_3(1, 1, 1, 3))

println(Exercises05.exercise_5_4(1, 1, 1))

println(Exercises05.exercise_5_5(0, 5))
