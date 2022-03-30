function[Dskeleton] = VSdirection(Cskeleton,AM,BM)
% 判断V结构
Dskeleton = zeros(size(Cskeleton,1),size(Cskeleton,1));
for p = 1:size(AM,2)  %%%%% AM = zeros(2,Lmn);  ���ںܶ�0�����
    x = AM(1,p);
    y = AM(2,p);
    % 选择两个点
    if x == 0    
        break;
    end
    % 寻找这个节点的所有边
    pax = find(Cskeleton(:,x)==1)';
    chx = find(Cskeleton(x,:)==1);
    pcx = unique([pax,chx]);
    pay = find(Cskeleton(:,y)==1)';
    chy = find(Cskeleton(y,:)==1);
    pcy = unique([pay,chy]);
    interPc = intersect(pcx,pcy); % 交集
    if ~isempty(interPc)
        % 改成单向边
        if  BM(1,p) == 0
            Dskeleton(x,interPc)=1;
            Dskeleton(y,interPc)=1;
            Dskeleton(interPc,x)=0;
            Dskeleton(interPc,y)=0;
        end
        if  BM(1,p) > 0
            diffPc = setdiff(interPc,BM(:,p)'); % 如果这个矛盾点是一个condition，如果BM有，那么diffPc没有内容
            if ~isempty(diffPc)
                Dskeleton(x,diffPc)=1;
                Dskeleton(y,diffPc)=1;
                Dskeleton(diffPc,x)=0;
                Dskeleton(diffPc,y)=0;
            end
        end
    end
end

end