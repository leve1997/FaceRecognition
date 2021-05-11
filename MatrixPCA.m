function [ rez ] = MatrixPCA( L, J, k, exactTrain, exactTest)

%% mean image
M = L(:,1);
for i = 2:size(L,2)
    M = M + L(:,i);
end
M = M./size(L,2);
%% mean-deviation
for i = 1:size(L,2)
    L(:,i) = L(:,i) - M;
end

[U,~,~] = svds(L,k);
G = U'*L;
correct = 0;
for i = 1:size(J,2)
    T = J(:,i) - M;
    c = U'*T;
    minIndex = 1;
    minRez = norm(c-G(:,1),'fro');
    for j = 2:size(G,2)
        rez = norm(c-G(:,j),'fro');
        if rez<minRez
            minRez = rez;
            minIndex = j;
        end
    end
    if exactTest(i)==exactTrain(minIndex)
        correct = correct +1;
    end
end
rez = correct/size(J,2)

end

