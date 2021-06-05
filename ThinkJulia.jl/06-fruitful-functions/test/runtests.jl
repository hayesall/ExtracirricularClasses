# Copyright © 2019 Alexander L. Hayes

module Exercises06Test

    using Test
    using Exercises06

    @testset "Radius Tests" begin
        @test area(1) ≈ π atol=0.0001
        @test area(2) ≈ 12.566370614359172 atol=0.0001
    end

    @testset "Circle Area" begin
        @test circlearea(0, 0, 0, 1) ≈ π atol=0.0001
        @test circlearea(0, 0, 1, 0) ≈ π atol=0.0001
        @test circlearea(0, 1, 0, 0) ≈ π atol=0.0001
        @test circlearea(1, 0, 0, 0) ≈ π atol=0.0001
        @test circlearea(10, 5, 3, 7) ≈ 166.50441 atol=0.0001
    end

    @testset "Factorial Tests" begin
        @test fact(1) == 1
        @test fact(2) == 2
        @test fact(3) == 6
        @test fact(4) == 24
        @test fact(5) == 120
        @test_throws MethodError fact(2.5)
        @test_throws MethodError fact("Hello")
        @test_throws DomainError fact(-1)
        @test_throws DomainError fact(-10)
    end

    @testset "Fibonacci Tests" begin
        @test fib(0) == 0
        @test fib(1) == 1
        @test fib(2) == 1
        @test fib(3) == 2
        @test fib(4) == 3
        @test fib(5) == 5
    end

    @testset "Distances" begin
        @test distance(0, 0, 0, 5) == 5
        @test distance(0, 0, 6, 0) == 6
        @test distance(0, 0, 1, 1) ≈ 1.414 atol=0.01
    end

    @testset "Exercise 6.1 - Compare" begin
        @test exercise_6_1(0, 0) == 0
        @test exercise_6_1(2, 1) == 1
        @test exercise_6_1(1, 2) == -1
    end

    @testset "Exercise 6.2 - Hypotenuse" begin
        @test exercise_6_2(1, 1) ≈ 1.414 atol=0.01
        @test exercise_6_2(3, 4) == 5
    end

    @testset "Exercise 6.3 - isbetween" begin
        @test exercise_6_3(1, 2, 3)
        @test exercise_6_3(1, 1, 1)
        @test exercise_6_3(1, 2, 2)
        @test exercise_6_3(1, 1, 2)
        @test exercise_6_3(1, 5, 1) == false
    end

    @testset "Exercise 6.5 - Ackermann" begin
        @test exercise_6_5(3, 4) == 125
        @test exercise_6_5(1, 0) == 2
        @test exercise_6_5(2, 0) == 3
        @test exercise_6_5(3, 0) == 5
        @test exercise_6_5(4, 0) == 13
    end

    @testset "Exercise 6.6 - Palindromes" begin
        @test exercise_6_6("anna")
        @test exercise_6_6("racecar")
        @test exercise_6_6("redivider")
        @test exercise_6_6("noon")
        @test exercise_6_6("a")
        @test exercise_6_6("")
        @test exercise_6_6("sixteen") == false
    end

    @testset "Exercise 6.7 - Powers" begin
        @test exercise_6_7(1, 1)
        @test exercise_6_7(25, 5)
        @test exercise_6_7(152587890625, 5)
        @test exercise_6_7(152587890626, 5) == false
        @test exercise_6_7(5, 1) == false
    end

    @testset "Exercise 6.8 - GCD" begin
        @test exercise_6_8(5, 5) == 5
        @test exercise_6_8(120, 5) == 5
        @test exercise_6_8(120, 75) == 15
        @test exercise_6_8(3, 3919) == 1
        @test exercise_6_8(2000, 4000) == 2000
    end
end
