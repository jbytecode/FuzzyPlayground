@testset "Topsis" begin

	@testset "Triangular: Alternative: 2, Criteria: 4" begin

		eps = 0.01

		decmat = [
			Triangular(3, 5, 7)  Triangular(7, 9, 9)  Triangular(1, 4, 7)  Triangular(3, 5, 7);
			Triangular(5, 7, 9)  Triangular(5, 8, 9)  Triangular(1, 3, 5)  Triangular(1, 3, 5)
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
			Triangular(0.429, 0.600, 1.000) Triangular(0.778, 1.000, 1.000) Triangular(0.143, 0.571, 1.000) Triangular(0.429, 0.714, 1.000);
			Triangular(0.333, 0.429, 0.600) Triangular(0.556, 0.889, 1.000) Triangular(0.143, 0.429, 0.714) Triangular(0.143, 0.429, 0.714)
		]

		for i in 1:n
			for j in 1:p
				@test isapprox(
					result.normalized_decmat[i, j],
					expected_normalized_mat[i, j],
					atol = eps,
				)
			end
		end


	end
end
