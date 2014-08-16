function R= getCepstrum(data, frameSize, frameShift, outFile1, outFile2)
sr = 16000;
frameShift = 0.015*sr;
frameSize = 0.025*sr;
dataFrames = buffer(data, frameSize, frameSize - frameShift);
[m n] = size(dataFrames);
for j = 1 : n;
	cepst(j,:) = real(ifft(log(abs(fft(dataFrames(:,j)))+eps)))';
	magSpec(j,:) = abs(fft(dataFrames(:,j)))';
	save(outFile1, 'cepst');
	save(outFile2, 'magSpec');
end
