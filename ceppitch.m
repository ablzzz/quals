function R= ceppitch(Wvocal_tanp,minim,maxim,sr)
[n m]=size(Wvocal_tanp);
for j = 1:m; w=Wvocal_tanp(:,j);
%W=[w ;w(length(w):-1:1)];
c = spCepstrum(w, sr, 'hamming', 'plot');
f0(j) = spPitchCepstrum(c, sr,minim,maxim); 
end
R=f0;
