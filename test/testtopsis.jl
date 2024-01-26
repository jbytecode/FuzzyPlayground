@testset "Topsis" begin

    @testset "Triangular: Alternative: 2, Criteria: 4" begin

        eps = 0.01

        decmat = [
            Triangular(3, 5, 7) Triangular(7, 9, 9) Triangular(1, 4, 7) Triangular(3, 5, 7)
            Triangular(5, 7, 9) Triangular(5, 8, 9) Triangular(1, 3, 5) Triangular(1, 3, 5)
        ]

        n, p = size(decmat)

        w = [
            Triangular(3, 6, 9),
            Triangular(5, 8, 9),
            Triangular(5, 8, 9),
            Triangular(1, 4, 7),
        ]

        fns = [minimum, maximum, maximum, maximum]

        result = fuzzytopsis(decmat, w, fns)

        expected_normalized_mat = [
            Triangular(0.429, 0.600, 1.000) Triangular(0.778, 1.000, 1.000) Triangular(0.143, 0.571, 1.000) Triangular(0.429, 0.714, 1.000)
            Triangular(0.333, 0.429, 0.600) Triangular(0.556, 0.889, 1.000) Triangular(0.143, 0.429, 0.714) Triangular(0.143, 0.429, 0.714)
        ]

        for i = 1:n
            for j = 1:p
                @test isapprox(
                    result.normalized_decmat[i, j],
                    expected_normalized_mat[i, j],
                    atol = eps,
                )
            end
        end

        expected_weighted_norm = [
            Triangular(1.287, 3.600, 9.000) Triangular(3.890, 8.000, 9.000) Triangular(0.715, 4.568, 9.000) Triangular(0.429, 2.856, 7.000)
            Triangular(0.999, 2.574, 5.400) Triangular(2.780, 7.112, 9.000) Triangular(0.715, 3.432, 6.426) Triangular(0.143, 1.716, 4.998)
        ]

        for i = 1:n
            for j = 1:p
                @test isapprox(
                    result.weighted_normalized_decmat[i, j],
                    expected_weighted_norm[i, j],
                    atol = eps,
                )
            end
        end

        @test isapprox(result.scores[1], 0.5257780416111583, atol = eps)
        @test isapprox(result.scores[2], 0.4960042804521248, atol = eps)

        display(result.bestideal)

        display(result.worstideal)

        display(result.sminus)

        display(result.splus)

        display(result.scores)

    end
end
