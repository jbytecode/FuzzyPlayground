struct FuzzyTopsisResult
    decmat::Matrix
    normalized_decmat::Matrix
    weighted_normalized_decmat::Matrix
    bestideal::Vector
    worstideal::Vector
    sminus::Vector
    splus::Vector
    scores::Vector
end


function summarizecolumn(v::Vector{FuzzyType})::FuzzyType where {FuzzyType<:FuzzyNumber}
    p = arity(FuzzyType)
    vals = zeros(Float64, p)
    vals[1] = map(fnum -> fnum[1], v) |> minimum
    vals[p] = map(fnum -> fnum[p], v) |> maximum
    for i = 2:(p-1)
        vals[i] = map(fnum -> fnum[i], v) |> Statistics.mean
    end

    return FuzzyType(vals)
end

function prepare_weights(
    weightlist::Vector{Vector{FuzzyType}},
)::Vector{FuzzyType} where {FuzzyType<:FuzzyNumber}
    wmat = mapreduce(permutedims, vcat, weightlist)

    _, p = size(wmat)
    wresult = Array{FuzzyType, 1}(undef, p)
    for i = 1:p
        wresult[i] = summarizecolumn(wmat[:, i])
    end
    return wresult
end


function fuzzydecmat(
    decmatlist::Vector{Matrix{FuzzyType}}
)::Matrix{FuzzyType} where FuzzyType <: FuzzyNumber 
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


    bestideal = zeros(FuzzyType, p)
    worstideal = zeros(FuzzyType, p)


    for j = 1:p
        weightednormalized_mat[:, j] .= w[j] .* normalized_mat[:, j]
        maxLast = maximum(map(last, weightednormalized_mat[:, j]))
        minFirst = minimum(map(first, weightednormalized_mat[:, j]))
        bestideal[j] = FuzzyType(maxLast)
        worstideal[j] = FuzzyType(minFirst)
    end


    distance_to_ideal = zeros(Float64, n)
    distance_to_worst = zeros(Float64, n)
    scores            = zeros(Float64, n)

    for i = 1:n
        distance_to_ideal[i] = euclidean.(weightednormalized_mat[i, :], bestideal) |> sum
        distance_to_worst[i] = euclidean.(weightednormalized_mat[i, :], worstideal) |> sum
        scores[i] = distance_to_worst[i] /(distance_to_worst[i] + distance_to_ideal[i])
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
