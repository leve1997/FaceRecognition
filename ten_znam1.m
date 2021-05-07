load azip   % 16 x 16 bitmape vekorizirane u 256 x 1 stupce od A
load dzip   % dzip(i) = j <=> i-stupac od A sadrzi znamenku j 

A = azip ; % A(:,i) je 256 x 1 = vektorizirana slika znamenke rez. 16 x 16
D = dzip ; % D(i) je 0, ..., 9; oznacava koja znamenka je u A(:,i)
% podaci za testiranje
load testzip % 16 x 16 bitmape vekorizirane u 256 x 1 stupce od A1
load dtest   % dzip(i) = j <=> i-stupac od A1 sadrzi znamenku j
A1 = testzip ;
D1 = dtest   ;

[mA,nA] = size(A) ; 

for i = 2 : nA 
    TA(:,i,:) = reshape( A(:,i), 16, 16 ) ; 
end
    
ks = [4 6 13 7 4 7 6 2 4 6 4];
M = tensor_mean(TA);
A = StdDevTensor(TA, M);
U = T_SVD(TA);
vec_Ut = {};
vec_C = {};
for i = 1:10
    vec_Ut{i} = tensor_transpose( U(:,1:ks(i),:) );
    vec_C{i} = tensorXtensor(cell2mat(vec_Ut(i)), A);
end

noTests = max(size(dtest));
correct = 0;
for i = 1:noTests
    index = FaceRecognition_tSVD1(cell2mat(vec_C(D1(i)+1)), cell2mat(vec_Ut(D1(i)+1)), M, squeeze(reshape( A1(:,i), 16, 16 ) ));
    if D1(i) == D(index)
        correct = correct + 1;
    end
end
disp(correct/noTests)
