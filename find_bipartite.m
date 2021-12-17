function [ answer ] = Find_bipartite( A )
% Decide whether the graph with adjacency matrix A is bipartite or not
edge_list = Find_edge_list(A);
    forest = Find_BFS_forest(A);
    colors = zeros(1, length(A));
    answer = [];
    path = [];
    visited = false(1, length(edge_list));
    odd_cycle_fnd = false;
    for i = 1:length(forest)
            connected = forest(1, forest(2,:) == forest(1, i));
            for j = 1:length(connected)
                if colors(forest(1, i)) == 0
                    colors(connected(j)) = 1;
                else
                    colors(connected(j)) = 0;
                end
            end
    end
    for k = 1:length(edge_list)
        if not(isempty(edge_list{k, 1}))
            for l = 1:length(edge_list{k, 1})
                if colors(k) == colors(edge_list{k, 1}(l))
                    answer = dfs(k, edge_list{k, 1}(l), visited, path);
                    return;
                else
                    answer = colors;
                end
            end
        end
    end
    function path = dfs(source, target, visited, path)
        visited(source) = true;
        path = [path source];
        if source == target
            if rem(length(path), 2) == 1
                odd_cycle_fnd = true;
                return;
            end
        else
            for n = 1:length(edge_list{source, 1})
                if visited(edge_list{source, 1}(n)) == false
                    path = dfs(edge_list{source, 1}(n), target, visited, path);
                    if odd_cycle_fnd == true
                        return;
                    end
                end
            end
        end
        if length(path) > 1
            path(path == source) = [];
        end  
        visited(source) = false;
    end
end
