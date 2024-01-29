mutable struct FuzzyTopsisResult
    decmat::Any
    normalized_decmat::Any
    weighted_normalized_decmat::Any
    bestideal::Any
    worstideal::Any
    sminus::Any
    splus::Any
    scores::Any
end


function summarizecolumn(v::Vector{FuzzyType})::FuzzyType where {FuzzyType<:FuzzyNumber}
    fuzzytype = eltype(v)
    n = length(v)
    p = arity(fuzzytype)
    vals = zeros(Float64, p)
    vals[1] = map(fnum -> fnum[1], v) |> minimum
    vals[p] = map(fnum -> fnum[p], v) |> maximum
    for i = 2:(p-1)
        vals[i] = map(fnum -> fnum[i], v) |> Statistics.mean
    end

    return fuzzytype(vals...)
end

function prepare_weights(
    weightlist::Vector{Vector{FuzzyType}},
)::Vector{FuzzyType} where {FuzzyType<:FuzzyNumber}
    wmat = mapreduce(permutedims, vcat, weightlist)
    fuzzytype = eltype(wmat)
    n, p = size(wmat)
    wresult = Array{fuzzytype,1}(undef, p)
    for i = 1:p
        wresult[i] = summarizecolumn(wmat[:, i])
    end
    return wresult
end


function fuzzydecmat(
    decmatlist::Vector{Matrix{FuzzyType}}
)::Matrix{FuzzyType} where FuzzyType <: FuzzyNumber 
    L = length(decmatlist)
    n, p = size(decmatlist[1])
    newdecmat = similar(decmatlist[1])
    for i in 1:n 
        for j in 1:p
            v = map(x -> x[i, j], decmatlist)
            newdecmat[i, j] = summarizecolumn(v)
        end 
    end 
    return newdecmat 
end

function fuzzytopsis(
    decmat::Matrix{FuzzyType},
    w::Vector{FuzzyType},
    fns,
)::FuzzyTopsisResult where {FuzzyType<:FuzzyNumber}

    n, p = size(decmat)

    normalized_mat = similar(decmat)
    weightednormalized_mat = similar(decmat)

    for j = 1:p
        if fns[j] == maximum
            cvalues = map(last, decmat[:, j])
            colmax = maximum(cvalues)
            normalized_mat[:, j] = decmat[:, j] ./ colmax
        elseif fns[j] == minimum
            avalues = map(first, decmat[:, j])
            colmin = minimum(avalues)
            normalized_mat[:, j] = colmin ./ decmat[:, j]
        else
            error("fns[i] should be either minimum or maximum, but $(fns[j]) found.")
        end
    end

    for j = 1:p
        weightednormalized_mat[:, j] = w[j] .* normalized_mat[:, j]
    end

    bestideal = zeros(eltype(decmat), p)
    worstideal = zeros(eltype(decmat), p)

    for j = 1:p
        maxc = maximum(map(x -> last(x), weightednormalized_mat[:, j]))
        mina = minimum(map(x -> first(x), weightednormalized_mat[:, j]))
        bestideal[j] = Triangular(maxc, maxc, maxc)
        worstideal[j] = Triangular(mina, mina, mina)
        #if fns[j] == maximum
        #    bestideal[j] = Triangular(maxc, maxc, maxc)
        #    worstideal[j] = Triangular(mina, mina, mina)
        #elseif fns[j] == minimum
        #    worstideal[j] = Triangular(maxc, maxc, maxc)
        #    bestideal[j] = Triangular(mina, mina, mina)
        #else
        #    error("fns[i] should be either minimum or maximum, but $(fns[j]) found.")
        #end
    end

    distance_to_ideal = zeros(n)
    distance_to_worst = zeros(n)
    scores = zeros(Float64, n)

    for i = 1:n
        distance_to_ideal[i] = euclidean.(weightednormalized_mat[i, :], bestideal) |> sum
        distance_to_worst[i] = euclidean.(weightednormalized_mat[i, :], worstideal) |> sum
        scores[i] = distance_to_worst[i] / (distance_to_worst[i] + distance_to_ideal[i])
    end

    result = FuzzyTopsisResult(
        decmat,
        normalized_mat,
        weightednormalized_mat,
        bestideal,
        worstideal,
        distance_to_worst,
        distance_to_ideal,
        scores,
    )

    return result
end
