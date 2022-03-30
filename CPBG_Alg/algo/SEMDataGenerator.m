function data=SEMDataGenerator(skeleton,nSample, noiseType, noiseRatio)
% skeleton = sortskeleton(skeleton);
skeleton = skeleton';
[dim, dim2]=size(skeleton);
if (dim ~= dim2)
    disp('The skeleton is not square!\n');
    return;
end
data=zeros(nSample, dim);
for i=1:dim
    parentIdx=find(skeleton(i,:)==true);
    if strcmp (noiseType, 'uniform')
        noise=mapstd(rand(1, nSample))';
    end
    if isempty(parentIdx)
        data(:, i) = noise;
%         data(:, i) = data(:, i) - mean(data(:, i));
    else
        %weight=2*(rand(length(parentIdx),1)-0.5); 
        weight=ones(length(parentIdx),1)/length(parentIdx); 
        data(:, i) = data (:, parentIdx) * weight+ noise*noiseRatio;
        data(:, i) = mapstd(data(:, i)')';
%         data(:, i) = data(:, i) - mean(data(:, i));
    end
end
