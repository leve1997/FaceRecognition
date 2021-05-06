function [ A ] = StdDevTensor( L, M )
% L = tensor(images are lateral slices), M = mean image
    for j=1:size(L,2)
        L(:,j,:) = twist(squeeze(L(:,j,:)) - M, 2);
    end
end

