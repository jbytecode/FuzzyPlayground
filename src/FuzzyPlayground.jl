module FuzzyPlayground

import Statistics # :)

export FuzzyNumber, Triangular, Trapezodial
export euclidean
export observe
export arity
export fuzzytopsis
export fuzzydecmat, prepare_weights, prepare_decmats


include("fuzzynumber.jl")
include("triangularfuzzynumber.jl")
include("trapezodialfuzzynumber.jl")
include("topsis.jl")

end
