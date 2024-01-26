using FuzzyPlayground
using Test

@testset "Sum of two triangular" begin 
    
    f1 = Triangular(1, 3, 9)
    f2 = Triangular(6, 12, 15)

    result = f1 + f2

    @test result.a == 7 
    @test result.b == 15 
    @test result.c == 24

end 