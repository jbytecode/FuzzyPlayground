# FuzzyPlayground
Fuzzy Playground / Sandbox

### Installing 

```julia
(@v1.10) pkg> add https://github.com/jbytecode/FuzzyPlayground.git
```

or 

```julia
julia> using Pkg
julia> Pkg.add(url = "https://github.com/jbytecode/FuzzyPlayground.git")
```


### Experimental Topsis

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

### Multiple Decision Makers 

Determining the decision matrix

```julia
# Two decision makers
# Two alternatives 
# Four criteria
dm1 = [
    Triangular(3,5,7) Triangular(7,9,9) Triangular(1,3,5) Triangular(3,5,7);
    Triangular(5,7,9) Triangular(5,7,9) Triangular(1,3,5) Triangular(1,3,5)
]

dm2 = [
    Triangular(3,5,7) Triangular(7,9,9) Triangular(3,5,7) Triangular(3,5,7);
    Triangular(5,7,9) Triangular(7,9,9) Triangular(1,3,5) Triangular(1,3,5)
]

decmat = fuzzydecmat([dm1, dm2])
```

Determining the aggregate weight vector


```julia
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
```
