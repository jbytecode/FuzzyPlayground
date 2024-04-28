mutable struct FuzzyEdasResult
    w::Vector
    decmat::Matrix
    fns::Vector
    defuzmatrix::Matrix
    pda::Matrix 
end


mean(x) = sum(x) / length(x)

function fuzzyedas(decmat::Matrix{Triangular}, w::Vector{Triangular}, fns)

    n, p = size(decmat)

    defuzmatrix = zeros(Float64, n, p)

    for i = 1:n
        for j = 1:p
            defuzmatrix[i, j] = (decmat[i, j].a  + decmat[i, j].b + decmat[i, j].c) / 3
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
            amean = map(x -> x.a, decmat[:, j]) |> mean
            bmean = map(x -> x.b, decmat[:, j]) |> mean
            cmean = map(x -> x.c, decmat[:, j]) |> mean
            if avgdefuz[j] > defuzmatrix[i, j] 
                a = (decmat[i, j].a  - amean) / avgdefuz[j]
                b = (decmat[i, j].b  - bmean) / avgdefuz[j]
                c = (decmat[i, j].c  - cmean) / avgdefuz[j]
                pda[i, j] = Triangular(sort([a, b, c]))
            else
               pda[i, j] = Triangular(0, 0, 0)
            end
        end 
    end 



    edasresult = FuzzyEdasResult(w, decmat, fns, defuzmatrix, pda)
end 