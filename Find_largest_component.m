function [ comp_list ] = Find_largest_component( A )
% A is the adjacency matrix

forest = Find_BFS_forest(A)
n = length(forest);
comp_nodes = find(forest(2, :) == 0);
comp_arr = cell(length(comp_nodes), 1);
comp_len = [];
for i = 1:length(comp_nodes)
    ch = comp_nodes(i);
    if i == length(comp_nodes)
        ct = n;
    elseif i+1 <= length(comp_nodes)
        ct = comp_nodes(i+1)-1;
    end
    comp_arr{i} = sort(forest(1, ch:ct));
    comp_len(end+1) = length(forest(1, ch:ct));
end

lc = find(comp_len==max(comp_len));
comp_lc = comp_arr{lc};
comp_list = sort(comp_lc)

end
