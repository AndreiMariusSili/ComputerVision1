function [data, targets] = preprocess_data(cell_array, category)
    
    % Find the index of the category in the cell array.
    categories = ["motorbikes", "cars", "faces", "airplanes"];
    category_idx = find(strcmp(categories, category));
    
    [no_categories, category_size] = size(cell_array);
    data_size = no_categories*category_size;
    
    % Build target vector as binary vector.
    indices = 1:data_size;
    targets = -ones(no_categories*category_size, 1);
    targets(indices>(category_idx-1)*category_size & indices <= category_idx*category_size) = 1;
    
    % Morph cell array into feature matrix.
    vocab_size = size(cell_array{1,1}, 2);
    data = zeros(data_size, vocab_size);
    for i=1:no_categories
        for j=1:category_size
            data(category_size*(i-1)+j, :) = cell_array{i,j};
        end
    end
end