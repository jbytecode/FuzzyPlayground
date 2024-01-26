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