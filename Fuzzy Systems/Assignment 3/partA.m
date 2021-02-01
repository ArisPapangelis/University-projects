clear;
%% Dataset operations
load airfoil.dat


%{
index=randperm(length(airfoil));

trnindex=index(1:round(length(index)*0.6));

valindex=index(round(length(index)*0.6)+1:round(length(index)*0.8));

checkindex=index(round(length(index)*0.8)+1:end);

trnData = airfoil(trnindex, :); %902

valData = airfoil(valindex, :); %300

checkData = airfoil(checkindex, :);   %301
%}

[trnData, valData, checkData] = split_scale(airfoil, 1);

% Save output of checking data as y
y = checkData(:, 6);
average = mean(y);

%% TSK model creation

mfType = 'gbellmf';
model(1) = genfis1(trnData, 2, mfType, 'constant');
model(2) = genfis1(trnData, 3, mfType, 'constant');
model(3) = genfis1(trnData, 2, mfType, 'linear');
model(4) = genfis1(trnData, 3, mfType, 'linear');

%% Model training & evaluation
for i=1:4
    % Train the model
    [fis,error,stepsize,chkFis,chkErr] = anfis(trnData, model(i), [100, 0], 0, valData);
    
    % Use optimal model to predict the result
    result = evalfis(checkData(:,1:5), chkFis);
    mse(i)=0;
    ss(i) = 0;
    % Calculate error in checking set
    for j=1:length(checkData)
        mse(i) = mse(i) + (result(j)-y(j))^2;
        ss(i) =  ss(i) + (result(j)-average)^2;
    end
    
    % Calculate evaluation metrics
    rr(i) = 1 - mse(i)/ss(i);
    nmse(i) = mse(i)/ss(i);
    ndei(i) = sqrt(nmse(i));
    mse(i) = mse(i)/length(checkData);
    rmse(i) = sqrt(mse(i));
    nrmse(i) = rmse(i) / average;
    
    
    figure
    
    % Plot final membership functions for each input
    for k=1:5
        
        % plot membership function 
        [f,mf] = plotmf(chkFis,'input',k);
        subplot(2,3,k)
        plot(f,mf)
        title(['Input ' num2str(k)], 'fontweight','bold','fontsize',10) 
        
    end
    
    % Plot training & validation error for each epoch
    figure
    iterations = [1:max(size(error))];
    plot(iterations, error, iterations, chkErr);
    title(['Learning curves for model ' num2str(i)], 'fontweight','bold','fontsize',16) 
    legend('MSE Train','MSE Check')
    xlabel('iterations')
    ylabel('MSE') 
    
    % Absolute error graph
    predicterror = result - y; 
    figure
    plot([1:length(predicterror)], predicterror);
    title(['Prediction errors for model ' num2str(i)], 'fontweight','bold','fontsize',16) 
    xlabel('sample')
    ylabel('Error')
end

