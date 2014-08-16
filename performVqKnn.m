function [R Conmat] = performVqKnn(folder, neighb)
feat = []; feat1train = []; feat2train = []; feat3train =[]; feat1test = []; feat2test = []; feat3test = [];
group = [ones(180,1); 2*ones(180,1); 3*ones(180,1); 4*ones(180,1); 5*ones(180,1); 6*ones(180,1); 7*ones(180,1); 8*ones(180,1); 9*ones(180,1); 10*ones(180,1)];
for j = 1 : 10;
    ext = ['vowel_' num2str(j) '_instance_*wav']
    files1 = dir(fullfile(folder(j).name, [ ext '.cepst' ]  ));
    files2 = dir(fullfile(folder(j).name, [ ext '.magSpec'] ));
    files3 = dir(fullfile(folder(j).name, [ ext '.lpcc'] ));
    feat1 = [];
    feat2 = [];
    feat3 = [];
    for k = 1 : 200;
        feat = load([folder(j).name '/' files1(k).name ], '-mat');
        feat1 = [feat1 ; feat.cepst(10,:)];
        feat = load([folder(j).name '/' files2(k).name ], '-mat');
        feat2 = [ feat2 ; feat.magSpec(10, :)];
        feat = load([folder(j).name '/' files3(k).name ], '-mat');
        feat3 = [feat3 ; feat.lpcc(10,:)];
    end
    feat1train = [feat1train; feat1(1:180,:)];
    feat2train = [feat2train; feat2(1:180,:)];
    feat3train = [feat3train; feat3(1:180,:)];
    feat1test = [feat1test; feat1(181:200,:)];
    feat2test = [feat2test; feat2(181:200,:)];
    feat3test = [feat3test; feat3(181:200,:)];
end
size(feat1)
    size(group)
    R.cep = knnclassify(feat1test, feat1train, group, neighb);
    R.mag = knnclassify(feat2test, feat2train, group, neighb);
    R.lpc = knnclassify(feat3test, feat3train, group, neighb);
    Conmat = getConmat(R);
    