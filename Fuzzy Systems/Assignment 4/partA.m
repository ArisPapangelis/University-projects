clear;

load haberman.data;

inputs=3;

% random idx partition 
class1 = haberman(haberman(:,4)==1,:);
class2 = haberman(haberman(:,4)==2,:);

[trainIdx,valIdx,testIdx] = dividerand(225,0.6,0.2,0.2);
trainIdx=trainIdx(randperm(length(trainIdx)));
valIdx=valIdx(randperm(length(valIdx)));
testIdx=testIdx(randperm(length(testIdx)));

% actual data partition
trnData = class1(trainIdx,:);
valData = class1(valIdx,:);
chkData = class1(testIdx,:);

[trainIdx,valIdx,testIdx] = dividerand(81,0.6,0.2,0.2);
trainIdx=trainIdx(randperm(length(trainIdx)));
valIdx=valIdx(randperm(length(valIdx)));
testIdx=testIdx(randperm(length(testIdx)));


% actual data partition
trnData = [trnData; class2(trainIdx,:)];
valData = [valData; class2(valIdx,:)];
chkData = [chkData; class2(testIdx,:)];


checkLength = length(chkData);
trainLength = length(trnData);

CR = [0.6 0.16];

%xBounds = [min(trnData); max(trnData)];
model(1) = genfis2(trnData(:,1:inputs), trnData(:, inputs+1), CR(1));
model(1).name = ['Genfis2 - ' num2str(CR(1))];
model(2) = genfis2(trnData(:,1:inputs), trnData(:, inputs+1), CR(2));
model(2).name = ['Genfis2 - ' num2str(CR(2))];

model(3) = ClassDependentClusterA(trnData, CR(1));
model(4) = ClassDependentClusterA(trnData, CR(2));

for i=1:2
    for j=1:length(model(i).output(1).mf(:))
        model(i).output(1).mf(j).type='constant'; 
        model(i).output(1).mf(j).params = model(i).output(1).mf(j).params(end); 
    end
end

for i=1:4
    [fis,error,stepsize,chkFis,chkErr] = anfis(trnData, model(i), [100, 0, 0.05], 0, valData);
    saveFis(i) = chkFis;
    
    
    figure
    for k=1:inputs
        
        [f,mf] = plotmf(chkFis,'input',k);
        subplot(2,2,k)
        plot(f ,mf)
        title(['Input ' num2str(k)], 'fontweight','bold','fontsize',10) 
        
    end
    
    %plot learning curves
    figure
    iterations = [1:max(size(error))];
    plot(iterations, error, 'b', iterations, chkErr, 'r');
    title(['Learning curves for model ' num2str(i)], 'fontweight','bold','fontsize',16) 
    legend('MSE Train','MSE Check')
    xlabel('iterations')
    ylabel('MSE') 
    
    %find error matrix
    result = round(evalfis(chkData(:,1:inputs), chkFis));
    
    k = zeros(max(chkData(:,inputs+1)));
    
    for q=1:checkLength
        horizontal = result(q);
        if horizontal < 1
            horizontal = 1;
        elseif horizontal > max(size(k))
            horizontal = max(size(k));
        end
        vertical = chkData(q, inputs+1);
        k(horizontal,vertical) = k(horizontal,vertical) + 1;
    end
    disp(k)
    
    OA(i) = sum(diag(k))/checkLength;
    p = 0;
    for q=1:max(size(k))
        PA(i,q) = k(q,q)/sum(k(:,q));
        UA(i,q) = k(q,q)/sum(k(q,:));
        p = p + sum(k(:,q))*sum(k(q,:));
    end
    
    kest(i) = (checkLength*sum(diag(k))-p)/(checkLength^2-p);
    
end

for i=1:4
    mfedit(saveFis(i));
end
