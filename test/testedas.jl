@testset "Edas" begin 

    epsilon = 0.01

decmat = Triangular[
Triangular(7.67,	9.00,	9.67)   Triangular(5.67,	7.67,	9.33) 	Triangular(5.33,	6.67,	7.67) 	Triangular(0.67,	2.33,	4.33)	Triangular(1.33,	2.67,	4.33)	Triangular(2.00,	3.67,	5.67)	Triangular(1.33,	3.00,	5.00)	Triangular(8.33,	9.67,	10.0)	Triangular(3.67,	5.67,	7.33)	Triangular(4.33,	6.33,	8.00)	Triangular(5.67,	7.33,	8.33)	Triangular(5.00,	7.00,	8.33)	Triangular(1.33,	3.00,	5.00)	Triangular(4.67,	6.33,	7.67);
Triangular(3.00,	5.00,	7.00)   Triangular(0.33,	1.67,	3.67) 	Triangular(4.33,	6.33,	8.33) 	Triangular(4.33,	6.33,	8.33)	Triangular(0.33,	1.67,	3.67)	Triangular(3.00,	5.00,	7.00)	Triangular(4.33,	6.33,	8.33)	Triangular(6.33,	8.00,	9.33)	Triangular(0.67,	2.33,	4.33)	Triangular(4.67,	6.00,	7.33)	Triangular(5.67,	7.33,	8.33)	Triangular(5.00,	6.67,	8.00)	Triangular(4.00,	5.33,	6.67)	Triangular(4.33,	6.00,	7.33);
Triangular(6.33,	8.33,	9.67)   Triangular(3.00,	5.00,	7.00) 	Triangular(5.00,	7.00,	8.67) 	Triangular(2.33,	4.33,	6.33)	Triangular(1.33,	2.67,	4.33)	Triangular(2.00,	3.67,	5.67)	Triangular(3.33,	5.00,	6.67)	Triangular(4.33,	6.33,	8.33)	Triangular(2.33,	4.33,	6.33)	Triangular(5.00,	7.00,	8.33)	Triangular(5.67,	7.33,	8.67)	Triangular(5.67,	7.33,	8.33)	Triangular(1.33,	3.00,	5.00)	Triangular(3.67,	5.67,	7.33);
Triangular(8.33,	9.67,	10.0)   Triangular(5.67,	7.33,	8.67) 	Triangular(6.33,	8.33,	9.67) 	Triangular(1.33,	3.00,	5.00)	Triangular(0.67,	2.00,	3.67)	Triangular(5.00,	7.00,	8.67)	Triangular(5.00,	6.67,	8.00)	Triangular(5.67,	7.67,	9.33)	Triangular(4.67,	5.00,	7.33)	Triangular(3.00,	5.00,	7.00)	Triangular(3.67,	5.67,	7.33)	Triangular(3.67,	5.67,	7.33)	Triangular(1.33,	3.00,	5.00)	Triangular(4.00,	5.67,	7.33);
Triangular(7.67,	9.33,	10.0)   Triangular(6.33,	8.33,	9.67) 	Triangular(5.67,	7.67,	9.00) 	Triangular(0.67,	2.00,	3.67)	Triangular(1.67,	3.00,	5.00)	Triangular(3.33,	5.00,	7.00)	Triangular(3.33,	5.00,	7.00)	Triangular(4.33,	6.33,	8.33)	Triangular(6.33,	8.00,	9.33)	Triangular(5.00,	7.00,	8.33)	Triangular(4.33,	6.33,	8.00)	Triangular(5.00,	7.00,	8.33)	Triangular(0.67,	2.33,	4.33)	Triangular(4.00,	5.67,	7.33)
]

fns = [
    maximum,			
    maximum,			
    maximum,			
    minimum,			
    minimum,			
    minimum,			
    minimum,			
    minimum,			
    minimum,			
    maximum,			
    maximum,			
    maximum,			
    maximum,			
    maximum
]

weights = Triangular[
    Triangular(0.700,	0.900,	1.000),
    Triangular(0.367,	0.567,	0.767),
    Triangular(0.500,	0.700,	0.867),
    Triangular(0.567,	0.767,	0.933),
    Triangular(0.767,	0.933,	1.000),
    Triangular(0.633,	0.833,	0.967),
    Triangular(0.633,	0.833,	0.967),
    Triangular(0.567,	0.733,	0.867),
    Triangular(0.367,	0.567,	0.767),
    Triangular(0.567,	0.767,	0.933),
    Triangular(0.567,	0.733,	0.867),
    Triangular(0.767,	0.933,	1.000),
    Triangular(0.767,	0.933,	1.000),
    Triangular(0.633,	0.800,	0.933)
]

defuzmatrix = Float64[
8.78000	7.55667	6.55667	2.44333	2.77667	3.78000	3.11000	9.33333	5.55667	6.22000	7.11000	6.77667	3.11000	6.22333;
5.00000	1.89000	6.33000	6.33000	1.89000	5.00000	6.33000	7.88667	2.44333	6.00000	7.11000	6.55667	5.33333	5.88667;
8.11000	5.00000	6.89000	4.33000	2.77667	3.78000	5.00000	6.33000	4.33000	6.77667	7.22333	7.11000	3.11000	5.55667;
9.33333	7.22333	8.11000	3.11000	2.11333	6.89000	6.55667	7.55667	5.66667	5.00000	5.55667	5.55667	3.11000	5.66667;
9.00000	8.11000	7.44667	2.11333	3.22333	5.11000	5.11000	6.33000	7.88667	6.77667	6.22000	6.77667	2.44333	5.66667

]

n, p = size(decmat)

@test n == 5
@test p == 14


result = fuzzyedas(decmat, weights, fns)


@test isapprox(result.defuzmatrix, defuzmatrix, atol=epsilon)

@show result.pda

end 