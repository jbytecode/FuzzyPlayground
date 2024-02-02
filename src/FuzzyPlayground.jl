module FuzzyPlayground

#=
Abstract Type Definitions 
=#
abstract type FuzzyNumber end

#=
Custom Errors
=#
struct UndefinedDirectionException <: Exception 
    msg::String
end 


#=
Imported packages
=#
import Statistics # :)
import DelimitedFiles

#=
Package exports to the out of the world
=#

export UndefinedDirectionException

export FuzzyNumber, Triangular, Trapezoidal

export euclidean
export observe
export arity
export fuzzytopsis
export fuzzydecmat, prepare_weights, fuzzydecmat

export DefuzzificationMethod
export WeightedMaximum
export FirstMaximum
export LastMaximum
export MiddleMaximum
export GravityCenter
export GeometricMean
export defuzzification
export fuzzysaw
export fuzzycocoso
export loadfuzzydata

#=
Inclusions
=#
include("triangularfuzzynumber.jl")
include("trapezoidalfuzzynumber.jl")
include("groupdecision.jl")
include("defuzzification.jl")
include("topsis.jl")
include("saw.jl")
include("cocoso.jl")
include("dataloader.jl")

end
