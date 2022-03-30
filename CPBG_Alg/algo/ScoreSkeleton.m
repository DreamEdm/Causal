function[Score]= ScoreSkeleton(Cskeleton,skeleton)
n = size(skeleton,1);

for i = 1:n
    Cskeleton(i,i) = 0;
    for j = 1:n
        if Cskeleton(i,j) == 1
            Cskeleton(j,i) = 1;
        end
    end
end
% skeleton
% Cskeleton
interSet = 0;
actualC = (sum(sum(skeleton)));
inferC = (sum(sum(Cskeleton)))/2;
for i = 1:n
    for j = 1:n
        if i ~= j
            if Cskeleton(i,j) == 1 && Cskeleton(i,j) == skeleton(i,j)
                interSet = interSet + 1;
            end
        end
    end
end
% interSet
R = interSet/actualC;
if inferC == 0
    P =0;
else
    P = interSet/inferC;
end
if R+P == 0
    Score = [R,P,0];
else
    Score = [R,P,2*R*P/(R+P)];
end
end