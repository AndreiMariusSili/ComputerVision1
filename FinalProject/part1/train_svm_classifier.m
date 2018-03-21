function [model] = train_svm_classifier(quant_feats,  category)
    
    % Find the index of the category in the cell array.
    categories = ["motorbikes", "cars", "faces", "airplanes"];
    category_idx = find(strcmp(categories, category));
    
    % Label all datapoints from the matching category with 1 and the
    % rest with 0.
    [no_categories, category_size] = size(quant_feats);
    data_size = no_categories*category_size;
    
    indices = 1:data_size;
    label_vector = zeros(no_categories*category_size, 1);
    label_vector(indices>(category_idx-1)*category_size & indices <= category_idx*category_size) = 1;
    
    vocab_size = size(quant_feats{1,1}, 2);
    instance_matrix = zeros(data_size, vocab_size);
    for i=1:no_categories
        for j=1:category_size
            instance_matrix(category_size*(i-1)+j, :) = quant_feats{i,j};
        end
    end
    
    best = train(label_vector, sparse(instance_matrix), '-C');
    model = train(label_vector, sparse(instance_matrix), sprintf('-c %f', best(1)));
end