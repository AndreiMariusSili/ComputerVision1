function [clus_feat] = cluster_features(feat_desc, vocab)

    desc = feat_desc(:,:,2);
    [no_categories, category_size] = size(desc);
    clus_feat = cell(no_categories, category_size);
    
    vocab_norms = vecnorm(vocab);
    for i=1:no_categories
        for j=1:category_size
            img_desc = single(desc{i,j});
            
            desc_norms = vecnorm(img_desc);
            desc_vocab_prod = img_desc' * vocab;
            
            distance_to_clusters = sqrt(desc_norms'.^2 + vocab_norms.^2 - 2.*desc_vocab_prod);
            [~, assignments] = min(distance_to_clusters, [], 2);
            
            clus_feat{i,j} = assignments;
        end
    end
end