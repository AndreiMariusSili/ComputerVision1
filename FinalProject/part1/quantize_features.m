function [quant_feats] = quantize_features(clus_feats, vocab_size, plot)
    
    [no_categories, category_size] = size(clus_feats);
    quant_feats = cell(no_categories, category_size);
    
    bin_edges = 0.5:vocab_size+1;
    
    for i=1:no_categories
        for j=1:category_size
            if plot
                feature_hist = histogram(clus_feats{i,j}, ...
                    'Normalization', 'probability', ...
                    'NumBins', vocab_size, ... 
                    'BinEdges', bin_edges);
                quant_feats{i,j} = feature_hist.Values;
            else
                [counts, ~] = histcounts(clus_feats{i,j});
                quant_feats{i,j} = counts;
            end 
        end
    end
end