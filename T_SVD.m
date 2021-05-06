function [  ] = T_SVD( L, J, k )
% L = tensor(images are lateral slices)
M = tensor_mean(L);
A = StdDevTensor(L, M);
[S, U1, U2, U3 ] = HOSVD( A )


end

