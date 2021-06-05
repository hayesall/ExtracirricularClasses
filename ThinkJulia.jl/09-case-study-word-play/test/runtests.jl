# Copyright © 2019 Alexander L. Hayes

module Exercise09Tests

    using Test
    using Exercises09

    @testset "Longer than 20" begin
        @test length(exercise_9_1("../words.txt")) == 3
    end

    @testset "No 'e'" begin
        @test exercise_9_2("../words.txt") ≈ 0.3307383423103621 atol=0.000001
    end

    @testset "Avoids" begin
        @test exercise_9_3("../words.txt", "e") ≈ 0.3307383423103621 atol=0.000001
        @test exercise_9_3("../words.txt", "zxquv") ≈ 0.6416627858956673 atol=0.000001
    end

    @testset "UsesOnly" begin
        @test exercise_9_4("../words.txt", "acefhlo") ≈ 0.0016518904480313508 atol=0.000001
    end

    @testset "UsesAll" begin
        @test exercise_9_5("../words.txt", "aeiou") ≈ 0.005254417488950786 atol=0.000001
        @test exercise_9_5("../words.txt", "aeiouy") ≈ 0.0003690393554112592 atol=0.000001
    end

    @testset "isAbecedarian" begin
        @test exercise_9_6("../words.txt") ≈ 0.005236844186312155 atol=0.000001
    end

    @testset "Triple Doubles" begin
        @test is_triple_double("abbccdde")
        @test is_triple_double("abccddeef")
        @test is_triple_double("aabbccdd")
        @test is_triple_double("aabbccefghh")
        @test is_triple_double("aabccddeefghiij")
        @test !is_triple_double("")
        @test !is_triple_double("ab")
        @test !is_triple_double("abc")
        @test !is_triple_double("acccdd")
        @test !is_triple_double("greenness")
        @test !is_triple_double("heelless")
    end

    @testset "Three Triple Doubles" begin
        @test exercise_9_7("../words.txt") == ["bookkeeper", "bookkeepers", "bookkeeping", "bookkeepings"]
    end
end
