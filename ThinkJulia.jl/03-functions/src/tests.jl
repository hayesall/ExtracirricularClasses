# Copyright © 2019 Alexander L. Hayes

push!(LOAD_PATH, ".")
using Exercises
using Test

function TestRunner()

    @testset "Tests for Chapter 3" begin
        @testset "Exercise 3-2" begin
            @test Exercises.justifyright("hello") == "                                                                 hello"
            @test Exercises.justifyright("world") == "                                                                 world"
            @test Exercises.justifyright("this is a longer string") == "                                               this is a longer string"
            @test Exercises.justifyright("") == "                                                                      "
        end

        @testset "Exercise 3-3" begin
            @testset "printtwice tests" begin
                @test Exercises.printtwice("something") == nothing
                @test Exercises.printtwice("else") == nothing
                @test Exercises.printtwice("is here") == nothing
                @test Exercises.printtwice("spam") == nothing
            end
            @testset "dotwice tests" begin
                @test Exercises.dotwice(Exercises.printtwice, "spam") == nothing
                @test Exercises.dotwice(Exercises.printtwice, "ham") == nothing
            end
            @testset "dofour tests" begin
                @test Exercises.dofour(Exercises.printtwice, "spam") == nothing
            end
        end

        @testset "Exercise 3-4" begin
            @test Exercises.returngrid(2, 2) == read("test_files/2x2.txt", String)
            @test Exercises.returngrid(10, 11) == read("test_files/10x11.txt", String)
            @test Exercises.returngrid(4, 4) == read("test_files/4x4.txt", String)
        end

        @testset "Bonus Exercise" begin
            @test Exercises.justifygridright(4, 4) == read("test_files/4x4-right.txt", String)
            @test Exercises.justifygridright(1, 6) == read("test_files/1x6-right.txt", String)
            @test Exercises.justifygridright(10, 6) == read("test_files/10x6-right.txt", String)
        end
    end
end

TestRunner()
