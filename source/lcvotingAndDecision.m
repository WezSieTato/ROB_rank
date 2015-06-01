function lab = lcvotingAndDecision(ovocls, samples)
% Zlicza głosy oddane przez klasyfikatory z zespołu ovocls,
% a nastepnie podejmuje decyzje klasyfikacji
% ovocls - zespół klasyfikatorów liniowych:
%		pierwsza kolumna zawiera etykietę klasy po dodatniej stronie płaszczyzny
%		druga kolumna zawiera etykietę klasy po ujemnej stronie płaszczyzny
% 		kolumny 3 : end - współczynniki płaszczyzny separującej
% votes - macierz głosowania (wiersze - probki z samples, kolumny - etykiety klas
% lab - wektor klas sklasyfikowanych poprzez glosowanie

labels = unique(ovocls(:, 1:2));
votes = zeros(rows(samples), rows(labels));
augument = ones(rows(samples), 1);
	
	for cls = 1:rows(ovocls)
		posidx = [augument samples] * ovocls(cls, 3:end)' > 0;
		votes(posidx, ovocls(cls,1)) += 1;
		votes(!posidx, ovocls(cls,2)) += 1;
	end
	
[mv lab] = max(votes, [], 2);
oneCount = sum(votes == mv, 2);

	for it = 1 : rows(oneCount)

		if(oneCount(it) > 1)
		
			pos = find( votes(it, :) == mv(it));
			pairs = nchoosek(pos, 2);
			
			for p = 1 : rows(pairs)
			
				ovo = ovocls(all (bsxfun (@eq, ovocls(:,1:2), pairs(p, :)), 2), 3:end);
				pp = [1 samples(it, :)] * ovo' > 0;
				votes(it, ovocls(cls,1)) += pp;
				votes(it, ovocls(cls,2)) += !pp;

			end
		
		endif

	end

[mv lab] = max(votes, [], 2);
