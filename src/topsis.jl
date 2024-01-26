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

function fuzzytopsis(
    decmat::Matrix{FuzzyType},
    w::Vector{FuzzyType},
    fns,
)::FuzzyTopsisResult where FuzzyType <: FuzzyNumber

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
        if fns[j] == maximum
            bestideal[j] = Triangular(maxc, maxc, maxc)
            worstideal[j] = Triangular(mina, mina, mina)
        elseif fns[j] == minimum
            worstideal[j] = Triangular(maxc, maxc, maxc)
            bestideal[j] = Triangular(mina, mina, mina)
        else
            error("fns[i] should be either minimum or maximum, but $(fns[j]) found.")
        end
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
