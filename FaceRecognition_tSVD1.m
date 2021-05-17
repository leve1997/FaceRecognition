function [ ] = FaceRecognition_tSVD1( TA, TJ, ks, exactTrain, exactTest )
% Face recognition algorithm using t-SVD
% T = tensor, J = test image, k = truncation index
% minInd = index of most similiar image


M = tensor_mean(TA);
A = StdDevTensor(TA, M);
U = T_SVD(TA, 16);
vec_Ut = {};
vec_C = {};
for i = 1:10
    vec_Ut{i} = tensor_transpose( U(:,1:ks(i),:) );
    vec_C{i} = tensorXtensor(cell2mat(vec_Ut(i)), A);
end

noTests = max(size(exactTest));
correct = 0;
for i = 1:noTests
    U_t = cell2mat(vec_Ut(exactTest(i)+1));
    B = tensorXtensor( U_t, twist( squeeze(TJ(:,i,:))-M , 2) );
    minInd = 1;
    C = cell2mat(vec_C(exactTest(i)+1));
    minRez = tensorNormF(B - C(:,1,:));
    for j = 2:size(C,2)
        rez = tensorNormF(B - C(:,j,:));
        if(rez < minRez)
            minRez = rez;
            minInd = j;
        end
    end
    if exactTest(i) == exactTrain(minInd)
        correct = correct + 1;
    end
end
disp(correct/noTests)

end

