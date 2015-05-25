function lab = vdecision(votes)
% Decyzja 

threshold = columns(votes) - 1;
reject = columns(votes) + 1;
[mv lab] = max(votes, [], 2);

oneVotes = votes .- mv .+ 1;
oneCount = sum(oneVotes == 1, 2);



