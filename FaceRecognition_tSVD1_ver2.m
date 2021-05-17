function [percentage] = FaceRecognition_tSVD1_ver2( TA, TJ, k, exactTrain, exactTest, U )
% Face recognition algorithm using t-SVD
% T = tensor, J = test image, k = truncation index
% minInd = index of most similiar image
M = tensor_mean(TA);
A = StdDevTensor(TA, M);

Ut = tensor_transpose( U(:,1:k,:) );

C = tensorXtensor(Ut, A);
noTests = size(TJ,2);
correct = 0;
for i = 1:noTests
    B = tensorXtensor( Ut, twist( squeeze(TJ(:,i,:))-M , 2) );
    minInd = 1;
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
percentage = correct/noTests;
end


