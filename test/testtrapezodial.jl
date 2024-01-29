@testset "Trapezodial Fuzzy Numbers" begin

    @testset "Constructor" begin

        @test_throws AssertionError Trapezodial(5, 4, 3, 2)
        @test_throws AssertionError Trapezodial(5, 1, 3, 2)
        @test_throws AssertionError Trapezodial(5, 4, 6, 2)

    end


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

    @testset "Euclidean distance" begin
        eps = 0.00001

        t1 = Trapezodial(0, 0, 3, 4)

        @test euclidean(t1, t1) == 0.0
        @test isapprox(euclidean(t1), 2.5, atol = eps)
    end

    @testset "Observe" begin
        f = Trapezodial(1, 2, 5, 11)

        @test observe(f, 0) == 0
        @test observe(f, 3) == 1
        @test observe(f, 4) == 1
        @test observe(f, 6) == 0.8333333333333334
        @test observe(f, 23412) == 0
    end

    @testset "First" begin
        @test Trapezodial(1, 2, 3, 5) |> first == 1
        @test Trapezodial(2, 3, 4, 5) |> first == 2
    end

    @testset "Last" begin
        @test Trapezodial(1, 2, 3, 5) |> last == 5
        @test Trapezodial(2, 3, 4, 6) |> last == 6
    end

    @testset "Zero" begin
        @test zero(Trapezodial) == Trapezodial(0, 0, 0, 0)
    end

    @testset "One" begin
        @test one(Trapezodial) == Trapezodial(1, 1, 1, 1)
    end

    @testset "Zeros" begin
        v = zeros(Trapezodial, 10)

        @test v isa Vector{Trapezodial}
        @test length(v) == 10
        @test v[1] == zero(Trapezodial)
    end


    @testset "Random" begin 

        fnum = rand(Trapezodial)
        @test fnum.a <= fnum.b <= fnum.c <= fnum.d

        v = rand(Trapezodial, 5)
        @test length(v) == 5
        @test v[1] isa Trapezodial

        m = rand(Trapezodial, 4, 5)
        @test m isa Matrix
        @test m[1, 1] isa Trapezodial
        @test size(m) == (4, 5)
    end 

end
