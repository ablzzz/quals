function lpcc = LinerPCC(data, frameSize, frameShift, lpOrder, outFile)
%flname=getenv('FILE1');
%frameShift = 0.015*16000;
%frameSize = 0.025*16000;
lpC	= lpc(data,lpOrder);
[m n]=size(lpC);
lpcoef=lpC(:,2:n);
for i = 1:m
    c(i,1:n-1)=-lpcoef(i,:);
    c(i,n:lpOrder)=0;
    for j = 2:n-1
        c(i,j)=c(i,j)+(1/j)*((-j+[1:j-1])*(lpcoef(i,1:j-1).*c(i,j-[1:j-1]))');
    end
    for j=n:lpOrder
        c(i,j)=c(i,j)+(1/j)*((-j+[1:n-1])*(lpcoef(i,1:n-1).*c(i,j-[1:n-1]))');
    end
end
lpcc=c;
save(outFile,'lpcc');
