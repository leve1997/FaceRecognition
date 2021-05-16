function [ U ] = T_SVD( M, k )
% M = tensor(images are lateral slices)
M = fft(M,[],3);
U = zeros(size(M,1),k,size(M,3));
for i = 1:size(M,3);
    [UU,~,~] = svds(M(:,:,i), k);
    U(:,:,i) = UU;
end
U = ifft(U, [], 3);
end
