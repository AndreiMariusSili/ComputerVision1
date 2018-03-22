function model_generator()
    sift_colours = ["gray", "RGB", "rgb","opponent"];
    sift_types = ["keypoint", "dense"];
    vocab_sizes = [400, 800, 1600, 2000, 4000];
    train_data_sizes = [50, 100, 150];
    categories = ["motorbikes", "cars", "faces", "airplanes"];
    
    fprintf('Loading test data: 50 images per class.\n')
    test_data = load_data("test", 50);
    
    
    for colour=sift_colours
        for type=sift_types
            test_feats = extract_features(test_data, colour, type);
            for train_data_size=train_data_sizes
                fprintf('Loading train data and extracting features: %d images per class.\n', train_data_size);
                train_data = load_data("train", train_data_size);
                train_feats = extract_features(train_data, colour, type);
                
                for vocab_size=vocab_sizes
                    vocab_name = sprintf('%s_%s_%d', colour, type, vocab_size);
                    if ~exist(fullfile('vocabularies', strcat(vocab_name, '.mat')), 'file')
                        fprintf('Vocabulary %s does not exist. Skipping...\n', vocab_name);
                        continue
                    end
                    
                    load(fullfile('vocabularies', vocab_name), 'vocabulary');
                    fprintf('Quantizing features for test and training data according to vocabulary %s.\n', vocab_name);
                    
                    tic
                    train_clus_feats = cluster_features(train_feats, vocabulary);
                    train_quant_feats = quantize_features(train_clus_feats, vocab_size, false);
                    test_clus_feats = cluster_features(test_feats, vocabulary);
                    test_quant_feats = quantize_features(test_clus_feats, vocab_size, false);
                    
                    model_name = sprintf('%s_%s_%d_%d', colour, type, vocab_size, train_data_size);
                    fprintf('Generating model: %s. \n', model_name);
                    model = struct;
                    for category=categories
                        [train_data, train_targets] = preprocess_data(train_quant_feats, category);
                        [test_data, test_targets] = preprocess_data(test_quant_feats, category);
                        
                        classifier = svm_train(train_data, train_targets);
                        [pred_labels, accuracy, test_dec_vals] = svm_predict(test_data, test_targets, classifier);
                        [avg_prec] = compute_average_precision(test_targets, test_dec_vals);
                        
                        model.(category) = struct;
                        model.(category).classifier = classifier;
                        model.(category).pred_labels = pred_labels;
                        model.(category).accuracy = accuracy(1);
                        model.(category).avg_prec = avg_prec;
                        
                        model.(category).colour = colour;
                        model.(category).type = type;
                        model.(category).vocab_size = vocab_size;
                        model.(category).train_data_size = train_data_size;
                    end
                    model.map = (model.motorbikes.avg_prec ...
                                + model.cars.avg_prec ...
                                + model.faces.avg_prec ...
                                + model.airplanes.avg_prec) / 4 ;
                    save(fullfile('models', model_name), 'model'); 
                    toc
                end
            end
        end
    end
end