function [skeleton, names] = LoadingDataset(counts)
    if counts == 1
        [skeleton,names] = readRnet( '.\dataset\cancer.net');
    end
    if counts == 2
        [skeleton,names] = readRnet( '.\dataset\asia.net');
    end
    if counts == 3
        [skeleton,names] = readRnet( '.\dataset\child.net');
    end
    if counts == 4
        [skeleton,names] = readRnet( '.\dataset\mildew.net');
    end
    if counts == 5
        [skeleton,names] = readRnet( '.\dataset\water.net');
    end
    if counts == 6
        [skeleton,names] = net2sketelon( '.\dataset\insurance.net');
    end
    if counts == 7
        [skeleton,names] = net2sketelon( '.\dataset\Alarm.net');
    end
    if counts == 8
        [skeleton,names] = readRnet( '.\dataset\barley.net');
    end
    if counts == 9
        [skeleton,names] = net2sketelon( '.\dataset\hailfinder.net');
    end
    if counts == 10
        [skeleton,names] = net2sketelon( '.\dataset\win95pts.net');
    end
    if counts == 11
        [skeleton,names] = readRnet( '.\dataset\pathfinder.net');
    end
    if counts == 12
        [skeleton,names] = readRnet( '.\dataset\andes.net');
    end
    if counts == 13
        [skeleton,names] = hugin2skeleton( '.\dataset\Pigs.hugin');
    end
    if counts == 14
        [skeleton,names] = hugin2skeleton( '.\dataset\Link.hugin');
    end
    if counts == 15
        [skeleton,names] = readRnet( '.\dataset\munin2.net');
    end
end

