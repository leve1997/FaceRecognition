function [ ] = FaceRecognition_tSVD1( TA, TJ, ks, exactTrain, exactTest )
% Face recognition algorithm using t-SVD, algorithm 2
% T = tensor, J = test image, k = truncation index
% minInd = index of most similiar image

% size of 3rd dimension
n = size(TA, 3);
N = size(TA, 2);
M = tensor_mean(TA);
A = StdDevTensor(TA, M);
U = T_SVD(TA, ks);
% frontal face SVDs of A
A_i = cell(n/2 + 1, 1);
for i = 1:n/2 + 1
    A_i{i, 1} = svd(squeeze(A(:,:,i)));
end

% for i = 1:n/2 + 1
%     for t = 1:k
%         for j = 1:N
%            c(t,j,i) = U(:,t,i)' * A_i{i,1}(:,j);
%         end
%     end
% end
% noTests = max(size(exactTest));
% %b = cell(noTests, 1);
% for tests = 1:noTests
%     T = twist(squeeze(TJ(:,tests,:)-M, 2));
%     for i = 1:n/2 + 1
%         for t = 1:k
%             b(t,i) = U(:,t,i)' * T(:,1,i);
%         end
%     end
%     for j = 1:N
%         nrm = norm(b-squeeze(c(:,j,:), 'fro'));
%     end
% end  
% end

