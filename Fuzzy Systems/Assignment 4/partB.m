clear;

seizure = csvread('seizure.csv',1,1, [1, 1, 11500, 179]);

inputs=178;

% random idx partition 
[trainIdx,valIdx,testIdx] = dividerand(11500,0.6,0.2,0.2);
trainIdx=trainIdx(randperm(length(trainIdx)));
valIdx=valIdx(randperm(length(valIdx)));
testIdx=testIdx(randperm(length(testIdx)));

% actual data partition
trnData = seizure(trainIdx,:);
valData = seizure(valIdx,:);
chkData = seizure(testIdx,:);

trainLength = length(trnData);
checkLength = length(chkData);


NF=[6, 10, 15, 20];
CR=[0.15, 0.3, 0.45, 0.6];

cvPar = cvpartition(trainLength,'k',5);
[ranks,weights] = relieff(trnData(:,1:178), trnData(:,179),10);

cvErr = zeros(max(size(NF)), max(size(CR)));

for i=1:1:max(size(NF))
    for j=1:max(size(CR))
        
        attributes = ranks(1:NF(i));
        
        err = zeros(cvPar.NumTestSets,1);
        
        parfor q = 1:cvPar.NumTestSets
            
            trIdx = cvPar.training(q);
            teIdx = cvPar.test(q);
            
            %{
            fismat = genfis2(trnData(trIdx==1,attributes),trnData(trIdx==1,inputs+1), CR(j));
            nuofrules = length(fismat.rule);
            for t=1:nuofrules
               fismat.output(1).mf(t).type='constant'; 
               fismat.output(1).mf(t).params = fismat.output(1).mf(t).params(end); 
            end
            %}
            
            fismat = ClassDependentClusterB(trnData(trIdx==1,[attributes, inputs+1]), CR(j));
            
            [fis,error,stepsize,chkFis,chkErr] = ...
                anfis(trnData(trIdx==1, [attributes, inputs+1]), fismat,...
                [1, 0, 0.1], 0, trnData(teIdx==1, [attributes, inputs+1]));
            
             err(q) = min(chkErr);
        end
        
        cvErr(i,j) = sum(err)/cvPar.NumTestSets;
    end
end

save('ClassificationB_final.mat');

figure
stem3(CR, NF, cvErr)

minMatrix = min(cvErr(:));
[features, radii] = find(cvErr==minMatrix);


attributes = ranks(1:NF(features));

fismat = ClassDependentClusterB(trnData(:,[attributes, inputs+1]), CR(radii));

[fis,error,stepsize,chkFis,chkErr] = ...
    anfis(trnData(:, [attributes, inputs+1]), fismat, [100, 0, 0.05], 'none', valData(:, [attributes, inputs+1]));
    
% plot learning curves
figure
iterations = [1:max(size(error))];
plot(iterations, error, iterations, chkErr);
title('Learning curves ', 'fontweight','bold','fontsize',16) 
legend('MSE Train','MSE Check')
xlabel('iterations')
ylabel('MSE') 

% find error matrix
result = round(evalfis(chkData(:,attributes), chkFis));

k = zeros(max(chkData(:,inputs+1)));

for q=1:checkLength
    horizontal = result(q);
    if horizontal < 1
        horizontal = 1;
        result(q)=1;
    elseif horizontal > max(size(k))
        horizontal = max(size(k));
        result(q)=max(size(k));
    end
    vertical = chkData(q, inputs+1);
    k(horizontal,vertical) = k(horizontal,vertical) + 1;
end
disp(k)

OA = sum(diag(k))/checkLength;
p = 0;
for q=1:max(size(k))
    PA(q) = k(q,q)/sum(k(:,q));
    UA(q) = k(q,q)/sum(k(q,:));
    p = p + sum(k(:,q))*sum(k(q,:));
end

kest = (checkLength*sum(diag(k))-p)/(checkLength^2-p);

%plot check results
figure
iterations = [1:checkLength];
Y = [result, chkData(:, inputs+1)];
stem(Y)
title('Predictions and actual values ', 'fontweight','bold','fontsize',16) 
legend('Predicted values','Actual values')
xlabel('samples')
ylabel('values') 

%fuzzy sets
figure
for k=1:6
        
    [f,mf] = plotmf(fismat,'input',k);
    subplot(2,3,k)
    plot(f ,mf)
    title(['Initial sets for input ' num2str(k)], 'fontweight','bold','fontsize',8) 

end

figure
for k=1:6
        
    [f,mf] = plotmf(chkFis,'input',k);
    subplot(2,3,k)
    plot(f ,mf)
    title(['Final sets for input ' num2str(k)], 'fontweight','bold','fontsize',8) 

end
