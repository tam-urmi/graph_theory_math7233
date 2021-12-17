function [ part1,part2] = find2partition( A )
% finds the spectral 2-way partition of a graph given by adjacency matrix A
n = size(A, 1);
for i=1:n
    deg(i) = sum(A(i, :));
end
D = diag(deg);
L = D - A;
NL = inv(D)*L;

[eVec,eVal] = eigs(NL, n);
[sorted_eVal,permutation]=sort(diag(eVal));
eVal=eVal(permutation,permutation);
eVec=eVec(:,permutation);
y = eVec(:,2);
[sorted_y, sorted_nodes] = sort(y);

all_phi = [];
for k = 1:n-1
    s = sorted_nodes(1:k);
    vs = sorted_nodes(k+1:n);
    phi = find_conductance(s, vs, A, D);
    all_phi = [all_phi, phi];
end
min_phi = min(all_phi);
j = find(all_phi == min_phi)

part1 = sorted_nodes(1:j)
part2 = sorted_nodes(j+1:n)


function [phi] = find_conductance(s, vs, A, D)
    esum = sum(sum(A(s,vs)));
    deg_s = sum(sum(D(s,s)));
    deg_vs = sum(sum(D(vs,vs)));
    phi = esum/(min(deg_s, deg_vs));
end
end
