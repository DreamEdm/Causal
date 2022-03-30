function[Dskeleton] = ReCITdirection(Cskeleton,AM,CM,DM)
Dskeleton = zeros(size(Cskeleton,1),size(Cskeleton,1));
[~,s] = sortrows(AM',1);
AM = AM(:,s);
CM = CM(:,s);
DM = DM(:,s);
for p = 1:size(AM,2) %%%%% AM = zeros(2,Lmn);  ���ںܶ�0�����
    x = AM(1,p);
    y = AM(2,p);
    if x == 0
        continue;
    end
    % 残差判断方向
    if CM(1,p) > 0
        temp = setdiff(CM(:,p),0)'; %%%%% ȥ0
        lenTemp = length(temp);
        for i=1:lenTemp
            if Cskeleton(temp(i),x)==1 || Cskeleton(x,temp(i))==1
                Dskeleton(temp(i),x)=1;
                Dskeleton(x,temp(i))=0;
            end
        end
    end
    if DM(1,p) > 0
        temp = setdiff(DM(:,p),0)'; %%%%% ȥ0
        lenTemp = length(temp);
        for i=1:lenTemp
            if Cskeleton(temp(i),y)==1 || Cskeleton(y,temp(i))==1
                Dskeleton(temp(i),y)=1;
                Dskeleton(y,temp(i))=0;
            end
        end
    end
end
end