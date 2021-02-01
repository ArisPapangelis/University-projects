clear;

superconduct = table2array(readtable('superconduct.csv'));

[trnData, valData, checkData] = split_scale(superconduct, 1);

trainLength = length(trnData);
checkLength = length(checkData);
y = checkData(:, 82);

average = mean(y);

NF = [4, 6, 9, 12]; %Number of features
CR = [0.2, 0.3, 0.4, 0.5, 0.6]; %Cluster radius

% K folding
cvPar = cvpartition(trainLength,'k', 5);

% Feature extraction with KNN, k = 10
[ranks,weights] = relieff(trnData(:,1:81), trnData(:,82), 10);

for i=1:max(size(NF))
    for j=1:max(size(CR))
        
        % these are the most important features
        attributes = ranks(1:NF(i));
        
        err = zeros(cvPar.NumTestSets,1);
        
        % for each k fold
        for q = 1:cvPar.NumTestSets
            
            trIdx = cvPar.training(q);
            teIdx = cvPar.test(q);
            
            trn = trnData(trIdx==1, [attributes, 82] );
            v = trnData(teIdx==1, [attributes, 82]);
            
            % Input is already scaled from split_scale, so for the model we
            % only have to scale the output
            %xBounds = [zeros(1,NF(i)) min(trn(:,end)); ones(1,NF(i)) max(trn(:,end))];
            
            % Create model
            fismat = genfis2(trn(:,1:end-1),trn(:,end),  CR(j));
            
            % Train model
            [fis,error,stepsize,chkFis,chkErr] = anfis(trn, fismat, [40], 1, v);
			
       
             err(q) = min(chkErr);
        end
        
         cvErr(i,j) = sum(err)/cvPar.NumTestSets;
    end
end

figure
% 3-d plot sequence
stem3(CR, NF, cvErr)

% keep the optimal model
minMatrix = min(cvErr(:));
[features, radii] = find(cvErr==minMatrix);

attributes = ranks(1:NF(features));

%xBounds = [zeros(1,NF(features)) min(trnData(:,end)); ones(1,NF(features)) max(trnData(:,end))];
fismat = genfis2(trnData(:, attributes), trnData(:, 82), CR(radii));
            
[fis,error,stepsize,chkFis,chkErr] = ...
        anfis(trnData(:, [attributes, 82]), fismat, [100, 0], 0, valData(:, [attributes, 82]));
            
%plot learning curves
figure
iterations = [1:max(size(error))];
plot(iterations, error, iterations, chkErr);
title('Learning curves ', 'fontweight','bold','fontsize',16) 
legend('MSE Train','MSE Check')
xlabel('iterations')
ylabel('MSE') 

% Calculate metrics
result = evalfis(checkData(:,attributes), chkFis);
mse=0;
ss = 0;
for j=1:checkLength
    mse = mse + (result(j)-y(j))^2;
    ss =  ss + (result(j)-average)^2;
end

rr = 1 - mse/ss;
nmse = mse/ss;
ndei = sqrt(nmse);

mse = mse/checkLength;
rmse = sqrt(mse);
nrmse = rmse / average;


figure
plot([1:checkLength], y, [1:checkLength], result);
title(['Predicted and actual value ' ], 'fontweight','bold','fontsize',16) 
legend('Actual value','Prediction')
xlabel('sample')
ylabel('value')

figure
for k=1:12
        
        [f,mf] = plotmf(fismat,'input',k);
        subplot(4,3,k)
        plot(f ,mf)
        title(['Initial sets for input ' num2str(k)], 'fontweight','bold','fontsize',10) 
        
end
figure
for k=1:12
        
        [f,mf] = plotmf(chkFis,'input',k);
        subplot(4,3,k)
        plot(f ,mf)
        title(['Final sets for input ' num2str(k)], 'fontweight','bold','fontsize',10) 
        
end


