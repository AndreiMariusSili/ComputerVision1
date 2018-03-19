function [features_descriptors] = extract_features_descriptors(data, color, method)
    % Extract SIFT features and descriptors for each image in the data. the
    % (features descriptors) pairs are saved in a cell array at the same
    % position as the original image in the data cell array.
    % - ARGUMENTS
    %       data    data previously read in as a cell array with `load_data`
    %       color   color space to use when computing descriptors
    %       method  whether to use keypoint or dense SIFT
    % - OUTPUT
    %       features_descriptors    cell array of (features descriptors)
    %                               pairs

[no_categories, category_size] = size(data);
switch color
    case 'gray'
        % Create cell matching data dimensionality.
        features_descriptors = cell(no_categories, category_size, 2);
        switch method
            case 'keypoint'
                % Get descriptors for each image and store the matching
                % cell array.
                for i = 1:no_categories
                    for j = 1:category_size
                        I = single(rgb2gray(data{i,j}));
                        [features, descriptors] = vl_sift(I);
                        features_descriptors(i,j,:) = {features, descriptors};
                    end
                end
            case 'dense'
                for i = 1:no_categories
                    for j = 1:category_size
                        I = single(rgb2gray(data{i,j}));
                        [features, descriptors] = vl_dsift(I, 'step', 10);
                        features_descriptors(i,j,:) = {features, descriptors};
                    end
                end
        end
    case 'RGB'
        throw(MException('Color: BadValue', 'RGB-SIFT not implemented yet.'));
    case 'rgb'
        throw(MException('Color: BadValue', 'rgb-SIFT not implemented yet.'));
    case 'opponent'
        throw(MException('Color: BadValue', 'opponent-SIFT not implemented yet.'));
end


end