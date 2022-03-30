function[Dskeleton] = deduceSkeletonByRCI(Cskeleton,Bcell,Ccell)
n = size(Cskeleton,1);
MN = nchoosek(1:n,2);
Dskeleton = Cskeleton;
% t = 0;
for p = 1:size(MN,1)
    x = MN(p,1);
    y = MN(p,2);
    if sum(Bcell{p}) > 0
%         xyxy = [x,y]
%         t= t + 1;
        temp = Bcell{p};
        lenTemp = length(temp);
        for i=1:lenTemp
            if Cskeleton(temp(i),x)==1 || Cskeleton(x,temp(i))==1 
                Dskeleton(temp(i),x)=1;
                Dskeleton(x,temp(i))=0;
            end
        end
    end
    if sum(Ccell{p}) > 0
%         xyxy = [x,y]
%         t= t + 1;
        temp = Ccell{p};
        lenTemp = length(temp);
        for i=1:lenTemp
            if Cskeleton(temp(i),y)==1 || Cskeleton(y,temp(i))==1
                Dskeleton(temp(i),y)=1;
                Dskeleton(y,temp(i))=0;
            end
        end
    end
end
% t
end