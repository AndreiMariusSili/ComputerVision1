function visualize(input_image)
    a = zeros(size(input_image, 1), size(input_image, 2));
    if size(input_image,3) == 4  % then, we have the grays images. 
        subplot(2,2,1), imshow(cat(3, input_image(:,:,4), input_image(:,:,4), input_image(:,:,4)));
        subplot(2,2,2), imshow(cat(3, input_image(:,:,1), input_image(:,:,1), input_image(:,:,1)));
        subplot(2,2,3), imshow(cat(3, input_image(:,:,2), input_image(:,:,2), input_image(:,:,2)));
        subplot(2,2,4), imshow(cat(3, input_image(:,:,3), input_image(:,:,3), input_image(:,:,3)));
    else
        subplot(2,2,1), imshow(input_image);
        subplot(2,2,2), imshow(cat(3, input_image(:,:,1), a, a));
        subplot(2,2,3), imshow(cat(3, a, input_image(:,:,2), a));
        subplot(2,2,4), imshow(cat(3, a, a, input_image(:,:,3)));
    end
    
end

