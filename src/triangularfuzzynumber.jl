mutable struct Triangular <: FuzzyNumber
	a::Any
	b::Any
	c::Any
end

function Base.:+(t1::Triangular, t2::Triangular)::Triangular
	return Triangular(
		t1.a + t2.a,
		t1.b + t2.b,
		t1.c + t2.c,
	)
end

# a1 − c2 , b1 − b2 , c1 − a2
function Base.:-(t1::Triangular, t2::Triangular)::Triangular
	return Triangular(
		t1.a - t2.c,
		t1.b - t2.b,
		t1.c - t2.a,
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
		alpha * t1.c,
	)
end

function Base.:*(alpha::T, t1::Triangular) where T <: Real
	return t1 * alpha
end

function Base.inv(t::Triangular)::Triangular
	return Triangular(
		inv(t.c),
		inv(t.b),
		inv(t.a),
	)
end

function Base.:*(t1::Triangular, t2::Triangular)::Triangular
	return Triangular(
		t1.a * t2.a,
		t1.b * t2.b,
		t1.c * t2.c,
	)
end

function Base.:/(t1::Triangular, t2::Triangular)::Triangular
	return Triangular(
		t1.a / t2.c,
		t1.b / t2.b,
		t1.c / t2.a,
	)
end

function Base.:/(t1::Triangular, alpha::T) where T <: Real
	return t1 * inv(alpha)
end

function Base.:/(alpha::T, t1::Triangular) where T <: Real
	return alpha * inv(t1)
end

function Base.isapprox(t1::Triangular, t2::Triangular; atol::Float64)
	return (isapprox(t1.a, t2.a, atol = atol)
			&& isapprox(t1.b, t2.b, atol = atol)
			&& isapprox(t1.c, t2.c, atol = atol))
end

function Base.length(::Triangular)::Int64 
    return 1
end 

Base.broadcastable(t::Triangular) = Ref(t)

function Base.zero(::Type{Triangular})::Triangular
    return Triangular(0.0, 0.0, 0.0)
end 


function Base.iterate(t::Triangular, state = 1)
	if state == 1
		(t.a, state + 1)
	elseif state == 2
		(t.b, state + 1)
    elseif state == 3
        (t.c, state + 1)
    else 
		nothing
	end
end

function euclidean(t1::Triangular, t2::Triangular)::Float64
	return sqrt((1 / 3) * ((t1.a - t2.a)^2 + (t1.b - t2.b)^2 + (t1.c - t2.c)^2))
end


function euclidean(t1::Triangular)::Float64
	origin = Triangular(0.0, 0.0, 0.0)
	return euclidean(origin, t1)
end

