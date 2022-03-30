function[Dskeleton] = deduceSkeletonByReCIT(Cskeleton,Acell)
n = size(Cskeleton,1);
MN = nchoosek(1:node,2);
% indTemp = find(ismember(MN, sort([i,j]), 'rows')==1);
for i = 1:n
    pax = find(Cskeleton(:,i)==1)';
    chx = find(Cskeleton(i,:)==1);
    pcx = unique([pax,chx]);
end
end