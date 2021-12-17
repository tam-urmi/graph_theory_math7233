function [coords] = rubber_band_embedding(A, v_pin, coords_pin)
% A is an nxn adjacency matrix, v_pin is a vector containing the ids of the pinned nodes, coords_pin is a kx2 matrix
% where the rows specify the (x,y) coordinates of each pinned node.

% coords has to be an nx2 matrix containing the coordinates for all nodes (including the pinned ones)
n = length(A);
k = length(v_pin);

ind = 1:1:n
[X,Y] = ismember(v_pin, ind);
ind(Y(X)) = [];
index = [v_pin, ind];
Id = eye(n);


%%
PermI = Id(index, :);
new_A = PermI*full(A)*PermI'

%%

for i=1:size(new_A, 1)
    D(i) = sum(new_A(i, :));
end
L = full(diag(D)) - full(new_A);
p_x = coords_pin(:, 1);
p_y = coords_pin(:, 2);

CL = L(k+1:n, 1:k);
DL = L(k+1:n, k+1:n);

q_x = -inv(DL)*CL*p_x;
q_y = -inv(DL)*CL*p_y;

q = [q_x, q_y];

C = q;
for i=1:k
    rowToInsert = v_pin(i);
    C = [C(1:rowToInsert-1, :); coords_pin(i, :); C(rowToInsert:end, :)];
end

coords = C

