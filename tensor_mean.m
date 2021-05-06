function M = tensor_mean(A)
M = zeros(size(A,1), size(A,3));
for i = size(A,3):-1:1
    M(:,i) = mean(A(:,:,i));
end
end

