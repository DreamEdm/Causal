function[outskeleton] = logicExtension(Dskeleton,Cskeleton)
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
            xCh = find(Dskeleton(x,:)==1);
            yPa = find(Dskeleton(:,y)==1)';
            yCh = find(Dskeleton(y,:)==1);
            x2y = intersect(xCh,yPa);
            y2x = intersect(yCh,xPa);
            changeFlag = false;
            if ~isempty(x2y)
                changeFlag = true;
                Dskeleton(x,y)= 1;
            end
            if ~isempty(y2x)
                changeFlag = true;
                Dskeleton(y,x)= 1;
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
%%%%%%%%%%%%%%%%%%%%%%refine
% for Sii=1:LenMA
%     if Dskeleton(MA(Sii,1),MA(Sii,2))==0 && Dskeleton(MA(Sii,2),MA(Sii,1))==0
%         if rand > 0.5
%             Dskeleton(MA(Sii,1),MA(Sii,2))=1;
%         else
%             Dskeleton(MA(Sii,2),MA(Sii,1))=1;
%         end
%     end
% end
outskeleton = Dskeleton;
end