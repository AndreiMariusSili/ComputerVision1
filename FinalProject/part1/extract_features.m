function [features] = extract_features(data, color, method)
    % Extract SIFT features for each image in the data. The
    % (frames descriptors) pairs are saved in a cell array at the same
    % position as the original image in the data cell array.
    % - ARGUMENTS
    %       data    data previously read in as a cell array with `load_data`
    %       color   color space to use when computing descriptors
    %       method  whether to use keypoint or dense SIFT
    % - OUTPUT
    %       features    cell array of (frames descriptors) pairs

[no_categories, category_size] = size(data);
switch color
    case 'gray'
        % Create cell matching data dimensionality.
        features = cell(no_categories, category_size, 2);
        switch method
            case 'keypoint'
                % Get descriptors for each image and store the matching
                % cell array.
                for i = 1:no_categories
                    for j = 1:category_size
                        if size(data{i,j},3) == 3
                            I = single(rgb2gray(data{i,j}));
                        else
                            I = single(data{i,j});
                        end
                        [frames, descriptors] = vl_sift(I);
                        features(i,j,:) = {frames, descriptors};
                    end
                end
            case 'dense'
                for i = 1:no_categories
                    for j = 1:category_size
                        if size(data{i,j},3) == 3
                            I = single(rgb2gray(data{i,j}));
                        else
                            I = single(data{i,j});
                        end
                        [frames, descriptors] = vl_dsift(I, 'step', 10);
                        features(i,j,:) = {frames, descriptors};
                    end
                end
        end
    case 'RGB'
        % Create cell matching data dimensionality.
        features = cell(no_categories, category_size, 2);
        switch method
            case 'keypoint'
                % Get descriptors for each image and store the matching
                % cell array.
                for i = 1:no_categories
                    for j = 1:category_size
                        if size(data{i,j},3) == 3
                            I = single(rgb2gray(data{i,j}));
                            [frames] = vl_sift(I);
                            % For each feature in grayscale, compute
                            % descriptors for R, G and B.
                            transformed_I = data{i,j};
                            [f_R,d_R] = vl_sift(single(transformed_I(:,:,1)),'frames',frames, 'orientations');
                            [f_G,d_G] = vl_sift(single(transformed_I(:,:,2)),'frames',frames, 'orientations');
                            [f_B,d_B] = vl_sift(single(transformed_I(:,:,3)),'frames',frames, 'orientations');
                            features(i,j,:) = {[f_R,f_G,f_B], [d_R,d_G,d_B]};

                        else
                            I = single(data{i,j});
                            [frames, descriptors] = vl_sift(I);
                            % Grayscale image: so, for all channels, the features
                            % and descriptors are the same, and we already
                            % computed them.
                            features(i,j,:) = {[frames,frames,frames], [descriptors,descriptors,descriptors]};
                        end
                    end
                end
            case 'dense'
                % Get descriptors for each image and store the matching
                % cell array.
                for i = 1:no_categories
                    for j = 1:category_size
                        if size(data{i,j},3) == 3
                            % For each feature in grayscale, compute
                            % descriptors for R, G and B.
                            transformed_I = data{i,j};
                            [f_R,d_R] = vl_dsift(single(transformed_I(:,:,1)), 'step', 10);
                            [f_G,d_G] = vl_dsift(single(transformed_I(:,:,2)), 'step', 10);
                            [f_B,d_B] = vl_dsift(single(transformed_I(:,:,3)), 'step', 10);
                            features(i,j,:) = {[f_R,f_G,f_B], [d_R,d_G,d_B]};

                        else
                            I = single(data{i,j});
                            [frames, descriptors] = vl_dsift(I, 'step', 10);
                            % Grayscale image: so, for all channels, the features
                            % and descriptors are the same, and we already
                            % computed them.
                            features(i,j,:) = {[frames,frames,frames], [descriptors,descriptors,descriptors]};
                        end
                    end
                end
        end
    case 'rgb'
        % Create cell matching data dimensionality.
        features = cell(no_categories, category_size, 2);
        switch method
            case 'keypoint'
                % Get descriptors for each image and store the matching
                % cell array.
                for i = 1:no_categories
                    for j = 1:category_size
                        if size(data{i,j},3) == 3
                            I = single(rgb2gray(data{i,j}));
                            [frames] = vl_sift(I);
                            % For each feature in grayscale, compute
                            % descriptors for R, G and B.
                            transformed_I = rgb2normedrgb(data{i,j});
                            [f_R,d_R] = vl_sift(single(transformed_I(:,:,1)),'frames',frames, 'orientations');
                            [f_G,d_G] = vl_sift(single(transformed_I(:,:,2)),'frames',frames, 'orientations');
                            [f_B,d_B] = vl_sift(single(transformed_I(:,:,3)),'frames',frames, 'orientations');
                            features(i,j,:) = {[f_R,f_G,f_B], [d_R,d_G,d_B]};

                        else
                            I = single(data{i,j});
                            [frames, descriptors] = vl_sift(I);
                            % Grayscale image: so, for all channels, the features
                            % and descriptors are the same, and we already
                            % computed them.
                            features(i,j,:) = {[frames,frames,frames], [descriptors,descriptors,descriptors]};
                        end
                    end
                end
            case 'dense'
                % Get descriptors for each image and store the matching
                % cell array.
                for i = 1:no_categories
                    for j = 1:category_size
                        if size(data{i,j},3) == 3
                            % For each feature in grayscale, compute
                            % descriptors for R, G and B.
                            transformed_I = rgb2normedrgb(data{i,j});
                            [f_R,d_R] = vl_dsift(single(transformed_I(:,:,1)), 'step', 10);
                            [f_G,d_G] = vl_dsift(single(transformed_I(:,:,2)), 'step', 10);
                            [f_B,d_B] = vl_dsift(single(transformed_I(:,:,3)), 'step', 10);
                            features(i,j,:) = {[f_R,f_G,f_B], [d_R,d_G,d_B]};

                        else
                            I = single(data{i,j});
                            [frames, descriptors] = vl_dsift(I, 'step', 10);
                            % Grayscale image: so, for all channels, the features
                            % and descriptors are the same, and we already
                            % computed them.
                            features(i,j,:) = {[frames,frames,frames], [descriptors,descriptors,descriptors]};
                        end
                    end
                end
        end
    case 'opponent'
        % Create cell matching data dimensionality.
        features = cell(no_categories, category_size, 2);
        switch method
            case 'keypoint'
                % Get descriptors for each image and store the matching
                % cell array.
                for i = 1:no_categories
                    for j = 1:category_size
                        if size(data{i,j},3) == 3
                            I = single(rgb2gray(data{i,j}));
                            [frames] = vl_sift(I);
                            % For each feature in grayscale, compute
                            % descriptors for R, G and B.
                            transformed_I = rgb2opponent(data{i,j});
                            [f_R,d_R] = vl_sift(single(transformed_I(:,:,1)),'frames',frames, 'orientations');
                            [f_G,d_G] = vl_sift(single(transformed_I(:,:,2)),'frames',frames, 'orientations');
                            [f_B,d_B] = vl_sift(single(transformed_I(:,:,3)),'frames',frames, 'orientations');
                            features(i,j,:) = {[f_R,f_G,f_B], [d_R,d_G,d_B]};

                        else
                            I = single(data{i,j});
                            [frames, descriptors] = vl_sift(I);
                            % Grayscale image: so, for all channels, the features
                            % and descriptors are the same, and we already
                            % computed them.
                            features(i,j,:) = {[frames,frames,frames], [descriptors,descriptors,descriptors]};
                        end
                    end
                end
            case 'dense'
                % Get descriptors for each image and store the matching
                % cell array.
                for i = 1:no_categories
                    for j = 1:category_size
                        if size(data{i,j},3) == 3
                            % For each feature in grayscale, compute
                            % descriptors for R, G and B.
                            transformed_I = rgb2opponent(data{i,j});
                            [f_R,d_R] = vl_dsift(single(transformed_I(:,:,1)), 'step', 10);
                            [f_G,d_G] = vl_dsift(single(transformed_I(:,:,2)), 'step', 10);
                            [f_B,d_B] = vl_dsift(single(transformed_I(:,:,3)), 'step', 10);
                            features(i,j,:) = {[f_R,f_G,f_B], [d_R,d_G,d_B]};

                        else
                            I = single(data{i,j});
                            [frames, descriptors] = vl_dsift(I, 'step', 10);
                            % Grayscale image: so, for all channels, the features
                            % and descriptors are the same, and we already
                            % computed them.
                            features(i,j,:) = {[frames,frames,frames], [descriptors,descriptors,descriptors]};
                        end
                    end
                end
        end
end


end