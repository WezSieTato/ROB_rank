function [confmx] = errorMatrix(dec, tstl)
% simple absolut majority classifier
% res - vector of decisions
% tstl - test set labels (ground truth)
% confmx - confusion matrix of the classifier


% confusion matrix filling - it should be separate function

	confmx = zeros(10, 11);
	for i=1:size(tstl,1)
		if ( dec (i) !=  tstl(i))
			confmx(tstl(i), dec(i)) += 1;
		endif
	end
