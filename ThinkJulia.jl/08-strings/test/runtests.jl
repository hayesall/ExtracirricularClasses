# Copyright © 2019 Alexander L. Hayes

module Exercise07Tests

    using Test
    using Exercises08

    @testset "Reversed newlines" begin
        @test exercise_8_1("ab") == "b\na\n"
        @test exercise_8_1("abc") == "c\nb\na\n"
    end

    @testset "Ducks" begin
        @test exercise_8_2() == "Jack\nKack\nLack\nMack\nNack\nOuack\nPack\nQuack\n"
    end

    @testset "Find Characters" begin
        @test exercise_8_4("Hello", 'e', 1) == 2
        @test exercise_8_4("Hello", 'e', 2) == 2
        @test exercise_8_4("Hello", 'e', 3) == -1
        @test exercise_8_4("Hello", 'q', 1) == -1
    end

    @testset "Counter" begin
        @test exercise_8_5("hello", 'l') == 2
        @test exercise_8_5("a", 'a') == 1
        @test exercise_8_5("aa", 'a') == 2
        @test exercise_8_5("hello", 'q') == 0
        @test exercise_8_5("aaaaa", 'b') == 0
        @test exercise_8_5("twitter", 't') == 3
    end

    @testset "Reverse" begin
        @test !exercise_8_6("too-long", "even-longer")
        @test !exercise_8_6("hello", "world")
        @test exercise_8_6("stop", "pots")
        @test exercise_8_6("asdfe", "efdsa")
        @test exercise_8_6("racecar", "racecar")
    end

    @testset "Built-in Counter" begin

        # Exercise 8-8 suggests to use the built-in `count` function to do something
        #   similar to what we implemented for Exercise 8-5.

        @test count("l", "hello") == 2
        @test count("a", "a") == 1
        @test count("a", "aa") == 2
        @test count("q", "hello") == 0
        @test count("b", "aaaaa") == 0
        @test count("t", "twitter") == 3
        @test count("ll", "hello") == 1

        @test count(i->(i == 'l'), "hello") == 2
        @test count(i->(i == 'a'), "a") == 1
        @test count(i->(i == 'a'), "aa") == 2
    end

    @testset "One-line Palindrome" begin
        @test exercise_8_9("racecar")
        @test exercise_8_9("abba")
        @test exercise_8_9("anna")
    end

    @testset "Caesar Cipher" begin
        @test exercise_8_11("A", 3) == "D"
        @test exercise_8_11("Z", 1) == "A"
        @test exercise_8_11("cheer", 7) == "jolly"
        @test exercise_8_11("melon", -10) == "cubed"
        @test exercise_8_11("IBM", -1) == "HAL"
        @test exercise_8_11("Jul qvq gur puvpxra pebff gur ebnq?", 13) == "Why did the chicken cross the road?"
        @test exercise_8_11("Gb trg gb gur bgure fvqr!", 13) == "To get to the other side!"
    end
end
