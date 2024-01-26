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

# a1 − c2 , b1 − b2 , c1 − a2
function Base.:-(t1::Triangular, t2::Triangular)::Triangular
    return Triangular(
        t1.a - t2.c, 
        t1.b - t2.b, 
        t1.c - t2.a
    )
end 

function Base.:(==)(t1::Triangular, t2::Triangular)::Bool
    return isequal(t1, t2)
end 


function Base.isequal(t1::Triangular, t2::Triangular)::Bool
    return (t1.a == t2.a) && (t1.b == t2.b) && (t1.c == t2.c)
end


function Base.:*(t1::Triangular, alpha::T) where T <: Real
    return Triangular(
        alpha * t1.a,
        alpha * t1.b,
        alpha * t1.c 
    )
end 

function Base.:*(alpha::T, t1::Triangular) where T <: Real
    return t1 * alpha
end 

function Base.inv(t::Triangular)::Triangular
    return Triangular(
        inv(t.c), 
        inv(t.b),
        inv(t.a)
    )
end 

function Base.:*(t1::Triangular, t2::Triangular)::Triangular
    return Triangular(
        t1.a * t2.a, 
        t1.b * t2.b, 
        t1.c * t2.c
    )
end 

function Base.:/(t1::Triangular, t2::Triangular)::Triangular
    return Triangular(
        t1.a / t2.c, 
        t1.b / t2.b, 
        t1.c / t2.a
    )
end 
