module FuzzyPlayground

export FuzzyNumber, Triangular, Trapezodial

abstract type FuzzyNumber end 

mutable struct Triangular <: FuzzyNumber 
    a
    b
    c
end 

mutable struct Trapezodial <: FuzzyNumber
    a 
    b 
    c 
    d 
end 

function Base.:+(t1::Triangular, t2::Triangular)::Triangular
    return Triangular(
        t1.a + t2.a, 
        t1.b + t2.b, 
        t1.c + t2.c 
    )
end 


end 
