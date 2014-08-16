function centroidCepst = performVQ(folder)
centroidCepst = [];
for j = 1 : 10;
    ext = ['actvowel_' num2str(j) '_instance_*wav']
    files = dir(fullfile(folder(j).name, ext  ));
    files
    folder(j).name
    for k = 1 : 90;
        feat = load([folder(j).name '/' files(k).name '.lpcc'], '-mat');
        cepstFeat(j).feat(k,:) = feat.lpcc(10,:);
    end
       [idx centr] = kmeans(cepstFeat(j).feat, 1);
       centroidCepst = [centroidCepst; centr]
end