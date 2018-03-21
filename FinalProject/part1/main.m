%% Load data for vocabulary building.

vocab_data = load_data('vocab', 250);

%% Extract features and their descriptors.

vocab_features = extract_features(vocab_data, 'gray', 'keypoint');

%% Build vocabulary

vocabulary = build_vocabulary(vocab_features, 800,  '1000images_800words_gray_keypoint');

%% Load training data and vocabulary and extract features.

train_data = load_data('train', 50);
vocabulary_file = load('vocabularies/1000images_400words/vocab.mat');
vocabulary = vocabulary_file.vocab;
train_features = extract_features(train_data, 'gray', 'keypoint');

%% Cluster feature descriptors using vocabulary.

clustered_features = cluster_features(train_features, vocabulary);

%% Quantize feature descriptors into histograms.

quantized_features = quantize_features(clustered_features, size(vocabulary, 2), false);

%% Train SVM

model = train_svm_classifier(quantized_features, "airplanes");

%% Load all test data.

test_data = load_data('teest', 50);
vocabulary_file = load('vocabularies/1000images_400words/vocab.mat');
vocabulary = vocabulary_file.vocab;
test_features = extract_features(test_data, 'gray', 'keypoint');
test_clustered_features = cluster_features(test_features, vocabulary);
test_quantized_features = quantize_features(test_clustered_features, size(vocabulary, 2), false);

%% Recognize objects
[predicted_label, accuracy, prob_estimates] = recognize_objects(test_quantized_features, model, "airplanes");

%% Analysis

