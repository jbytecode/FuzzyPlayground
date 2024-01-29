@testset "Triangular Fuzzy Numbers" begin

    @testset "Constructor" begin

        @test_throws AssertionError Triangular(5, 4, 3)

    end

    @testset "Equality of triangulars" begin
        @test Triangular(1, 2, 3) == Triangular(1, 2, 3)
    end

    @testset "Sum of two triangular" begin
        f1 = Triangular(1, 3, 9)
        f2 = Triangular(6, 12, 15)

        result = f1 + f2

        @test result.a == 7
        @test result.b == 15
        @test result.c == 24
        @test result.a <= result.b <= result.c
    end

    @testset "Diff of two triangular" begin
        f1 = Triangular(1, 3, 9)
        f2 = Triangular(6, 12, 15)

        result = f1 - f2

        @test result.a <= result.b <= result.c
        @test result == Triangular(-14, -9, 3)
    end

    @testset "Multiply by scalar" begin
        result1 = Triangular(4, 6, 7) * 10
        @test result1.a == 40
        @test result1.b == 60
        @test result1.c == 70

        result2 = 10 * Triangular(4, 6, 7)
        @test result2.a == 40
        @test result2.b == 60
        @test result2.c == 70
    end

    @testset "Inverse of triangular" begin
        t = Triangular(2, 3, 4)

        result = inv(t)

        @test result.a == 1 / 4
        @test result.b == 1 / 3
        @test result.c == 1 / 2
    end

    @testset "Multiply two triangular" begin
        t1 = Triangular(1, 4, 6)
        t2 = Triangular(6, 8, 9)

        result = t1 * t2

        @test result == Triangular(6, 32, 54)
    end

    @testset "Division of two triangular" begin
        t1 = Triangular(1, 4, 7)
        t2 = Triangular(6, 8, 9)

        result = t1 / t2

        @test result == Triangular(1 / 9, 4 / 8, 7 / 6)
    end

    @testset "Euclidean distance" begin
        eps = 0.00001

        t1 = Triangular(0, 3, 4)

        @test euclidean(t1, t1) == 0.0
        @test isapprox(euclidean(t1), 2.8867513459481287, atol = eps)
    end

    @testset "Observe" begin
        f = Triangular(1, 2, 5)

        @test observe(f, 0) == 0
        @test observe(f, 1.5) == 0.5
        @test observe(f, 4) == 0.3333333333333333
    end

    @testset "First" begin
        @test Triangular(1, 2, 3) |> first == 1
        @test Triangular(2, 3, 4) |> first == 2
    end

    @testset "Last" begin
        @test Triangular(1, 2, 3) |> last == 3
        @test Triangular(2, 3, 4) |> last == 4
    end

    @testset "Zero" begin
        @test zero(Triangular) == Triangular(0, 0, 0)
    end

    @testset "One" begin
        @test one(Triangular) == Triangular(1, 1, 1)
    end

    @testset "Zeros" begin
        v = zeros(Triangular, 10)

        @test v isa Vector{Triangular}
        @test length(v) == 10
        @test v[1] == zero(Triangular)
    end

    @testset "Random" begin 

        fnum = rand(Triangular)
        @test fnum.a <= fnum.b <= fnum.c 

        v = rand(Triangular, 5)
        @test length(v) == 5
        @test v[1] isa Triangular

        m = rand(Triangular, 4, 5)
        @test m isa Matrix
        @test m[1, 1] isa Triangular
        @test size(m) == (4, 5)
    end 

end
