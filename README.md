# FuzzyPlayground
Fuzzy Playground / Sandbox


```julia

# Example with 2 alternatives and 4 criteria
# Fuzzy numbers are in form of Triangular (a, b, c)
# 
# Reference:
# 
# Kore, N. B., Ravi, K., & Patil, S. B. (2017). A simplified description of fuzzy TOPSIS method for multi criteria decision making. International Research Journal of Engineering and Technology (IRJET), 4(5), 2047-2050.

decmat = [
            Triangular(3, 5, 7) Triangular(7, 9, 9) Triangular(1, 4, 7) Triangular(3, 5, 7)
            Triangular(5, 7, 9) Triangular(5, 8, 9) Triangular(1, 3, 5) Triangular(1, 3, 5)
         ]

w =     [
            Triangular(3, 6, 9),
            Triangular(5, 8, 9),
            Triangular(5, 8, 9),
            Triangular(1, 4, 7),
        ]

fns = [minimum, maximum, maximum, maximum]

result = fuzzytopsis(decmat, w, fns)
```

```julia
julia> result.normalized_decmat
2×4 Matrix{Triangular}:
 Triangular(0.428571, 0.6, 1.0)       Triangular(0.777778, 1.0, 1.0)       …  Triangular(0.428571, 0.714286, 1.0)
 Triangular(0.333333, 0.428571, 0.6)  Triangular(0.555556, 0.888889, 1.0)     Triangular(0.142857, 0.428571, 0.714286)

julia> result.weighted_normalized_decmat
2×4 Matrix{Triangular}:
 Triangular(1.28571, 3.6, 9.0)  Triangular(3.88889, 8.0, 9.0)      …  Triangular(0.428571, 2.85714, 7.0)
 Triangular(1.0, 2.57143, 5.4)  Triangular(2.77778, 7.11111, 9.0)     Triangular(0.142857, 1.71429, 5.0)

ulia> result.bestideal
4-element Vector{Triangular}:
 Triangular(1.0, 1.0, 1.0)
 Triangular(9.0, 9.0, 9.0)
 Triangular(9.0, 9.0, 9.0)
 Triangular(7.0, 7.0, 7.0)

julia> result.worstideal
4-element Vector{Triangular}:
 Triangular(9.0, 9.0, 9.0)
 Triangular(2.7777777777777777, 2.7777777777777777, 2.7777777777777777)
 Triangular(0.7142857142857142, 0.7142857142857142, 0.7142857142857142)
 Triangular(0.14285714285714285, 0.14285714285714285, 0.14285714285714285)

julia> result.sminus
2-element Vector{Float64}:
 19.707994569421572
 17.256778769322487

julia> result.splus
2-element Vector{Float64}:
 17.77549277635982
 17.53481366127578

julia> result.scores
2-element Vector{Float64}:
 0.5257780416111583
 0.4960042804521248

```

### Evaluating Fuzzy Numbers:

```julia
julia> f = Trapezodial(1, 2, 3, 20)
Trapezodial(1, 2, 3, 20)

julia> observe(f, 0)
0.0

julia> observe(f, 2)
1.0

julia> observe(f, 3)
1.0

julia> observe(f, 4)
0.9411764705882353

julia> observe(f, 6)
0.8235294117647058

julia> observe(f, 14)
0.35294117647058826
```

