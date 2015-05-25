function votes = lcvoting(ovocls, samples)
% Zlicza głosy oddane przez klasyfikatory z zespołu ovocls
% ovocls - zespół klasyfikatorów liniowych:
%		pierwsza kolumna zawiera etykietę klasy po dodatniej stronie płaszczyzny
%		druga kolumna zawiera etykietę klasy po ujemnej stronie płaszczyzny
% 		kolumny 3 : end - współczynniki płaszczyzny separującej
% votes - macierz głosowania (wiersze - probki z samples, kolumny - etykiety klas

	labels = unique(ovocls(:, 1:2));
	votes = zeros(rows(samples), rows(labels));
	augument = ones(rows(samples), 1);
	for cls = 1:rows(ovocls)
		posidx = [augument samples] * ovocls(cls, 3:end)' > 0;
		votes(posidx, ovocls(cls,1)) += 1;
		votes(!posidx, ovocls(cls,2)) += 1;

	end