@testset "example" begin 
    
    decmat = [
        Triangular(0.6253, 0.9168, 1.0000)  Triangular(0.3625, 0.4465, 0.5835)  Triangular(0.5835, 0.8335, 1.0000)  Triangular(0.6253, 0.9168, 1.0000) Triangular(0.4500, 0.5835, 0.8335)  Triangular(0.4750, 0.6253, 0.9168)   Triangular(0.6670, 1.0000, 1.0000);
        Triangular(0.4750, 0.6253, 0.9168)  Triangular(0.3625, 0.4465, 0.5835)  Triangular(0.4083, 0.5168, 0.7085)  Triangular(0.4750, 0.6253, 0.9168) Triangular(0.3095, 0.3665, 0.4500)  Triangular(0.6253, 0.9168, 1.0000)   Triangular(0.2520, 0.2888, 0.3380);
        Triangular(0.2290, 0.2590, 0.2978)  Triangular(0.3625, 0.4465, 0.5835)  Triangular(0.2500, 0.2860, 0.3330)  Triangular(0.6253, 0.9168, 1.0000) Triangular(0.3665, 0.4500, 0.5835)  Triangular(0.4750, 0.6253, 0.9168)   Triangular(0.2888, 0.3380, 0.4083);
        Triangular(0.3095, 0.3665, 0.4500)  Triangular(0.3625, 0.4465, 0.5835)  Triangular(0.3213, 0.3833, 0.4750)  Triangular(0.3833, 0.4750, 0.6253) Triangular(0.4500, 0.5835, 0.8335)  Triangular(0.3833, 0.4750, 0.6253)   Triangular(0.3748, 0.4250, 0.5418)
    ]

    w = [
        Triangular(0.055, 0.1505, 0.4828),
        Triangular(0.0287, 0.0369, 0.0892),
        Triangular(0.0528, 0.0879, 0.2227),
        Triangular(0.0789, 0.1497, 0.2409),
        Triangular(0.0868, 0.1701, 0.2761),
        Triangular(0.0838, 0.158, 0.2573),
        Triangular(0.1251, 0.2468, 0.4056)
    ]

    fns = [minimum, maximum, minimum, maximum, maximum, maximum, maximum]

    result = fuzzycocoso(decmat, w, fns)

    @info result.scores
end 

@testset "Cocoso Example" verbose = true begin

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

        result = fuzzycocoso(decmat, w, fns)

        @info result.scores
end
