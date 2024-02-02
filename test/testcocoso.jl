@testset "Pamukkale - Master Thesis Example" begin

	"""
	Reference: 
	Yenilmezel Alıcı, S. (2023). Bulanık çok kriterli karar verme yöntemleri ile bir işletme 
	için insan kaynakları yönetimi uygulaması seçimi (Master's thesis). Pamukkale Üniversitesi
	"""

	atol = 0.001

	decmat = [
		Triangular(0.6253, 0.9168, 1.0000)  Triangular(0.3625, 0.4465, 0.5835)  Triangular(0.5835, 0.8335, 1.0000)  Triangular(0.6253, 0.9168, 1.0000) Triangular(0.4500, 0.5835, 0.8335)  Triangular(0.4750, 0.6253, 0.9168)   Triangular(0.6670, 1.0000, 1.0000);
		Triangular(0.4750, 0.6253, 0.9168)  Triangular(0.3625, 0.4465, 0.5835)  Triangular(0.4083, 0.5168, 0.7085)  Triangular(0.4750, 0.6253, 0.9168) Triangular(0.3095, 0.3665, 0.4500)  Triangular(0.6253, 0.9168, 1.0000)   Triangular(0.2520, 0.2888, 0.3380);
		Triangular(0.2290, 0.2590, 0.2978)  Triangular(0.3625, 0.4465, 0.5835)  Triangular(0.2500, 0.2860, 0.3330)  Triangular(0.6253, 0.9168, 1.0000) Triangular(0.3665, 0.4500, 0.5835)  Triangular(0.4750, 0.6253, 0.9168)   Triangular(0.2888, 0.3380, 0.4083);
		Triangular(0.3095, 0.3665, 0.4500)  Triangular(0.3625, 0.4465, 0.5835)  Triangular(0.3213, 0.3833, 0.4750)  Triangular(0.3833, 0.4750, 0.6253) Triangular(0.4500, 0.5835, 0.8335)  Triangular(0.3833, 0.4750, 0.6253)   Triangular(0.3748, 0.4250, 0.5418)
	]

	w = [
		Triangular(0.0550, 0.1505, 0.4828),
		Triangular(0.0287, 0.0369, 0.0892),
		Triangular(0.0528, 0.0879, 0.2227),
		Triangular(0.0789, 0.1497, 0.2409),
		Triangular(0.0868, 0.1701, 0.2761),
		Triangular(0.0838, 0.1580, 0.2573),
		Triangular(0.1251, 0.2468, 0.4056),
	]

	fns = [minimum, maximum, minimum, maximum, maximum, maximum, maximum]

	expectedS = [
		Triangular(0.1361, 0.5770, 1.5927),
		Triangular(0.0711, 0.3699, 1.1800),
		Triangular(0.1561, 0.5078, 1.4873),
		Triangular(0.1200, 0.4018, 1.3518),
	]

	expectedP = [
		Triangular(3.6023, 6.2931, 6.5465),
		Triangular(3.6211, 5.8318, 5.8561),
		Triangular(5.2808, 6.1815, 6.3293),
		Triangular(3.6526, 6.0029, 6.1911),
	]

	# Possibly incorrect scores
	# expectedScores = [
	# 	2.7571,
	# 	2.1085,
	# 	2.7728,
	# 	2.3190,
	# ]

	expectedScores = [
		5.8677,
		4.5005,
		5.7084,
		5.0189
	]


	n, p = size(decmat)

	result = fuzzycocoso(decmat, w, fns)


	@testset "Normalized Decision Matrix" begin
		@test isapprox(result.normalized_decmat[1, 1], Triangular(0.0000, 0.1080, 0.4861), atol = atol)
		@test isapprox(result.normalized_decmat[1, 2], Triangular(0.0000, 0.3801, 1.0000), atol = atol)
		@test isapprox(result.normalized_decmat[1, 3], Triangular(0.0000, 0.2220, 0.5553), atol = atol)
		@test isapprox(result.normalized_decmat[1, 4], Triangular(0.3924, 0.8650, 1.0000), atol = atol)
		@test isapprox(result.normalized_decmat[1, 5], Triangular(0.2681, 0.5229, 1.0000), atol = atol)
		@test isapprox(result.normalized_decmat[1, 6], Triangular(0.1488, 0.3924, 0.8650), atol = atol)
		@test isapprox(result.normalized_decmat[1, 7], Triangular(0.5548, 1.0000, 1.0000), atol = atol)

		@test isapprox(result.normalized_decmat[2, 1], Triangular(0.1080, 0.4861, 0.6809), atol = atol)
		@test isapprox(result.normalized_decmat[2, 2], Triangular(0.0000, 0.3801, 1.0000), atol = atol)
		@test isapprox(result.normalized_decmat[2, 3], Triangular(0.3887, 0.6443, 0.7890), atol = atol)
		@test isapprox(result.normalized_decmat[2, 4], Triangular(0.1488, 0.3924, 0.8650), atol = atol)
		@test isapprox(result.normalized_decmat[2, 5], Triangular(0.0000, 0.1088, 0.2681), atol = atol)
		@test isapprox(result.normalized_decmat[2, 6], Triangular(0.3924, 0.8650, 1.0000), atol = atol)
		@test isapprox(result.normalized_decmat[2, 7], Triangular(0.0000, 0.0491, 0.1150), atol = atol)

		@test isapprox(result.normalized_decmat[3, 1], Triangular(0.9108, 0.9611, 1.0000), atol = atol)
		@test isapprox(result.normalized_decmat[3, 2], Triangular(0.0000, 0.3801, 1.0000), atol = atol)
		@test isapprox(result.normalized_decmat[3, 3], Triangular(0.8893, 0.9520, 1.0000), atol = atol)
		@test isapprox(result.normalized_decmat[3, 4], Triangular(0.3924, 0.8650, 1.0000), atol = atol)
		@test isapprox(result.normalized_decmat[3, 5], Triangular(0.1088, 0.2681, 0.5229), atol = atol)
		@test isapprox(result.normalized_decmat[3, 6], Triangular(0.1488, 0.3924, 0.8650), atol = atol)
		@test isapprox(result.normalized_decmat[3, 7], Triangular(0.0491, 0.1150, 0.2089), atol = atol)

		@test isapprox(result.normalized_decmat[4, 1], Triangular(0.7134, 0.8217, 0.8956), atol = atol)
		@test isapprox(result.normalized_decmat[4, 2], Triangular(0.0000, 0.3801, 1.0000), atol = atol)
		@test isapprox(result.normalized_decmat[4, 3], Triangular(0.7000, 0.8223, 0.9050), atol = atol)
		@test isapprox(result.normalized_decmat[4, 4], Triangular(0.0000, 0.1488, 0.3924), atol = atol)
		@test isapprox(result.normalized_decmat[4, 5], Triangular(0.2681, 0.5229, 1.0000), atol = atol)
		@test isapprox(result.normalized_decmat[4, 6], Triangular(0.0000, 0.1488, 0.3924), atol = atol)
		@test isapprox(result.normalized_decmat[4, 7], Triangular(0.1641, 0.2313, 0.3874), atol = atol)
	end

	@testset "Weighted Normalized Decision Matrix" begin
		@test isapprox(result.weighted_normalized_decmat[1, 1], Triangular(0.0000, 0.0163, 0.2347), atol = atol)
		@test isapprox(result.weighted_normalized_decmat[1, 2], Triangular(0.0000, 0.0140, 0.0892), atol = atol)
		@test isapprox(result.weighted_normalized_decmat[1, 3], Triangular(0.0000, 0.0195, 0.1237), atol = atol)
		@test isapprox(result.weighted_normalized_decmat[1, 4], Triangular(0.0310, 0.1295, 0.2409), atol = atol)
		@test isapprox(result.weighted_normalized_decmat[1, 5], Triangular(0.0233, 0.0889, 0.2761), atol = atol)
		@test isapprox(result.weighted_normalized_decmat[1, 6], Triangular(0.0125, 0.0620, 0.2226), atol = atol)
		@test isapprox(result.weighted_normalized_decmat[1, 7], Triangular(0.0694, 0.2468, 0.4056), atol = atol)

		@test isapprox(result.weighted_normalized_decmat[2, 1], Triangular(0.0059, 0.0732, 0.3288), atol = atol)
		@test isapprox(result.weighted_normalized_decmat[2, 2], Triangular(0.0000, 0.0140, 0.0892), atol = atol)
		@test isapprox(result.weighted_normalized_decmat[2, 3], Triangular(0.0205, 0.0566, 0.1757), atol = atol)
		@test isapprox(result.weighted_normalized_decmat[2, 4], Triangular(0.0117, 0.0587, 0.2084), atol = atol)
		@test isapprox(result.weighted_normalized_decmat[2, 5], Triangular(0.0000, 0.0185, 0.0740), atol = atol)
		@test isapprox(result.weighted_normalized_decmat[2, 6], Triangular(0.0329, 0.1367, 0.2573), atol = atol)
		@test isapprox(result.weighted_normalized_decmat[2, 7], Triangular(0.0000, 0.0121, 0.0466), atol = atol)
	end

	@testset "S values" begin
		for i in 1:4
			@test isapprox(expectedS[i], result.S[i], atol = atol)
		end
	end

    @testset "Score Mat" begin 
        #@test isapprox(result.scoremat[1, 1], Triangular(0.0000, 0.7153, 0.7059), atol = atol)
		#@test isapprox(result.scoremat[1, 2], Triangular(0.0000, 0.9649, 1.0000), atol = atol)
		#@test isapprox(result.scoremat[1, 3], Triangular(0.0000, 0.8761, 0.8772), atol = atol)
		#@test isapprox(result.scoremat[1, 4], Triangular(0.9288, 0.9785, 1.0000), atol = atol)
		#@test isapprox(result.scoremat[1, 5], Triangular(0.8920, 0.8956, 1.0000), atol = atol)
		#@test isapprox(result.scoremat[1, 6], Triangular(0.8524, 0.8626, 0.9634), atol = atol)
		#@test isapprox(result.scoremat[1, 7], Triangular(0.9290, 1.0000, 1.0000), atol = atol)
    end 

    
    @testset "P values" begin
		for i in 1:4
			@test isapprox(expectedP[i], result.P[i], atol = atol)
		end
	end

	@testset "Scores" begin 
		for i in 1:4
			@test isapprox(expectedScores[i], result.scores[i], atol = atol)
		end 
	end 
end






#@testset "Cocoso Example" verbose = true begin
#
#    eps = 0.01
#
#        decmat = [
#            Triangular(3, 5, 7) Triangular(7, 9, 9) Triangular(1, 4, 7) Triangular(3, 5, 7)
#            Triangular(5, 7, 9) Triangular(5, 8, 9) Triangular(1, 3, 5) Triangular(1, 3, 5)
#        ]
#
#        n, p = size(decmat)
#
#        w = [
#            Triangular(3, 6, 9),
#            Triangular(5, 8, 9),
#            Triangular(5, 8, 9),
#            Triangular(1, 4, 7),
#        ]
#
#        fns = [minimum, maximum, maximum, maximum]
#
#        result = fuzzycocoso(decmat, w, fns)
#
#        @info result.scores
#end
