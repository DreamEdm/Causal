function[outskeleton] = propagation(Dskeleton,Cskeleton)
[Sa,Sb] = find (Cskeleton == 1);
MA = [Sa,Sb];
LenMA = size(MA,1);
tmnIdx = 0;
while 2*tmnIdx < LenMA
    for Si=1:LenMA
        x = MA(Si,1);
        y = MA(Si,2);
        if Dskeleton(x,y)==0 && Dskeleton(y,x)==0
            xPa = find(Dskeleton(:,x)==1)';
            xPaId = length(xPa);
            yPa = find(Dskeleton(:,y)==1)';
            yPaId = length(yPa);
            flag1 = true;
            flag2 = true;
            changeFlag = false;
            if xPaId > 0
                for i = 1:xPaId
                    if  sum([Dskeleton(y,xPa(i)),Dskeleton(xPa(i),y)])>0
                        flag1 = false;
                    end
                end
                if flag1 == true
                    changeFlag = true;
                    Dskeleton(x,y)= 1;
                end
            end
            if yPaId > 0
                for j = 1:yPaId
                    if  sum([Dskeleton(x,yPa(j)),Dskeleton(yPa(j),x)])>0
                        flag2 = false;
                    end
                end
                if flag2 == true
                    changeFlag = true;
                    Dskeleton(y,x)= 1;
                end
            end
            if changeFlag
                tmnIdx = 0;
            else
                tmnIdx = tmnIdx+1;
            end
        else
            tmnIdx = tmnIdx+1;
        end
    end
end
outskeleton = Dskeleton;
end