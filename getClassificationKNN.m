function [vowClassCepst vowClassMagSpec vowClassLpcc] = getClassification(folder, centroidsCepst, centroidsMagSpec, centroidsLpcc)
[m n] = size(centroidsCepst);   
for j = 1 : 10;
    ext = ['vowel_' num2str(j) '_instance_*wav*'];
    files1 = dir(fullfile(folder(j).name, [ ext '.cepst' ]  ));
    files2 = dir(fullfile(folder(j).name, [ ext '.magSpec'] ));
    files3 = dir(fullfile(folder(j).name, [ ext '.lpcc'] ));
    
    
    folder(j).name
    for k = 181 : 200;
        feat1 = load([folder(j).name '/' files1(k).name ], '-mat');
        feat2 = load([folder(j).name '/' files2(k).name ], '-mat');
        feat3 = load([folder(j).name '/' files3(k).name ], '-mat');
        
        for k1 = 1 : m
            
            temp = (centroidsCepst(k1,:)- feat1.cepst(10, :)).*(centroidsCepst(k1,:) - feat1.cepst(10,:));
            distCepst(k1) = sum(temp(:));
            temp = (centroidsMagSpec(k1,:)- feat2.magSpec(10, :)).*(centroidsMagSpec(k1,:) - feat2.magSpec(10, :));
            distMagSpec(k1) = sum(temp(:));
            temp = (centroidsLpcc(k1,:)- feat3.lpcc(10, :)).*(centroidsLpcc(k1,:) - feat3.lpcc(10, :));
            distLpcc(k1) = sum(temp(:));

        end
        [a b] = sort(distCepst);
        b = ceil(b/8); [c d] = hist(b(1:5), [1:10]);
        [s vowClassCepst(j,k- 180)] = max(c);
        [a b] = sort(distMagSpec);
        b = ceil(b/8); hist(b(1:5), [1:10]);
        [s vowClassMagSpec(j,k- 180)] = max(c);
        [a b] = sort(distLpcc);
        b = ceil(b/8); hist(b(1:5), [1:10]);
        [s vowClassLpcc(j,k- 180)] = max(c);
    
    end
        
end