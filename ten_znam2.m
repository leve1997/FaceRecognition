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
for i = 1 : nA 
    TA(:,i,:) = reshape( A(:,i), 16, 16 ) ; 
end

M = tensor_mean(TA);
A = StdDevTensor(TA, M);
Q = tQR(TA);

for k = 1:60 % optimum k
    Q_t = tensor_transpose( Q(:,1:k,:) );
    C = tensorXtensor(Q_t, A);

    noTests = size(A1,2);
    correct = 0;
    for i = 1 : noTests
        index = FaceRecognition_tSVD1(C, Q_t, M, squeeze(reshape( A1(:,i), 16, 16 ) ));
        if D1(i) == D(index)
            correct = correct + 1;
        end
    end
    disp(k)
    disp(correct/noTests)
end
