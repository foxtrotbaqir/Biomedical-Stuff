function [f1,f2]=exchange(f1,f2,isExchange)
%exchange f1 and f2
if isExchange==0
    return;
end
if isExchange==1
    f1=min(f1,f2);
    f2=max(f1,f2);
end
if isExchange==-1
    f1=max(f1,f2);
    f2=min(f1,f2);
end