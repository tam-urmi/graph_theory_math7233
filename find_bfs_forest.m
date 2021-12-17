function [ forest ] = Find_BFS_forest( A )
    % edges = Find_edge_list(A)
    n=length(A);
    visited = zeros(n,1);
    % source of each node
    source =zeros(n,1);
    path =zeros(n,1); 
    start = 1;
    
    for i = 1:n
        if visited(i) == 0
            visited(i) = 1;
            q = zeros(n,1);
            q_end = 1;
            q_start = 0;
            q(q_end) = i;
            while q_end - q_start > 0
                q_start = q_start + 1;
                v = q(q_start);
                path(start) = v;
                start = start + 1;
%                 neigh_list = edges{v, 1}
%                 neigh_elem = sort(neigh_list);
%                 m = length(neigh_elem)
                for u = 1:n
                    if A(v,u)==1 && visited(u) == 0
                        q_end = q_end + 1;
                        q(q_end) = u;
                        visited(u) = 1;
                        source(u)= v;
                    end
                end
            end
        end
    end

    forest = zeros(2,n);
    for i=1:n
        forest(1,i) = path(i);
        forest(2,i) = source(path(i));
    end
end
