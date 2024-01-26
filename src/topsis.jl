mutable struct FuzzyTopsisResult
	decmat::Any
	normalized_decmat::Any
	weighted_normalized_decmat::Any
    bestideal
    worstideal
    sminus
    splus
    scores
end

function fuzzytopsis(decmat::Matrix{Triangular}, w::Vector{Triangular}, fns)::FuzzyTopsisResult

	n, p = size(decmat)

	normalized_mat = similar(decmat)
    weightednormalized_mat = similar(decmat)

	for j in 1:p
		if fns[j] == maximum
			cvalues = map(trg -> trg.c, decmat[:, j])
			colmax = maximum(cvalues)
			normalized_mat[:, j] = decmat[:, j] ./ colmax
		elseif fns[j] == minimum
			avalues = map(trg -> trg.a, decmat[:, j])
			colmin = minimum(avalues)
			normalized_mat[:, j] = colmin ./ decmat[:, j]
		else
			error("fns[i] should be either minimum or maximum, but $(fns[j]) found.")
		end
	end

    for j in 1:p
        weightednormalized_mat[:, j] = w[j] .* normalized_mat[:, j]
    end 

    bestideal = zeros(eltype(decmat), p)
    worstideal = zeros(eltype(decmat), p)

    for j in 1:p
        maxc = maximum(map(x -> x.c, weightednormalized_mat[:, j]))
        mina = minimum(map(x -> x.a, weightednormalized_mat[:, j]))
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
    for i in 1:n
        distance_to_ideal[i] = euclidean.(weightednormalized_mat[i, :], bestideal) |> sum
        distance_to_worst[i] = euclidean.(weightednormalized_mat[i, :], worstideal) |> sum
    end 

    scores = zeros(Float64, n)
    for i in 1:n
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
        scores
	)

	return result
end
