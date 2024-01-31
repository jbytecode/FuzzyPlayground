struct FuzzyCocosoResult
    decmat::Matrix
    normalized_decmat::Matrix
    weighted_normalized_decmat::Matrix
    S::Vector 
    P::Vector
    scores::Vector
end

function calculate_ka(S::Vector{Triangular}, P::Vector{Triangular})::Vector{Triangular}
    n = length(S)
    result = Array{Triangular, 1}(undef, n)
    allpa = map(x->x.a, P)
    allpb = map(x->x.b, P)
    allpc = map(x->x.c, P)
    allsa = map(x->x.a, S)
    allsb = map(x->x.b, S)
    allsc = map(x->x.c, S)
    for i in 1:n
        result[i] = Triangular(
            (P[i].a + S[i].a) / sum(allpc .+ allsc),
            (P[i].b + S[i].b) / sum(allpb .+ allsb),
            (P[i].c + S[i].c) / sum(allpa .+ allsa)
        )
    end 
    return result
end 

function calculate_kb(S::Vector{Triangular}, P::Vector{Triangular})::Vector{Triangular}
    n = length(S)
    result = Array{Triangular, 1}(undef, n)
    min_sa = map(x->x.a, S) |> minimum 
    min_pa = map(x->x.a, P) |> minimum 
    for i in 1:n
        result[i] = Triangular(
            (S[i].a / min_sa) + (P[i].a / min_pa), 
            (S[i].b / min_sa) + (P[i].b / min_pa),
            (S[i].c / min_sa) + (P[i].c / min_pa)
            )
    end 
    return result
end 

function calculate_kc(S::Vector{Triangular}, P::Vector{Triangular}, λ::Float64)::Vector{Triangular}
    n = length(S)
    result = Array{Triangular, 1}(undef, n)
    max_sc = map(x->x.c, S) |> maximum 
    max_pc = map(x->x.c, P) |> maximum 
    denom = (λ*max_sc + (1-λ)*max_pc)
    for i in 1:n 
        result[i] = Triangular(
            (λ*S[i].a + (1-λ)*P[i].a) / denom, 
            (λ*S[i].b + (1-λ)*P[i].b) / denom, 
            (λ*S[i].c + (1-λ)*P[i].c) / denom 
        )
    end 
    return result 
end 






function fuzzycocoso(
    decmat::Matrix{FuzzyType},
    w::Vector{FuzzyType},
    fns;
    defuzzificationmethod::DefuzzificationMethod = WeightedMaximum(0.5),
    lambda::Float64 = 0.5
)::FuzzyCocosoResult where {FuzzyType<:FuzzyNumber}

    n, p = size(decmat)

    normalized_mat = similar(decmat)
    weightednormalized_mat = similar(decmat)

    for j = 1:p
        maxc = map(last, decmat[:]) |> maximum 
        mina = map(first, decmat[:]) |> minimum 
        for i = 1:n
            if fns[j] == maximum
                a = (decmat[i, j].a - mina)/(maxc - mina)
                b = (decmat[i, j].b - mina)/(maxc - mina)
                c = (decmat[i, j].c - mina)/(maxc - mina)
                normalized_mat[i, j] = Triangular(a, b, c)
            elseif fns[j] == minimum
                a = (maxc - decmat[i, j].c)/(maxc - mina)
                b = (maxc - decmat[i, j].b)/(maxc - mina)
                c = (maxc - decmat[i, j].a)/(maxc - mina)
                normalized_mat[i, j] = Triangular(a, b, c)
                # normalized_mat[:, j] = (maxc - c)/(maxc - mina)
                # normalized_mat[:, j] = (maxc - b)/(maxc - mina)
                # normalized_mat[:, j] = (maxc - a)/(maxc - mina)
            else
                error("fns[i] should be either minimum or maximum, but $(fns[j]) found.")
            end
        end 
    end


    scoreMat = similar(normalized_mat)
    for i = 1:p
        scoreMat[:, i] = normalized_mat[:, i] .^ w[i]
    end

    P = Vector{FuzzyType}(undef, n)
    for i = 1:n
        P[i] = sum(scoreMat[i, :])
    end


    for j = 1:p
        weightednormalized_mat[:, j] .= w[j] .* normalized_mat[:, j]
    end

    S = Vector{FuzzyType}(undef, n)
    for i in 1:n
        S[i] = sum(weightednormalized_mat[i, :])
    end 
    
    scoreTable = [S P]

    # kA = (S .+ P) ./ sum(scoreTable)
    kA = calculate_ka(S, P)

    #kB = (S ./ minimum(S)) .+ (P ./ minimum(P))
    kB = calculate_kb(S, P)

    #kC =
    #    ((lambda .* S) .+ ((1 - lambda) .* P)) ./
    #    ((lambda .* maximum(S)) .+ ((1 - lambda) * maximum(P)))
    kC = calculate_kc(S, P, lambda)

    fa = map(x-> (x.a + x.b + x.c) / 3.0, kA)
    fb = map(x-> (x.a + x.b + x.c) / 3.0, kB)
    fc = map(x-> (x.a + x.b + x.c) / 3.0, kC)
    # scores = (kA .+ kB .+ kC) ./ 3 .+ (kA .* kB .* kC) .^ (1 / 3)
    scores = ((fa .+ fb .+ fc) ./ 3) .+ ((fa .* fb .* fc) .^ (1 / 3))

    return FuzzyCocosoResult(
        decmat,
        normalized_mat,
        weightednormalized_mat,
        S,
        P,
        scores
    )
end
