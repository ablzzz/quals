function R= getCepstrumSFrame(data, outFile1, outFile2)
sr = 16000;
cepst = real(ifft(log(abs(fft(data))+eps)))';
magSpec = abs(fft(data))';
save(outFile1, 'cepst');
save(outFile2, 'magSpec');
end
