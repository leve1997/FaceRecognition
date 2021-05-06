function A_t = tensor_transpose(A)
l = size(A, 1); m = size(A, 2); n = size(A, 3);
A_t = zeros(m,l,n);
A_t(:,:,1) = A(:,:,1)';
for i = 2:n
    A_t(:,:,n-i+2) = A(:,:,i)';
end
end

