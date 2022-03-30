function[Score]= ScoreStructure(Cskeleton,skeleton)
n = size(skeleton,1);
interSet = 0;
actualC = (sum(sum(skeleton)));
inferC = (sum(sum(Cskeleton)));
for i = 1:n
    for j = 1:n
        if i ~= j && Cskeleton(i,j) == 1 && Cskeleton(i,j) == skeleton(i,j)
            interSet = interSet + 1;
        end
    end
end
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