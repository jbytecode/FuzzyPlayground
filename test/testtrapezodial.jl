@testset "Trapezodial Fuzzy Numbers" begin


    @testset "Equality of Trapezodial" begin
        @test Trapezodial(1, 2, 3, 6) == Trapezodial(1, 2, 3, 6)

        t1 = Trapezodial(6, 8, 12, 13)
        @test isequal(t1, t1)

    end

    @testset "Sum of two Trapezodial" begin 

        t1 = Trapezodial(1, 2, 3, 4)
        t2 = Trapezodial(2, 5, 7, 9)

        result = t1 + t2 

        @test result == Trapezodial(3, 7, 10, 13)
    end 

    @testset "Diff of Trapezodial" begin 

        t1 = Trapezodial(1, 2, 3, 4)
        t2 = Trapezodial(2, 5, 7, 9)

        result = t2 - t1 

        @test result == Trapezodial(-2, 2, 5, 8)

    end 


    @testset "Multiply by scalar" begin
        result1 = Trapezodial(4, 6, 7, 9) * 10
        @test result1.a == 40
        @test result1.b == 60
        @test result1.c == 70
        @test result1.d == 90

        result2 = 10 * Trapezodial(4, 6, 7, 9)
        @test result2.a == 40
        @test result2.b == 60
        @test result2.c == 70
        @test result2.d == 90
    end


    @testset "Inverse of Trapezodial" begin
        t = Trapezodial(2, 3, 4, 5)

        result = inv(t)

        @test result.a == 1 / 5
        @test result.b == 1 / 4
        @test result.c == 1 / 3
        @test result.d == 1 / 2
    end


    @testset "Multiply two Trapezodial" begin
        t1 = Trapezodial(1, 4, 6, 9)
        t2 = Trapezodial(6, 8, 9, 10)

        result = t1 * t2
        resultother = t2 * t1

        @test result == Trapezodial(6, 32, 54, 90)
        @test result == resultother 
    end

    @testset "Division of two Trapezodial" begin 

        t1 = Trapezodial(1, 4, 6, 9)
        t2 = Trapezodial(6, 8, 9, 10)

        result = t1 * t2
        
        @test result == Trapezodial(6, 32, 54, 90)
    end 

end 