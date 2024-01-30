module FuzzyPlayground

import Statistics # :)

export FuzzyNumber, Triangular, Trapezoidal 
export euclidean
export observe
export arity
export fuzzytopsis
export fuzzydecmat, prepare_weights, prepare_decmats


include("fuzzynumber.jl")
include("triangularfuzzynumber.jl")
include("trapezoidalfuzzynumber.jl")
include("topsis.jl")

end
