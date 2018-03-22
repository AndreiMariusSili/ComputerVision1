function vocabulary_generator()
    
    sift_colours = ["rgb","opponent"];
    sift_types = ["keypoint"];
    vocab_sizes = [400, 800, 1600, 2000, 4000];
    
    vocab_data = load_data('vocab', 250);
    
    for colour=sift_colours
        for type=sift_types
            for vocab_size=vocab_sizes
                fprintf('Generating vocabulary: %s_%s_%d --- ', colour, type, vocab_size);
                tic
                vocab_features = extract_features(vocab_data, colour, type);
                
                [vocabulary, ~] = build_vocabulary(vocab_features, vocab_size);
                vocab_name = sprintf('%s_%s_%d', colour, type, vocab_size);
                
                save(fullfile('vocabularies', vocab_name), 'vocabulary');
                
                toc
            end
        end
    end
end