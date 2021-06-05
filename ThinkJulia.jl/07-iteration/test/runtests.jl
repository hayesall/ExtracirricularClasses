# Copyright © 2019 Alexander L. Hayes

module Exercise07Tests

    using Test
    using Exercises07

    @testset "Square Roots" begin
        @test exercise_7_2_1(2) ≈ 1.41 atol=0.01
        @test exercise_7_2_1(4) == 2
        @test exercise_7_2_1(25) == 5
    end

    @testset "π Time" begin
        @test exercise_7_4() ≈ π atol=0.001
    end
end
