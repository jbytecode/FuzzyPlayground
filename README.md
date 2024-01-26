# FuzzyPlayground
Fuzzy Playground / Sandbox


```julia
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
```