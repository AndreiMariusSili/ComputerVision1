%% Load some training data.

training_data = load_data('train', 10);

%% Extract features and their descriptors.

features_descriptors = extract_features_descriptors(training_data, 'gray', 'keypoint');

%% Build vocabulary

vocabulary = build_vocabulary(features_descriptors, 10,  'debug');

%% Quantize features using vocabulary.


