mutable struct FuzzyEdasResult
    w::Vector
    decmat::Matrix
    fns::Vector
    defuzmatrix::Matrix
    avgdefuz::Vector
    pda::Matrix
    nda::Matrix
    wpda::Matrix 
    wnda::Matrix
    sp::Vector
    sn::Vector
    sp_defuz::Vector
    sn_defuz::Vector
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
    wpda = zeros(Triangular, n, p)
    wnda = zeros(Triangular, n, p)
    sp = zeros(Triangular, n)
    sn = zeros(Triangular, n) 
    sp_defuz = zeros(Float64, n)
    sn_defuz = zeros(Float64, n)
    
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
                    nda[i, j] = Triangular(0, 0, 0)
                else
                    a = (amean - decmat[i, j].c) / avgdefuz[j]
                    b = (bmean - decmat[i, j].b) / avgdefuz[j]
                    c = (cmean - decmat[i, j].a) / avgdefuz[j]
                    nda[i, j] = Triangular(sort([a, b, c]))
                    pda[i, j] = Triangular(0, 0, 0)
                end
            elseif fns[j] == minimum 
                if avgdefuz[j] <= defuzmatrix[i, j]
                    a = (decmat[i, j].a - cmean) / avgdefuz[j]
                    b = (decmat[i, j].b - bmean) / avgdefuz[j]
                    c = (decmat[i, j].c - amean) / avgdefuz[j]
                    nda[i, j] = Triangular(sort([a, b, c]))
                    pda[i, j] = Triangular(0, 0, 0)
                else
                    a = (amean - decmat[i, j].c) / avgdefuz[j]
                    b = (bmean - decmat[i, j].b) / avgdefuz[j]
                    c = (cmean - decmat[i, j].a) / avgdefuz[j]
                    pda[i, j] = Triangular(sort([a, b, c]))
                    nda[i, j] = Triangular(0, 0, 0)
                end 
            else
                error("Unsupported function: $(fns[p])")
            end
        end
    end

    # Weighted PDA and NDA
    for i in 1:n
        for j in 1:p
            wpda[i, j] = Triangular(w[j].a * pda[i, j].a, w[j].b * pda[i, j].b, w[j].c * pda[i, j].c)
            wnda[i, j] = Triangular(w[j].a * nda[i, j].a, w[j].b * nda[i, j].b, w[j].c * nda[i, j].c)
        end 
    end 

    # SP and SN 
    for i in 1:n
        a = sum(map(x -> x.a, wpda[i, :]))
        b = sum(map(x -> x.b, wpda[i, :]))
        c = sum(map(x -> x.c, wpda[i, :]))
        sp[i] = Triangular(a, b, c)

        a = sum(map(x -> x.a, wnda[i, :]))
        b = sum(map(x -> x.b, wnda[i, :]))
        c = sum(map(x -> x.c, wnda[i, :]))
        sn[i] = Triangular(a, b, c)
    end 

    # SP defuz and NP defuz
    for i in 1:n 
        sp_defuz[i] = (sp[i].a + sp[i].b + sp[i].c) / 3
        sn_defuz[i] = (sn[i].a + sn[i].b + sn[i].c) / 3 
    end 


    edasresult = FuzzyEdasResult(w, decmat, fns, defuzmatrix, avgdefuz, 
                pda, nda, wpda, wnda,sp,sn, sp_defuz, sn_defuz)
                
    return edasresult
end