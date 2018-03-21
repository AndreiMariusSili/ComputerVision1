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
        throw(MException('Color: BadValue', 'RGB-SIFT not implemented yet.'));
    case 'rgb'
        throw(MException('Color: BadValue', 'rgb-SIFT not implemented yet.'));
    case 'opponent'
        throw(MException('Color: BadValue', 'opponent-SIFT not implemented yet.'));
end


end