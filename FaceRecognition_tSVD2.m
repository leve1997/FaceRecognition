function [ ] = FaceRecognition_tSVD1( TA, TJ, ks, exactTrain, exactTest )
% Face recognition algorithm using t-SVD, algorithm 2
% T = tensor, J = test image, k = truncation index
% minInd = index of most similiar image

% size of 3rd dimension
n = size(TA, 3)
N = size(TA, 2);
M = tensor_mean(TA);
A = StdDevTensor(TA, M);
U = T_SVD(TA, ks);
for i = 1:n
    U(:,:,i) = U(:,:,i) * dftmtx(ks);
end
% frontal face SVDs of A
A_i = cell(n/2 + 1, 1);
q = [];
for i = 1:n/2 + 1
    [~,A_i{i, 1},~] = svd(squeeze(A(:,:,i)) * dftmtx(N));
    q = [q; diag(A_i{i,1})];
end

%truncation indices
q = sort(q, 'descend');
nrm = tensorNormF(A(:,:,1:n/2+1));
t = find_index_t(q, nrm * nrm * 0.9);
k_i = zeros(n/2+1,1);
for i = 1:n/2 + 1
   k_i(i) = truncation_indices(diag(A_i{i,1}), q(t));
   k_i(i) = 16;
end
% c = zeros(ks, N, n/2 + 1);
for i = 1:n/2 + 1
    for t = 1:k_i(i)
        for j = 1:N
           c(t,j,i) = U(:,t,i)' * A_i{i,1}(:,j);
        end
    end
end

noTests = max(size(exactTest));
correct = 0;
for test = 1:noTests
    T = twist(squeeze(TJ(:,test,:))-M, 2);
    T(:,1,:) = squeeze(T(:,1,:)) * dftmtx(n);
    for i = 1:n/2 + 1
        for t = 1:k_i(i)
            b(t,i) = U(:,t,i)' * T(:,1,i);
        end
    end
    min_norm = realmax; min_ind = 0;
    for j = 1:N
        nrm = norm(b-squeeze(c(:,j,:)), 'fro');
        if nrm < min_norm
            min_norm = nrm;
            min_ind = j;
        end
    end
    if exactTest(test) == exactTrain(min_ind)
        correct = correct + 1;
    end
end
disp(correct / noTests)
end

function t = find_index_t(q, val)
    sum = 0;
    for i = 1:max(size(q))
        sum = sum + q(i) * q(i);
        if sum > val
            t = i;
            break;
        end
    end
end
function i = truncation_indices(s, val)
    i = 1;
    while s(i) > val && i < max(size(s))
        i = i + 1;
    end
end

