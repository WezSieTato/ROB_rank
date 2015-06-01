function [splane errcf] = trainlc(posclass, negclass, maxiter = 25)

	splane = rand(1, columns(posclass) +1) - 0.5;
	
	train = [ones(rows(posclass), 1) posclass; -ones(rows(negclass), 1), -negclass];

	for iter = 1 : maxiter

		misclidx = train * splane' <= 0;
	%	sum(misclidx)
		grad = sum(train( misclidx, : ), 1);
		splane = splane + grad;
	end
	
	misclidx = train * splane' <= 0;
	errcf = sum(misclidx) / rows(train)
		
