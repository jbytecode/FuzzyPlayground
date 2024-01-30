using FuzzyPlayground

decmat = [
    Trapezodial(4.0, 6.3, 6.7, 9.0) Trapezodial(7.0, 8.3, 8.7, 10.0) Trapezodial(1.0, 3.3, 3.7, 6.0) Trapezodial(8.0, 9.0, 10.0, 10.0) Trapezodial(2.0, 5.3, 5.7, 9.0) Trapezodial(2.0, 4.7, 5.3, 8.0)
    Trapezodial(4.0, 5.3, 5.7, 8.0) Trapezodial(7.0, 8.3, 8.7, 10.0) Trapezodial(7.0, 8.3, 8.7, 10.0) Trapezodial(2.0, 4.7, 5.3, 8.0) Trapezodial(5.0, 7.7, 8.3, 10.0) Trapezodial(7.0, 8.3, 8.7, 10.0)
    Trapezodial(2.0, 4.0, 5.0, 8.0) Trapezodial(7.0, 8.3, 8.7, 10.0) Trapezodial(0.0, 1.7, 2.3, 5.0) Trapezodial(7.0, 8.7, 9.3, 10.0) Trapezodial(4.0, 5.3, 5.7, 8.0) Trapezodial(2.0, 3.7, 4.3, 6.0)
    Trapezodial(4.0, 6.3, 6.7, 10.0) Trapezodial(7.0, 8.7, 9.3, 10.0) Trapezodial(8.0, 9.0, 10.0, 10.0) Trapezodial(0.0, 0.7, 1.3, 3.0) Trapezodial(8.0, 9.0, 10.0, 10.0) Trapezodial(8.0, 9.0, 10.0, 10.0)
]


w = [
    Trapezodial(0.40, 0.73, 0.77, 1.00)
    Trapezodial(0.70, 0.87, 0.93, 1.00)
    Trapezodial(0.80, 0.90, 1.00, 1.00)
    Trapezodial(0.50, 0.77, 0.83, 1.00)
    Trapezodial(0.70, 0.87, 0.93, 1.00)
    Trapezodial(0.50, 0.70, 0.80, 1.00)
]

fns = [maximum for _ = 1:6]

result = fuzzytopsis(decmat, w, fns)

display(result.scores)
