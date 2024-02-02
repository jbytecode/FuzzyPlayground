@testset "Load data and convert to Triangular" verbose = true begin

	atol = 0.00001

	filename = "data/simpledata1.dat"

	seperator = ','

	data = loadfuzzydata(filename, Triangular, delim = seperator)

	expectedresult = [
		Triangular(0.0850444, 0.281355, 0.30146)      Triangular(0.352535, 0.353548, 0.369791)    Triangular(0.481054, 0.860453, 0.975295);
		Triangular(0.138224, 0.175757, 0.251231)      Triangular(0.267265, 0.298295, 0.29918)     Triangular(0.310574, 0.775556, 0.900811);
		Triangular(0.0245844, 0.0540223, 0.232563)    Triangular(0.474525, 0.569292, 0.572759)    Triangular(0.682101, 0.811294, 0.926343);
		Triangular(0.200205, 0.260441, 0.33161)       Triangular(0.471592, 0.65859, 0.734439)     Triangular(0.890634, 0.899495, 0.968514)
	]

	@test data isa Matrix
	@test eltype(data) == Triangular
	@test size(data) == (4, 3)

	for i in 1:4
		for j in 1:3
			@test isapprox(expectedresult[i, j], data[i, j], atol = atol)
		end
	end

end
