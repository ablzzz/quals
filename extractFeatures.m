function R = extractFeatures(folder, ext)
files = dir(fullfile(folder, ext))
for j = 1 : length(files)
    sr = 16000;
    frameShift = 0.015*sr;
    frameSize = 0.025*sr;
	dataP = wavread([folder '/' files(j).name]);
    [a b] = max(dataP(1:600));
    data = dataP(b : b + ceil(sr/220));
	outFile1 = [folder '/' files(j).name '.Sflpcc'];
	outFile2 = [folder '/' files(j).name '.Sfcepst'];
	outFile3 = [folder '/' files(j).name '.SfmagSpec'];
	%getCepstrumSFrame(data,  outFile2, outFile3);
	getLPCCSframe(data, frameSize, frameShift, 10, outFile1);
end 
R = 1;