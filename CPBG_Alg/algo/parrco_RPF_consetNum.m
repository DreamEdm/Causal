function [Score,consetNum2] = parrco_RPF_consetNum(data,skeleton,consetNum)
n = size(skeleton,1);
alpha = 0.05;
Cskeleton=zeros(n,n);
Acell = cell(1,n);
MN = nchoosek(1:n,2);
consetNum2 = 0;
for p = 1:size(MN,1)
    Acell{p}=-1;
end
for i= 1:(n-1)
    lab = i;
    pc = [];
    %%% accelerate
    acTemp = [];
    %%% accelerate
    for j = i+1:n
        flag = true;
%         indf = KCI005(data(:,i), data(:,j),[],[]);
          indf = PaCoTest(data(:,i), data(:,j),[],alpha);
%         fprintf('lab: %d; neighbor: %d;result: %d',i,j,indf);
%         fprintf('\r\n');
        if indf
            indTemp = find(ismember(MN, [i,j], 'rows')==1);
            Acell{indTemp}=0;
        end
        if indf == false
            temp = (1:n);
%             temp([i,j,acTemp])=[];
            temp([i,j])=[];
            conSepSet = temp;
            for k=1:min(consetNum,length(conSepSet))
                if flag == false
                    break;
                end
                condPaAll = nchoosek(temp,k);
                numCondPaAll = size(condPaAll,1);
                for p = 1:numCondPaAll
                    condPa = condPaAll(p,:);
                    ind  =   PaCoTest(data(:,i), data(:,j), data(:, condPa),alpha);
                    consetNum2 = consetNum2 + 1;
%                     fprintf('lab: %d; neighbor: %d; conSet: %s; result: %d',i,j,num2str(condPa),ind);
%                     fprintf('\r\n');
                    if ind
                        indTemp = find(ismember(MN, [i,j], 'rows')==1);
                        Acell{indTemp}=condPa;
                        flag = false;
                        acTemp = [acTemp,j];
                        break;
                    end
                end
            end
            if flag == true
                pc = unique([pc,j]);
            end
        end
    end
%     fprintf('lab: %d; PC: %s',i,num2str(pc));
%     fprintf('\r\n');
    len=length(pc);
    for w = 1:len
        Cskeleton(lab,pc(w))=1;
        Cskeleton(pc(w),lab)=1;
    end
end
Dskeleton = deduceSkeleton(Cskeleton,Acell);
Score1 = ScoreSkeleton(Cskeleton,skeleton);
Score2 = ScoreStructure(Dskeleton,skeleton);
Score = [Score1,Score2];