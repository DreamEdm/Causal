function [score] = getScore(End_pdag,skeleton)
End_pdag(find(End_pdag~=0))=1;
c = 0;
for i = 1:size(End_pdag,1)
    for j = 1:size(End_pdag,1)
        if End_pdag(i,j) == 1 && End_pdag(i,j) == skeleton(i,j)
            c = c + 1;
        end
    end
end
R = c/sum(sum(End_pdag));
P = c/sum(sum(skeleton));
if R == 0 || P ==0
    F1 = 0;
else
    F1 = 2*R*P/(R+P);
end
score = real([R,P,F1]);
end