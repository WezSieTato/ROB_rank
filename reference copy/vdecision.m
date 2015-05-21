function lab = vdecision(votes)
% Decyzja 

threshold = columns(votes) - 1;
reject = columns(votes) + 1;
[mv lab] = max(votes, [], 2);
lab(mv != threshold) = reject;