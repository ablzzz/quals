function R = getConmat(Res);
cep = buffer(Res.cep,20,0);
lpc = buffer(Res.lpc,20,0);
mag = buffer(Res.lpc,20,0);
for j = 1 : 10;
    for k = 1 : 10;
        R.conmatCep(j,k) = sum(cep(:,j) == k);
        R.conmatMag(j,k) = sum(mag(:,j) == k);
        R.conmatLpc(j,k) = sum(lpc(:,j) == k);
    end
end