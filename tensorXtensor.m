function C = tensorXtensor(A, B)
% provjera dimenzija
% size(A) = l x p x n, size(B) = p x m x n
if (size(A, 2) ~= size(B, 1) || size(A, 3) ~= size(B, 3))
    disp('Pogresne dimenzije! Nesto si zeznuo');
    return;
end

AA = fft(A, [], 3);
BB = fft(B, [], 3);
C = zeros(size(A,1), size(B,2), size(A,3));

for i = 1:size(B, 3)
    C(:,:,i) = AA(:,:,i) * BB(:,:,i);
end
C = ifft(C, [], 3);
end

