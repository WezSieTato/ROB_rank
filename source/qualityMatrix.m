function [matrix] = qualityMatrix(errorMatrix, tstl)

	n = rows(tstl);
	err = sum(sum(errorMatrix(:, 1:10), 2));
	r = sum(errorMatrix(:, 11));
	
	errP = err / n;
	rP = r / n;
	
	matrix = [errP, rP , 1 - errP - rP] * 100;
