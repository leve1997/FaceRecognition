load azip   % 16 x 16 bitmape vekorizirane u 256 x 1 stupce od A
load dzip   % dzip(i) = j <=> i-stupac od A sadrzi znamenku j 

A = azip ; % A(:,i) je 256 x 1 = vektorizirana slika znamenke rez. 16 x 16
D = dzip ; % D(i) je 0, ..., 9; oznacava koja znamenka je u A(:,i)
% podaci za testiranje
load testzip % 16 x 16 bitmape vekorizirane u 256 x 1 stupce od A1
load dtest   % dzip(i) = j <=> i-stupac od A1 sadrzi znamenku j
A1 = testzip ;
D1 = dtest   ;

for k = 1:200
    graf(k) = MatrixPCA(A, A1, k, D, D1);
end
plot(graf);