function [data] = load_data(stage, n)
    % Load data into a cell array of size (category_length, n). Images can
    % be read using curly braces notation(e.g. data{1,1}).
    %
    % - ARGUMENTS
    %       stage   stage of processing as string: "train" or "test"
    %       n       size of the train or test set as integer.
    %
    % - OUTPUT
    %       data    cell array of image matrices.
    
    categories = ["motorbikes", "cars", "faces", "airplanes"];
    images_by_category = containers.Map('KeyType', 'char', 'ValueType', 'any');

    % Read data files and select top `n` image paths.
    for category=categories
        image_paths_file = fopen(sprintf("../Caltech4/ImageSets/%s_%s.txt", category, stage), 'r');

        category_images = strings(n, 1);
        image_path = fullfile('../Caltech4/ImageData/', sprintf('%s.%s', fgetl(image_paths_file), 'jpg'));
        c=1;
        while ischar(image_path) && c <= n
            category_images(c) = image_path;
            image_path = fullfile('../Caltech4/ImageData/', sprintf('%s.%s', fgetl(image_paths_file), 'jpg'));
            c = c+1;
        end

        images_by_category(char(category)) = category_images;
        fclose(image_paths_file);
    end


    % Load images into cell array at position (category_index, image index).
    data = cell(length(categories), n);
    for i=1:length(categories)
        for j =1:n
            category_list = images_by_category(char(categories(i)));
            category_image_path = char(category_list(j));
            category_image = imread(category_image_path);
            
            data(i,j) = {category_image};
        end
    end
end