function [ norma ] = tensorNormF( T )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%norma = 0;
% for i = 1:size(T,1)
%     for j = 1:size(T,2)
%         for k = 1:size(T,3)
%             norma = norma + T(i,j,k)*T(i,j,k);
%         end
%     end
% end
% norma = sqrt(norma);
norma = norm(reshape(T,[size(T,1)*size(T,3),size(T,2)]),'fro');
end

