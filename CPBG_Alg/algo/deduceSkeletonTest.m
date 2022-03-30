function[Dskeleton] = deduceSkeletonTest(Cskeleton,Acell)
n = size(Cskeleton,1);
MN = nchoosek(1:n,2);
Dskeleton = zeros(n,n);
for p = 1:size(MN,1)
    x = MN(p,1);
    y = MN(p,2);
    pax = find(Cskeleton(:,x)==1)';
    chx = find(Cskeleton(x,:)==1);
    pcx = unique([pax,chx]);
    pay = find(Cskeleton(:,y)==1)';
    chy = find(Cskeleton(y,:)==1);
    pcy = unique([pay,chy]);
    interPc = intersect(pcx,pcy);
    if ~isempty(interPc)
        if sum(Acell{p}) == 0;
            Dskeleton(x,interPc)=1;
            Dskeleton(y,interPc)=1;
            Dskeleton(interPc,x)=0;
            Dskeleton(interPc,y)=0;
        end
        if sum(Acell{p}) > 0;
            diffPc = setdiff(interPc,Acell{p});
            if ~isempty(diffPc)
                Dskeleton(x,diffPc)=1;
                Dskeleton(y,diffPc)=1;
                Dskeleton(diffPc,x)=0;
                Dskeleton(diffPc,y)=0;
            end
        end
    end

%     Dskeleton = propagation(Dskeleton,Cskeleton);
%     Dskeleton = logicExtension(Dskeleton,Cskeleton);

end
end