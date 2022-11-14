function [t,S,R] = findEnd(y)
i=1;
while y(i,3)>1
    i=i+1;
end
t=i;
S=y(i,1);
R=y(i,6);
end
