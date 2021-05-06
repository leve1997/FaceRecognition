function M = tensor_mean(A)
M = zeros(size(A,1), size(A,3));
for j = 1:size(A,2)
    M = M + squeeze(A(:,j,:));
end
M = M./size(A,2);
end

