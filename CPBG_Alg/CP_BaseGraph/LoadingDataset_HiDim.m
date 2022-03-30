function [skeleton, names] = LoadingDataset_HiDim(counts)
    if counts == 1
        [skeleton,names] = readRnet('.\dataset\diabetes.net');
    end
    if counts == 2
        [skeleton,names] = hugin2skeleton( '.\dataset\Pigs.hugin');
    end
    if counts == 3
        [skeleton,names] = hugin2skeleton( '.\dataset\Link.hugin');
    end
end

