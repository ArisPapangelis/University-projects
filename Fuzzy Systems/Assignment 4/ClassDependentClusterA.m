function [fis] = ClassDependentClusterA(trnData, radius)
    
    %radius=0.5;
    [c1,sig1]=subclust(trnData(trnData(:,end)==1,:),radius);
    [c2,sig2]=subclust(trnData(trnData(:,end)==2,:),radius);
    num_rules=size(c1,1)+size(c2,1);

    %Build FIS From Scratch
    fis=newfis(['FIS_' num2str(radius)],'sugeno');

    %Add Input-Output Variables
    names_in={'in1','in2','in3'};
    for i=1:size(trnData,2)-1
        fis=addvar(fis,'input',names_in{i},[min(trnData(:,i)) max(trnData(:,i))]);
    end
    fis=addvar(fis,'output','out1',[1 2]);

    %Add Input Membership Functions
    name='sth';
    for i=1:size(trnData,2)-1
        for j=1:size(c1,1)
            fis=addmf(fis,'input',i,name,'gaussmf',[sig1(i) c1(j,i)]);
        end
        for j=1:size(c2,1)
            fis=addmf(fis,'input',i,name,'gaussmf',[sig2(i) c2(j,i)]);
        end
    end

    %Add Output Membership Functions
    params=[zeros(1,size(c1,1)) ones(1,size(c2,1))];
    for i=1:num_rules
        fis=addmf(fis,'output',1,name,'constant',params(i));
    end

    %Add FIS Rule Base
    ruleList=zeros(num_rules,size(trnData,2));
    for i=1:size(ruleList,1)
        ruleList(i,:)=i;
    end
    ruleList=[ruleList ones(num_rules,2)];
    fis=addrule(fis,ruleList);
