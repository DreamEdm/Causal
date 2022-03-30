function[Dskeleton] = mergeSkeleton(skeletonByVs,skeletonByRCI)
% intiskeletonByVs = skeletonByVs;
% n = size(skeletonByVs,1);
[Sa,Sb] = find (skeletonByRCI == 1);
MA = [Sa,Sb];
LenMA = size(MA,1);
for Si=1:LenMA
    x = MA(Si,1);
    y = MA(Si,2);
    skeletonByVs(x,y) = 1;
    skeletonByVs(y,x) = 0;
end
Dskeleton = skeletonByVs;
% a = find(intiskeletonByVs ==1);
% b = find(Dskeleton ==1);
% if a == b
%     xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx = 1
% else
% %     graphViz4Matlab(Dskeleton)
% %     graphViz4Matlab(intiskeletonByVs)
%     yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy = 2
% end
end