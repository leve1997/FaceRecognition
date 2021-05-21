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
[mA1,nA1] = size(A1) ;

for i = 1 : nA 
    TA(:,i,:) = reshape( A(:,i), 16, 16 ) ; 
end
for i = 1 : nA1
    TA1(:,i,:) = reshape( A1(:,i), 16, 16 ) ; 
end
    
ks = [4 6 13 7 4 7 6 2 4 6 4];
FaceRecognition_tSVD1(TA, TA1, ks, D, D1);
% FaceRecognition_tSVD2(TA, TA1, 16, D, D1);
