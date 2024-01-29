struct Trapezodial <: FuzzyNumber
    a::Real
    b::Real
    c::Real
    d::Real
    function Trapezodial(a, b, c, d)
        @assert a <= b <= c <= d
        new(a, b, c, d)
    end
end

function Base.:+(t1::Trapezodial, t2::Trapezodial)::Trapezodial
    return Trapezodial(t1.a + t2.a, t1.b + t2.b, t1.c + t2.c, t1.d + t2.d)
end

# (a1 − d2 , b1 − c2 , c1 − b2 , d1 − a2 )
function Base.:-(t1::Trapezodial, t2::Trapezodial)::Trapezodial
    return Trapezodial(t1.a - t2.d, t1.b - t2.c, t1.c - t2.b, t1.d - t2.a)
end


function Base.:(==)(t1::Trapezodial, t2::Trapezodial)::Bool
    return isequal(t1, t2)
end


function Base.isequal(t1::Trapezodial, t2::Trapezodial)::Bool
    return (t1.a == t2.a) && (t1.b == t2.b) && (t1.c == t2.c) && (t1.d == t2.d)
end


function Base.:*(t1::Trapezodial, alpha::T) where {T<:Real}
    return Trapezodial(alpha * t1.a, alpha * t1.b, alpha * t1.c, alpha * t1.d)
end

function Base.:*(alpha::T, t1::Trapezodial) where {T<:Real}
    return t1 * alpha
end

function Base.inv(t::Trapezodial)::Trapezodial
    return Trapezodial(inv(t.d), inv(t.c), inv(t.b), inv(t.a))
end


function Base.:*(t1::Trapezodial, t2::Trapezodial)::Trapezodial
    return Trapezodial(t1.a * t2.a, t1.b * t2.b, t1.c * t2.c, t1.d * t2.d)
end


function Base.:/(t1::Trapezodial, t2::Trapezodial)::Trapezodial
    return Trapezodial(t1.a / t2.d, t1.b / t2.c, t1.c / t2.b, t1.d / t2.a)
end


function Base.:/(t1::Trapezodial, alpha::T) where {T<:Real}
    return t1 * inv(alpha)
end

function Base.:/(alpha::T, t1::Trapezodial) where {T<:Real}
    return alpha * inv(t1)
end

function Base.isapprox(t1::Trapezodial, t2::Trapezodial; atol::Float64)
    return (
        isapprox(t1.a, t2.a, atol = atol) &&
        isapprox(t1.b, t2.b, atol = atol) &&
        isapprox(t1.c, t2.c, atol = atol) &&
        isapprox(t1.d, t2.d, atol = atol)
    )
end

function Base.length(::Trapezodial)::Int64
    return 1
end

Base.broadcastable(t::Trapezodial) = Ref(t)

function Base.zero(::Type{Trapezodial})::Trapezodial
    return Trapezodial(0.0, 0.0, 0.0, 0.0)
end

function Base.one(::Type{Trapezodial})::Trapezodial
    return Trapezodial(1.0, 1.0, 1.0, 1.0)
end

function Base.zeros(::Type{Trapezodial}, n::Int64)::Vector{Trapezodial}
    return [zero(Trapezodial) for i = 1:n]
end


function Base.iterate(t::Trapezodial, state = 1)
    if state == 1
        (t.a, state + 1)
    elseif state == 2
        (t.b, state + 1)
    elseif state == 3
        (t.c, state + 1)
    elseif state == 4
        (t.d, state + 1)
    else
        nothing
    end
end

function Base.first(t::Trapezodial)
    return t.a
end

function Base.last(t::Trapezodial)
    return t.d
end

function euclidean(t1::Trapezodial, t2::Trapezodial)::Float64
    return sqrt(
        (1 / 4) * ((t1.a - t2.a)^2 + (t1.b - t2.b)^2 + (t1.c - t2.c)^2 + (t1.d - t2.d)^2),
    )
end

function euclidean(t1::Trapezodial)::Float64
    origin = Trapezodial(0.0, 0.0, 0.0, 0.0)
    return euclidean(origin, t1)
end


function observe(t::Trapezodial, x::XType)::Float64 where {XType<:Real}
    if x < t.a
        return zero(eltype(x))
    elseif t.a <= x < t.b
        return (x - t.a) / (t.b - t.a)
    elseif t.b <= x < t.c
        return one(eltype(x))
    elseif t.c <= x < t.d
        return (t.d - x) / (t.d - t.c)
    else
        return zero(eltype(x))
    end
end

function arity(::Type{Trapezodial})::Int64
    return 4
end

function Base.getindex(t::Trapezodial, i::Int64)
    if i == 1
        return t.a
    elseif i == 2
        return t.b
    elseif i == 3
        return t.c
    elseif i == 4
        return t.d
    else
        error("Index out of bounds for Trapezodial: $i")
    end
end


Base.rand(::Type{Trapezodial}) = Trapezodial(sort(rand(4))...)

Base.rand(::Type{Trapezodial}, i::Int64)=[Trapezodial(sort(rand(4))...) for _ in 1:i]

function Base.rand(::Type{Trapezodial}, i::Int64, j::Int64)
    m = Array{Trapezodial, 2}(undef, i, j)
    for a in 1:i
        for b in 1:j 
            m[a, b] = rand(Trapezodial)
        end 
    end 
    return m
end 