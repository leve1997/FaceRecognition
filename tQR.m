function [Q] = tQR(A)
% Tensor QR
[d1,d2,d3] = size(A);
[Qt,~,~] = qr(reshape(A,[d1*d2,d3]),0);
Q = reshape(Qt,[d1,d2,d3]);
end

