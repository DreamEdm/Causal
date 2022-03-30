function[Score]= ScoreSkeleton2(Oskeleton,skeleton)
n = size(skeleton,1);

for i = 1:n
   skeleton (i,i) = 0;
   Oskeleton (i,i) = 0;
end

for i = 1:n
   for j = 1:n
       if skeleton (i,j) == 1;
            skeleton (j,i) = 1;
       end
   end
end

%  Oskeleton
%  skeleton
id1 = find(skeleton==1);
len1 = length(id1);
id0 = find(Oskeleton==0);
len2 = length(find(Oskeleton==1));


countNum = len1;
for j = 1:len1
    if Oskeleton(id1(j)) == 0
        countNum = countNum - 1;
    end
end
R = countNum/len1;
P = countNum/len2;
Score = [R,P,2*R*P/(R+P)];
end