function A = twist(A, dim)
% inverse of squeeze
n = size(A,1); m = size(A,2);
if dim == 1
    A = reshape(A,1,n,m);
elseif dim == 2
    A = reshape(A,n,1,m);
elseif dim == 3
    A = reshape(A,n,m,1);
end
end

