function my_tsne(train_data, train_labels)

% Set parameters
no_dims = 2;
initial_dims = min(50, size(train_data,2));
perplexity = 30;
% Run t?SNE
mappedX = tsne(train_data, [], no_dims, initial_dims, perplexity);
% Plot results
gscatter(mappedX(:,1), mappedX(:,2), train_labels);

end