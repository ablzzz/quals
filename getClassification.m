function vowClass = getClassification(folder, centroids)
for j = 1 : 10;
    ext = ['actvowel_' num2str(j) '_instance_*wav'];
    files = dir(fullfile(folder(j).name, ext  ));
    
    folder(j).name
    for k = 91 : 100;
        feat = load([folder(j).name '/' files(k).name '.lpcc'], '-mat');
        for k1 = 1 : 10;
            size(feat)
            temp = (centroids(k1,:)- feat.lpcc(10,:)).*(centroids(k1,:) - feat.lpcc(10,:));
%            dist(j, k -15,k1) = sum(temp(:));
            dist(k1) = sum(temp(:));
        end
    [s vowClass(j,k- 90)] = min(dist);
    end
        
end