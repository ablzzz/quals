function [centroidCepst centroidMagSpec centroidLpcc feat] = performVQ(folder)
centroidCepst = [];
centroidMagSpec = [];
centroidLpcc = [];
feat = [];
for j = 1 : 10;
    ext = ['vowel_' num2str(j) '_instance_*wav']
    files1 = dir(fullfile(folder(j).name, [ ext '.cepst' ]  ));
    files2 = dir(fullfile(folder(j).name, [ ext '.magSpec'] ));
    files3 = dir(fullfile(folder(j).name, [ ext '.lpcc'] ));
    
    folder(j).name
    for k = 1 : 190;
        feat1 = load([folder(j).name '/' files1(k).name ], '-mat');
        cepstFeat(j).feat(k,:) = feat1.cepst(10, :);
        feat = [feat feat1.cepst(10,:)];
        feat2 = load([folder(j).name '/' files2(k).name ], '-mat');
        magSpecFeat(j).feat(k,:) = feat2.magSpec(10, :);
        feat3 = load([folder(j).name '/' files3(k).name ], '-mat');
        lpccFeat(j).feat(k,:) = feat3.lpcc(10, :);
    end
       [idx centr] = kmeans(cepstFeat(j).feat, 8);
       centroidCepst = [centroidCepst; centr];
       [idx centr] = kmeans(magSpecFeat(j).feat, 8);
       centroidMagSpec = [centroidMagSpec; centr];
       [idx centr] = kmeans(lpccFeat(j).feat, 8);
       centroidLpcc = [centroidLpcc; centr];
end