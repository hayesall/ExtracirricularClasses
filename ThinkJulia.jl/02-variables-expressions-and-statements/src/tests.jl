# Copyright © 2019 Alexander L. Hayes

push!(LOAD_PATH,".")
using Exercises
using Test

function TestRunner()

    @testset "Tests for Chapter 2" begin
        @testset "Exercise 2-1" begin
            @test Exercises.exercise_2_1() == nothing
        end;

        @testset "Exercise 2-3-1" begin
            @test Exercises.exercise_2_3_1(5) ≈ 523.598 atol=0.01
            @test Exercises.exercise_2_3_1(1) ≈ 4.18878 atol=0.01
            @test Exercises.exercise_2_3_1(2) ≈ 33.5102 atol=0.01
            @test Exercises.exercise_2_3_1(10) ≈ 4188.79 atol=0.01
        end;

        @testset "Exercise 2-3-2" begin
            @test Exercises.exercise_2_3_2(1) == 6.98
            @test Exercises.exercise_2_3_2(60) == 551.55
            @test Exercises.exercise_2_3_2(100) == 920.75
            @test_throws AssertionError Exercises.exercise_2_3_2(0)
            @test_throws AssertionError Exercises.exercise_2_3_2(-10)
            @test_throws AssertionError Exercises.exercise_2_3_2(-60)
            @test_throws MethodError Exercises.exercise_2_3_2("5")
        end;

        @testset "Exercise 2-3-3" begin
            @test Exercises.exercise_2_3_3() == "7:30"
        end;
    end;

end

TestRunner()
