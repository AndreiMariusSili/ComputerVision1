%% Load data for vocabulary building.

vocab_data = load_data("vocab", 5);

%% Extract features and their descriptors.

vocab_features = extract_features(vocab_data, 'gray', 'keypoint');

%% Build vocabulary

vocabulary = build_vocabulary(vocab_features, 400);

%% Load training data and vocabulary and extract features.

train_data = load_data("train", 50);
train_features = extract_features(train_data, 'gray', 'keypoint');

%% Cluster feature descriptors using vocabulary.

clustered_features = cluster_features(train_features, vocabulary);

%% Quantize feature descriptors into histograms.

quantized_features = quantize_features(clustered_features, size(vocabulary, 2), false);

%% Train SVM

[data, targets] = preprocess_data(quantized_features, "airplanes");
model = svm_train(data, targets);

%% Load all test data and vocabulary.

[test_data, test_paths] = load_data("test", 50);
test_features = extract_features(test_data, 'gray', 'keypoint');
test_clustered_features = cluster_features(test_features, vocabulary);
test_quantized_features = quantize_features(test_clustered_features, size(vocabulary, 2), false);

%%
[data, targets, paths] = preprocess_data(test_quantized_features, "airplanes", test_paths);

%% Recognize objects

[predicted_labels, accuracy, decision_values] = svm_predict(data, targets, model);
[average_precison] = compute_average_precision(targets, decision_values);

%%
