function R = extractFeatures(folder, ext)
files = dir(fullfile(folder, ext))
for j = 1 : length(files)
    sr = 16000;
    frameShift = 0.015*sr;
    frameSize = 0.025*sr;
	data = wavread([folder '/' files(j).name]);
    %[a b] = max(dataP(1:600));
    %data = dataP(b : b + ceil(sr/220));
	outFile1 = [folder '/' files(j).name '.lpcc'];
	outFile2 = [folder '/' files(j).name '.cepst'];
	outFile3 = [folder '/' files(j).name '.magSpec'];
	getCepstrum(data, frameSize, frameShift, outFile2, outFile3);
	getLPCC(data, frameSize, frameShift, 6, outFile1);
end 
R = 1;