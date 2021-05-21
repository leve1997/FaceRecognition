%load('Yale_32x32.mat');
load('YaleB_32x32.mat');

[nSmp,nFea] = size(fea);
for i = 1:nSmp
     fea(i,:) = fea(i,:) ./ max(1e-12,norm(fea(i,:)));
end
rez_tenz = zeros(20,2);
for j = 17:17
    str = ['20Train/' num2str(j) '.mat'];
    load(str);
    fea_Train = fea(trainIdx,:);
    fea_Test = fea(testIdx,:);

    gnd_Train = gnd(trainIdx);
    gnd_Test = gnd(testIdx);

    cnt1 = 1;
    cnt2 = 1;
    for i = 1 : size(fea,1)
        if ismember(i,trainIdx)
            TA(:,cnt1,:) = reshape(fea_Train(cnt1,:),[32,32]) ;
            cnt1 = cnt1 + 1;
        else
            TJ(:,cnt2,:) = reshape(fea_Test(cnt2,:),[32,32]) ;
            cnt2 = cnt2 + 1;
        end
    end
    max_k = 0;
    max_percentage = 0;
    for k = 1:30
        percentage = FaceRecognition_tSVD1_ver2( TA, TJ, k, gnd_Train, gnd_Test );
        if percentage > max_percentage
            max_percentage = percentage;
            max_k = k;
        end
        k
        plot_rez(k) = percentage;
    end
    rez_tenz(j,:) = [max_k; max_percentage]
    j
end