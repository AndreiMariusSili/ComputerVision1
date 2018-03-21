%% Load data for vocabulary building.

vocab_data = load_data('vocab', 250);

%% Extract features and their descriptors.

vocab_features = extract_features(vocab_data, 'gray', 'keypoint');

%% Build vocabulary

vocabulary = build_vocabulary(vocab_features, 400,  '1000images_400words');

%% Load training data and vocbulary and extract features.

train_data = load_data('train', 50);
vocabulary_file = load('vocabularies/1000images_400words/vocab.mat');
vocabulary = vocabulary_file.vocab;
train_features = extract_features(train_data, 'gray', 'keypoint');

%% Cluster feature descriptors using vocabulary.

clustered_features = cluster_features(train_features, vocabulary);

%% Quantize feature descriptors into histograms.

quantized_features = quantize_features(clustered_features, size(vocabulary, 2), false);
