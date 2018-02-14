function visualize(input_image, colorspace)    
    if strcmp(colorspace, 'opponent')
        a = zeros(size(input_image, 1), size(input_image, 2));
        subplot(2,2,1), imshow(input_image);
        subplot(2,2,2), imshow(cat(3, input_image(:,:,1), a, a));
        subplot(2,2,3), imshow(cat(3, a, input_image(:,:,2), a));
        subplot(2,2,4), imshow(cat(3, a, a, input_image(:,:,3)));
    elseif strcmp(colorspace, 'rgb')  
        figure('Name','Normalised RGB')
        a = zeros(size(input_image, 1), size(input_image, 2));
        subplot(2,2,1), imshow(input_image);
        subplot(2,2,2), imshow(cat(3, input_image(:,:,1), a, a));
        subplot(2,2,3), imshow(cat(3, a, input_image(:,:,2), a));
        subplot(2,2,4), imshow(cat(3, a, a, input_image(:,:,3)));
    elseif strcmp(colorspace, 'hsv')
        figure('Name','HSV')
        a = zeros(size(input_image, 1), size(input_image, 2));
        subplot(2,2,1), imshow(input_image);
        subplot(2,2,2), imshow(cat(3, input_image(:,:,1), a, a));
        subplot(2,2,3), imshow(cat(3, a, input_image(:,:,2), a));
        subplot(2,2,4), imshow(cat(3, a, a, input_image(:,:,3)));
    elseif strcmp(colorspace, 'ycbcr')
        figure('Name','YCbCr')
        subplot(2,2,1);
        imshow(input_image)
        YCBCR = im2uint8(input_image);
        lb={'Y','Cb','Cr'};

        for channel=1:3
            subplot(2,2,channel+1)
            YCBCR_C=uint8(YCBCR);
            YCBCR_C(:,:,setdiff(1:3,channel))=intmax(class(YCBCR_C))/2;
            imshow(ycbcr2rgb(YCBCR_C))
            title([lb{channel} ' component'],'FontSize',18);
        end
    elseif strcmp(colorspace, 'gray')
        figure('Name','Gray')
        subplot(2,2,1), imshow(cat(3, input_image(:,:,4), input_image(:,:,4), input_image(:,:,4)));
        subplot(2,2,2), imshow(cat(3, input_image(:,:,1), input_image(:,:,1), input_image(:,:,1)));
        subplot(2,2,3), imshow(cat(3, input_image(:,:,2), input_image(:,:,2), input_image(:,:,2)));
        subplot(2,2,4), imshow(cat(3, input_image(:,:,3), input_image(:,:,3), input_image(:,:,3)));
    end