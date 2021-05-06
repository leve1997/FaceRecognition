% Klasteriranje objekata k-sredinama 
%
% Podaci: skenirane znamenke, rezolucija 16 x 16 
%
% Dio nastavnog materijala  
% PMF-Matematicki odsjek, Sveuciliste u Zagrebu
% Diplomski izborni kolegij Uvod u slozeno pretrazivanje podataka
% (© Zlatko Drmac)

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
k = 10;
M = tensor_mean(TA);
A = StdDevTensor(TA, M);
U = T_SVD(TA);
U_t = tensor_transpose( U(:,1:k,:) );
C = tensorXtensor(U_t, A);

noTests = size(A1,2);
correct = 0;
for i = 1 : noTests
    index = FaceRecognition_tSVD1(C, U_t, M, squeeze(reshape( A1(:,i), 16, 16 ) ));
    if D1(i) == D(index)
        correct = correct + 1;
    end
    i
end
disp(correct/noTests)

% sps=size(S);
% n1=sps(1); n2=sps(2); n3=sps(3);
% sp3 = zeros(n3,1) ; 
% for i = 1 : n3  
%      sp3(i) = sum(diag(S(:,:,i)'*S(:,:,i))) ;
% end
% 
% sp2 = zeros(n2,1) ; 
% for i = 1 : n2 
%      sp2(i) = sum(diag(squeeze(S(:,i,:))'*squeeze(S(:,i,:)))) ;
% end
% 
% sp1 = zeros(n1,1) ; 
% for i = 1 : n1 
%      sp1(i) = sum(diag(squeeze(S(i,:,:))'*squeeze(S(i,:,:)))) ;
% end
%  
% figure(1)
% semilogy(1:n1,sp1(1:n1),'r.-', 1:n2,sp2(1:n2),'g.-', 1:n3,sp3(1:n3),'b.-')
% legend('mod 1', 'mod 2', 'mod 3')
% 
% 
% %..........................................................................
% r = 200 ; 
% S1 = S(1:n1,1:n2,1:r) ;
% TA1 = ten_mat_mult(ten_mat_mult(ten_mat_mult(S1,U1,1),U2,2),U3(:,1:r),3) ;
% 
% %EA = TA1 - TA ; 
% iz = 0 ;
% while ( iz > -1 )
% iz = input(' vizualizacija pojedinih znamenki (front slice); (-1 za kraj) >> ') ; 
% if ( iz == -1 ), break, end 
% figure(2), 
%     subplot(1,2,1), ima2(reshape(TA(:,:,iz),256,1))
%     subplot(1,2,2), ima2(reshape(TA1(:,:,iz),256,1))
% end
% ...........................................................................
%     
% 
% 
% for i = 1 : n3
%     AA(:,:,i) = U1 * S(:,:,i)*U2' ;
%     normAA(i) = norm(squeeze(AA(:,:,i)),'fro') ; 
% end
% 
% figure(3)
% semilogy(1:n3,normAA(1:n3),'ro-')
% 
% for i = 1 : n3 
%     AB{i} = U1 * S(:,:,i)*U2' ; 
% end
% 
% [ma1,na1] = size(A1) ; 
% 
% 
% for i = 1 : na1 
%     TA1(:,:,i) = reshape( A1(:,i), 16, 16 ) ; 
% end
% 
% test = 0 ; 
% for j = 1 : na1 
%    z =  TA1(:,:,j) ; 
%    for i = 1 : 10
%        rez(i) = norm( z - UC{i}(:,1:k1)*UC{i}(:,1:k1)'*z) ;
%    end
%    [dummy,imin] = min(rez) ; 
%    zje = imin - 1 ; 
%    if ( zje == D1(j) )
%        test = test + 1 ;
%    end
% end

