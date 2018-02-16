function visualize(input_image)
    [~,~,n] = size(input_image);
    if n == 3
        figure
        subplot(2,2,1), imshow(input_image);
        title('Combined components');
        subplot(2,2,2), imshow(input_image(:,:,1));
        title('Component 1');
        subplot(2,2,3), imshow(input_image(:,:,2));
        title('Component 2');
        subplot(2,2,4), imshow(input_image(:,:,3));
        title('Component 3');
    else
        figure
        titles = ["Lightness method" "Average method" "Luminosity method" "Built-in MATLAB function"];
        for i = 1:4
            subplot(2,2,i), imshow(input_image(:,:,i));
            title(titles(i));
        end
    end
    
end