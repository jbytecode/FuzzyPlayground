mutable struct Trapezodial <: FuzzyNumber
    a
    b
    c
    d
end

function Base.:+(t1::Trapezodial, t2::Trapezodial)::Trapezodial
    return Trapezodial(
        t1.a + t2.a,
        t1.b + t2.b,
        t1.c + t2.c,
        t1.d + t2.d
    )
end

# (a1 − d2 , b1 − c2 , c1 − b2 , d1 − a2 )
function Base.:-(t1::Trapezodial, t2::Trapezodial)::Trapezodial
    return Trapezodial(
        t1.a - t2.d,
        t1.b - t2.c,
        t1.c - t2.b,
        t1.d - t2.a
    )
end


function Base.:(==)(t1::Trapezodial, t2::Trapezodial)::Bool
    return isequal(t1, t2)
end


function Base.isequal(t1::Trapezodial, t2::Trapezodial)::Bool
    return (t1.a == t2.a) && (t1.b == t2.b) && (t1.c == t2.c) && (t1.d == t2.d)
end


function Base.:*(t1::Trapezodial, alpha::T) where T <: Real
    return Trapezodial(
        alpha * t1.a,
        alpha * t1.b,
        alpha * t1.c,
        alpha * t1.d 
    )
end 

function Base.:*(alpha::T, t1::Trapezodial) where T <: Real
    return t1 * alpha
end 

function Base.inv(t::Trapezodial)::Trapezodial
    return Trapezodial(
        inv(t.d),
        inv(t.c), 
        inv(t.b),
        inv(t.a)
    )
end 


function Base.:*(t1::Trapezodial, t2::Trapezodial)::Trapezodial
    return Trapezodial(
        t1.a * t2.a, 
        t1.b * t2.b, 
        t1.c * t2.c,
        t1.d * t2.d 
    )
end 


function Base.:/(t1::Trapezodial, t2::Trapezodial)::Trapezodial
    return Trapezodial(
        t1.a / t2.d, 
        t1.b / t2.c, 
        t1.c / t2.b, 
        t1.d / t2.a
    )
end 