function loadfuzzydata(filename::String, type::Type{FuzzyType}; delim = ',') where {FuzzyType <: FuzzyNumber}

	rawdata = DelimitedFiles.readdlm(
		filename,
		delim)

	typearity = arity(type)
	n, p = size(rawdata)
	newp = Int(p / typearity)


	mat = Array{type, 2}(undef, n, newp)

	for i in 1:n
		pindex = 1
		for j in 1:typearity:(p-typearity+1)
			values = rawdata[i, j:(j+typearity-1)]
			mat[i, pindex] = FuzzyType(values)
			pindex += 1
		end
	end
	return mat
end
