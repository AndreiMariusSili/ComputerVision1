function [data, paths] = load_data(data_type, n)
    % Load data into a cell array of size (category_length, n). Images can
    % be read using curly braces notation(e.g. data{1,1}).
    %
    % - ARGUMENTS
    %       type   type of data to load as string: 'vocab', 'train', or 'test'
    %       n       size of the train or test set as integer.
    %
    % - OUTPUT
    %       data    cell array of image matrices.
    
    categories = ["motorbikes", "cars", "faces", "airplanes"];
    images_by_category = containers.Map('KeyType', 'char', 'ValueType', 'any');
    
    switch data_type
        case "train"
            stage = 'train';
        case "vocab"
            stage = 'train';
        case "test"
            stage = 'test';
    end

    % Read data files and select top `n` image paths.
    for category=categories
        % Read in paths from file
        image_paths_file = fopen(sprintf("../Caltech4/ImageSets/%s_%s.txt", category, stage), 'r');
        image_paths = textscan(image_paths_file, '%s');
        image_paths = image_paths{1,1};
        
        % Load training data from the end of the array to avoid picking the
        % same data wtice.
        if data_type == 'train'
            image_paths = flipud(image_paths);
        end
        
        % Generate lists of data from 
        category_images = strings(n, 1);
        for i=1:n
            category_images(i) = fullfile('../Caltech4/ImageData/', sprintf('%s.%s', image_paths{i}, 'jpg'));
        end

        images_by_category(char(category)) = category_images;
        fclose(image_paths_file);
    end


    % Load images into cell array at position (category_index, image index).
    data = cell(length(categories), n);
    paths = cell(length(categories), n);
    for i=1:length(categories)
        for j =1:n
            category_list = images_by_category(char(categories(i)));
            category_image_path = char(category_list(j));
            category_image = imread(category_image_path);
            
            data(i,j) = {category_image};
            paths(i,j) = {category_image_path};
        end
    end
end