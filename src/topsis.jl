mutable struct FuzzyTopsisResult
	decmat::Any
	normalized_decmat::Any
	weighted_normalized_decmat::Any
end

function fuzzytopsis(decmat, w, fns)::FuzzyTopsisResult

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


	result = FuzzyTopsisResult(
		decmat,
		normalized_mat,
		weightednormalized_mat,
	)

	return result
end
