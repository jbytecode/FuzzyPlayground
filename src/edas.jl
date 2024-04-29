mutable struct FuzzyEdasResult
    w::Vector
    decmat::Matrix
    fns::Vector
    defuzmatrix::Matrix
    avgdefuz::Vector
    pda::Matrix
end


function fuzzyedas(decmat::Matrix{Triangular}, w::Vector{Triangular}, fns)

    n, p = size(decmat)

    defuzmatrix = zeros(Float64, n, p)

    for i = 1:n
        for j = 1:p
            defuzmatrix[i, j] = (decmat[i, j].a + decmat[i, j].b + decmat[i, j].c) / 3
        end
    end

    avgdefuz = zeros(Float64, p)
    for j = 1:p
        avgdefuz[j] = sum(defuzmatrix[:, j]) / n
    end

    pda = zeros(Triangular, n, p)
    nda = zeros(Triangular, n, p)
    
    for i in 1:n
        for j in 1:p
            amean = map(x -> x.a, decmat[:, j]) |> Statistics.mean
            bmean = map(x -> x.b, decmat[:, j]) |> Statistics.mean
            cmean = map(x -> x.c, decmat[:, j]) |> Statistics.mean
            if fns[j] == maximum
                if avgdefuz[j] <= defuzmatrix[i, j]
                    a = (decmat[i, j].a - cmean) / avgdefuz[j]
                    b = (decmat[i, j].b - bmean) / avgdefuz[j]
                    c = (decmat[i, j].c - amean) / avgdefuz[j]
                    pda[i, j] = Triangular(sort([a, b, c]))
                else
                    pda[i, j] = Triangular(0, 0, 0)
                end
            elseif fns[j] == minimum 
                if avgdefuz[j] <= defuzmatrix[i, j]
                    pda[i, j] = Triangular(0, 0, 0)
                else
                    a = (amean - decmat[i, j].c) / avgdefuz[j]
                    b = (bmean - decmat[i, j].b) / avgdefuz[j]
                    c = (cmean - decmat[i, j].a) / avgdefuz[j]
                    pda[i, j] = Triangular(sort([a, b, c]))
                end
            else
                error("Unsupported function: $(fns[p])")
            end
        end
    end



    edasresult = FuzzyEdasResult(w, decmat, fns, defuzmatrix, avgdefuz, pda)
    return edasresult
end