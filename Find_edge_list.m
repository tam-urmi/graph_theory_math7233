function edge_list = Find_edge_list(A)
% A is the adjacency matrix
edge_list = cell(1, length(A));
for i = 1:length(A)
    ind_list = []; % empty array to put index of 1s -> edges
    ind = find(A(i, :) == 1); % find indices where cell value is 1
    ind_list = [ind_list, ind]; % append to the empty list
    edge_list{1,i} = ind_list;
end
end
