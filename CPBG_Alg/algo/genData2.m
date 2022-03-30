function[data]=genData2(skeleton,nsamples)
[dim, ~]=size(skeleton);
data = rand(nsamples, dim)*2-1;
for k = 1:dim
    data(:,k) = data(:,k) - mean(data(:,k));
end
for i=1:dim
    parentidx=find(skeleton(:,i)==true); 
    for j=1:length(parentidx)
        if parentidx(j)==i
            parentidx(j)=[];
        end
    end
    if ~isempty(parentidx)
        pasample = 0;
        for w = 1:length(parentidx)
              pasample = pasample + data(:, parentidx(w))*(rand*0.8+0.2);
        end
        n =  (rand(nsamples,1)*2-1)*0.2;
        n = n - mean(n);
        data(:, i)= pasample + n;
    end
end

