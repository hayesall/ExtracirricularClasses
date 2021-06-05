# Copyright © 2019 Alexander L. Hayes

push!(LOAD_PATH, ".")
using Exercises05
using Test

function TestRunner()

    @testset "Tests for Exercise 5-3" begin
        @test Exercises05.exercise_5_3(1, 1, 1, 3) == "No that does not work."
        @test Exercises05.exercise_5_3(2, 2, 2, 3) == "No that does not work."
        @test Exercises05.exercise_5_3(3, 2, 1, 7) == "No that does not work."
    end

    @testset "Tests for Exercise 5-4" begin
        @test Exercises05.exercise_5_4(1, 1, 12) == "No"
        @test Exercises05.exercise_5_4(3, 3, 10) == "No"
        @test Exercises05.exercise_5_4(1, 1, 1) == "Yes"
        @test Exercises05.exercise_5_4(6, 8, 10) == "Yes"
        @test Exercises05.exercise_5_4(6, 8, 9) == "Yes"
        @test Exercises05.exercise_5_4(6, 8, 8) == "Yes"
    end

    @testset "Tests for Exercise 5-5" begin
        @test Exercises05.exercise_5_5(0, 5) == 5
        @test Exercises05.exercise_5_5(0, 6) == 6
        @test Exercises05.exercise_5_5(1, 6) == 7
        @test Exercises05.exercise_5_5(5, 0) == 15
    end
end

TestRunner()
