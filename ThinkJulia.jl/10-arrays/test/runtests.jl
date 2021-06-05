# Copyright © 2019 Alexander L. Hayes

module Exercise10Tests

    using Test
    using Exercises10

    @testset "Nested Sum" begin
        @test exercise10_1([[1, 2], [3], [4, 5, 6]]) == 21
        @test exercise10_1([[[1, 2], [[[[[3]]]]], [4], 5, 6]]) == 21
        @test exercise10_1([1, 2, 3, 4, 5, 6]) == 21
    end

    @testset "Cumulative Sum" begin
        @test exercise10_2([1, 2, 3]) == [1, 3, 6]
        @test exercise10_2([0, 0, 0]) == [0, 0, 0]
        @test exercise10_2([0, 0, 1]) == [0, 0, 1]
    end

    @testset "Interior" begin
        @test exercise10_3([]) == []
        @test exercise10_3([1]) == []
        @test exercise10_3([1, 2]) == []
        @test exercise10_3([1, 2, 3]) == [2]
        @test exercise10_3([1, 2, 3, 4]) == [2, 3]
    end

    @testset "Interior!" begin
        x = [1, 2, 3]
        exercise10_4!(x)
        @test x == [2]

        y = [1, 2, 3, 4]
        exercise10_4!(y)
        @test y == [2, 3]
    end

    @testset "Is Sorted" begin
        @test exercise10_5([1, 2, 2])
        @test exercise10_5([1, 2, 3])
        @test exercise10_5([1, 3, 5, 7])
        @test exercise10_5([1, 3, 3, 4, 4, 5])
        @test exercise10_5(['a', 'b', 'c', 'd'])
        @test !exercise10_5([2, 1, 2, 3])
        @test !exercise10_5(['b', 'a', 'd'])
    end

    @testset "Anagrams" begin
        @test exercise10_6("newyorktimes", "monkeyswrite")
        @test exercise10_6("evil", "vile")
        @test exercise10_6("racecar", "racecar")
        @test exercise10_6("fortyfive", "overfifty")
        @test exercise10_6("funeral", "realfun")
        @test exercise10_6("restful", "fluster")
        @test exercise10_6("santa", "satan")
        @test exercise10_6("williamshakespeare", "iamaweakishspeller")
    end

    @testset "Has Duplicates" begin
        @test !exercise10_7([1, 2, 3])
        @test exercise10_7([1, 2, 1])
        @test !exercise10_7([1, 3, 5, 7, 6, 4, 2])
        @test exercise10_7([1, 3, 5, 7, 4, 6, 4, 2])
    end

    @testset "Birthday Paradox" begin
        @test exercise10_8() ≈ 0.5 atol=0.02
    end

end
