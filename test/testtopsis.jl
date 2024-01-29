@testset "Topsis" begin

    @testset "Sample in the short paper" begin

        """
        References:

        Kore, N. B., Ravi, K., & Patil, S. B. (2017). A simplified description of fuzzy TOPSIS 
        method for multi criteria decision making. International Research Journal of Engineering
        and Technology (IRJET), 4(5), 2047-2050.
        """

        @testset "Preparing decision matrix using multiple decision makers" begin
            # Two decision makers
            # Two alternatives 
            # Four criteria
            dm1 = [
                Triangular(3, 5, 7) Triangular(7, 9, 9) Triangular(1, 3, 5) Triangular(3, 5, 7);
                Triangular(5, 7, 9) Triangular(5, 7, 9) Triangular(1, 3, 5) Triangular(1, 3, 5)
            ]

            dm2 = [
                Triangular(3, 5, 7) Triangular(7, 9, 9) Triangular(3, 5, 7) Triangular(3, 5, 7);
                Triangular(5, 7, 9) Triangular(7, 9, 9) Triangular(1, 3, 5) Triangular(1, 3, 5)
            ]

            decmat = fuzzydecmat([dm1, dm2])

            expected = [
                Triangular(3, 5, 7) Triangular(7, 9, 9) Triangular(1, 4, 7) Triangular(3, 5, 7);
                Triangular(5, 7, 9) Triangular(5, 8, 9) Triangular(1, 3, 5) Triangular(1, 3, 5)
            ]

            n, p = decmat |> size

            for i in 1:n
                for j in 1:p
                    @test decmat[i, j] == expected[i, j]
                end
            end
        end

        @testset "Preparing weight vector using multiple decision makers" begin
            # These are decision makers' weight vectors
            # There are 2 decision makers.
            weights = [
                [
                    Triangular(5, 7, 9),
                    Triangular(7, 9, 9),
                    Triangular(7, 9, 9),
                    Triangular(3, 5, 7),
                ],
                [
                    Triangular(3, 5, 7),
                    Triangular(5, 7, 9),
                    Triangular(5, 7, 9),
                    Triangular(1, 3, 5),
                ],
            ]

            summarizedweights = prepare_weights(weights)

            expected = [
                Triangular(3.000, 6.000, 9.000),
                Triangular(5.000, 8.000, 9.000),
                Triangular(5.000, 8.000, 9.000),
                Triangular(1.000, 4.000, 7.000),
            ]

            for i in eachindex(expected)
                @test expected[i] == summarizedweights[i]
            end
        end

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
                        atol=eps,
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
                        atol=eps,
                    )
                end
            end



            @test result.bestideal == [
                Triangular(9.0, 9.0, 9.0),
                Triangular(9.0, 9.0, 9.0),
                Triangular(9.0, 9.0, 9.0),
                Triangular(7.0, 7.0, 7.0),
            ]

            @test result.worstideal == [
                Triangular(1.0, 1.0, 1.0),
                Triangular(2.7777777777777777, 2.7777777777777777, 2.7777777777777777),
                Triangular(0.7142857142857142, 0.7142857142857142, 0.7142857142857142),
                Triangular(0.14285714285714285, 0.14285714285714285, 0.14285714285714285),
            ]

            @test result.sminus == [19.130795215674166, 13.675031586664522]

            @test result.splus == [18.352692130107226, 21.116560843933744]


            @test isapprox(result.scores[1], 0.51, atol=eps)
            @test isapprox(result.scores[2], 0.39, atol=eps)

        end
    end


    @testset "A full example" begin

        """
        References:

        Nihan, T. C. (2011). Fuzzy Topsis Methods in Group Decision Making And An Application 
        For Bank Branch Location Selection. Journal of Engineering and Natural Sciences, 
        Sigma, 29, 11-24.
        """
        atol = 0.01

        dm1 = [Triangular(7.7, 9.3, 9.7) Triangular(7.3, 8.7, 9.3) Triangular(7.3, 8.7, 9.3) Triangular(7.3, 8.7, 9.3) Triangular(7.3, 8.7, 9.3);
            Triangular(7.3, 8.7, 9.3) Triangular(5.3, 6.5, 7.7) Triangular(7.7, 9.3, 9.7) Triangular(6.3, 7.5, 8.67) Triangular(6.3, 7.5, 8.67);
            Triangular(5.7, 7, 8.3) Triangular(5, 6.5, 8) Triangular(5.7, 7, 8.3) Triangular(5.67, 7, 8.3) Triangular(5.67, 7, 8.3);
            Triangular(7, 8, 9) Triangular(5, 6.5, 8) Triangular(5.7, 7, 8.3) Triangular(5.67, 7, 8.3) Triangular(5.67, 7, 8.3);
            Triangular(5, 6.5, 8) Triangular(3.3, 4.5, 5.7) Triangular(4.7, 6, 7.3) Triangular(4, 5, 6) Triangular(4.3, 5.5, 6.7)]

        dm2 = [
            Triangular(7, 9.33, 10) Triangular(7, 8.67, 10) Triangular(5, 7.83, 10) Triangular(7, 8.67, 10) Triangular(7, 8.67, 10);
            Triangular(7, 8.67, 10) Triangular(4, 6.5, 9) Triangular(7, 9.33, 10) Triangular(5, 7.5, 9) Triangular(5, 7.5, 9);
            Triangular(5, 7, 9) Triangular(5, 6.7, 9) Triangular(5, 7, 9) Triangular(5, 7, 9) Triangular(5, 7, 9);
            Triangular(7, 8, 9) Triangular(5, 6.5, 8) Triangular(7, 8, 9) Triangular(5, 7, 9) Triangular(5, 7, 9);
            Triangular(5, 6.5, 8) Triangular(2, 4.5, 6) Triangular(4, 6, 8) Triangular(4, 5, 6) Triangular(4, 5.5, 8)
        ]

        we = [
            [
                Triangular(0.8, 1, 1),
                Triangular(0.77, 0.93, 0.97),
                Triangular(0.73, 0.87, 0.93),
                Triangular(0.57, 0.7, 0.83),
                Triangular(0.7, 0.77, 0.9),
            ], [
                Triangular(0.8, 1, 1),
                Triangular(0.7, 0.93, 1),
                Triangular(0.7, 0.87, 1),
                Triangular(0.5, 0.7, 0.9),
                Triangular(0.7, 0.77, 0.9),
            ]
        ]

        decmat = fuzzydecmat([dm1, dm2])

        weights = prepare_weights(we)

        fns = [maximum for i in 1:5]
        result = fuzzytopsis(decmat, weights, fns)

        myorder = result.scores |> sortperm

        @test myorder[1] == 5
        @test myorder[2] == 3
        @test myorder[3] == 4
        @test myorder[4] == 2
        @test myorder[5] == 1



        @test isapprox(result.scores[1], 0.611, atol=atol)
        @test isapprox(result.scores[2], 0.540, atol=atol)
        @test isapprox(result.scores[3], 0.48, atol=atol)
        @test isapprox(result.scores[4], 0.505, atol=atol)
        @test isapprox(result.scores[5], 0.350, atol=atol)

    end
end
