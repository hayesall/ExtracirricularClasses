# Copyright © 2019 Alexander L. Hayes

module Exercises11Tests

    using Exercises11
    using Test

    @testset "Shorter Histogram" begin
        @test exercise11_1("tweet") == Dict('e'=>2, 't'=>2, 'w'=>1)
        @test exercise11_1("abc") == Dict('a'=>1, 'b'=>1, 'c'=>1)
        @test exercise11_1("aaa") == Dict('a'=>3)
    end

    @testset "Shorter invertdict" begin
        @test exercise11_3(Dict('o'=>1, 'a'=>1, 'r'=>2)) == Dict(2=>['r'], 1=>['a', 'o'])
        @test exercise11_3(exercise11_1("tweet")) == Dict(2=>['t', 'e'], 1=>['w'])
    end

    @testset "Standard Ackermann" begin
        @test standard_ackermann(3, 4) == 125
        @test standard_ackermann(1, 0) == 2
        @test standard_ackermann(2, 0) == 3
        @test standard_ackermann(3, 0) == 5
        @test standard_ackermann(4, 0) == 13
    end

    @testset "Memo Ackermann" begin
        @test exercise11_4(3, 4) == 125
        @test exercise11_4(1, 0) == 2
        @test exercise11_4(2, 0) == 3
        @test exercise11_4(3, 0) == 5
        @test exercise11_4(4, 0) == 13
        @test exercise11_4(4, 1) == 65533
    end

end
