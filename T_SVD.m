function [ U ] = T_SVD( M )
% M = tensor(images are lateral slices)
M = fft(M,[],3);
%U = zeros(size(M,2),size(M,2),size(M,3));
for i = 1:size(M,3);
    [UU,~,~] = svd(M(:,:,i));
    U(:,:,i) = UU;
end
U = ifft(U, [], 3);
end
