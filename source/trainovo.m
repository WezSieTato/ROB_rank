function [ovocls ovoerr] = trainovo(tvec, tlab, trainrep = 10)
%
% tvec - zbiór uczący ( próbka == wiesz)
% tlab - wektor etykiet próbek w zbiorze uczącym
% ovocls - zespół klasyfikatorów liniowych:
%		pierwsza kolumna zawiera etykietę klasy po dodatniej stronie płaszczyzny
%		druga kolumna zawiera etykietę klasy po ujemnej stronie płaszczyzny
% 		kolumny 3 : end - współczynniki płaszczyzny separującej

	labels = unique(tlab);
	pairs = nchoosek(labels, 2);
	ovocls = zeros(rows(pairs), 2 + 1 + columns(tvec));
	
	seppl = zeros( trainrep, 1 + columns(tvec));
	errcf = zeros( trainrep, 1 );

	for cls = 1:rows(pairs)
		ovocls(cls, 1:2) = pairs( cls, :);
		posidx = tlab == pairs(cls, 1);
		negidx = tlab == pairs(cls, 2);
		
		for rep = 1:trainrep
			[seppl(rep, :) errcf(rep)] = trainlc(tvec(posidx, :), tvec(negidx, :), trainrep);
		end

		[minerr minidx] = min(errcf);
		ovoerr(cls) = minerr;
		ovocls(cls, 3:end) = seppl(minidx, :);
		
	end