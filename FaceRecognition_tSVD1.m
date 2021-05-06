function [ minInd ] = FaceRecognition_tSVD1( C, U_t, M, J )
% Face recognition algorithm using t-SVD
% T = tensor, J = test image, k = truncation index
% minInd = index of most similiar image


B = tensorXtensor( U_t, twist(J-M ,2) );

minInd = 1;
minRez = tensorNormF(B - C(:,1,:));
for j = 2:size(C,2)
    nn = tensorNormF(B - C(:,j,:));
    if(nn < minRez)
        minRez = nn;
        minInd = j;
    end
end
end

