%load('Yale_32x32.mat');
load('YaleB_32x32.mat');

[nSmp,nFea] = size(fea);
for i = 1:nSmp
     fea(i,:) = fea(i,:) ./ max(1e-12,norm(fea(i,:)));
end
rez_matrix = zeros(20,2);
for j = 17:17
    str = ['20Train/' num2str(j) '.mat'];
    load(str);
    fea_Train = fea(trainIdx,:);
    fea_Test = fea(testIdx,:);

    gnd_Train = gnd(trainIdx);
    gnd_Test = gnd(testIdx);

    max_k = 0;
    max_percentage = 0;
    for k = 1:200
        percentage = MatrixPCA( fea_Train', fea_Test', k, gnd_Train, gnd_Test );
        if percentage > max_percentage
            max_percentage = percentage;
            max_k = k;
        end
        k
        plot_rez(k) = percentage;
    end
    rez_matrix(j,:) = [max_k; max_percentage]
    j
end