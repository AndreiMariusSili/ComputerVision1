function imOut = compute_LoG(image, LOG_type)

    switch LOG_type
        case 1
            %method 1
            gaussKernel = gauss2D(0.5,5);
            laplacianKernel = fspecial('laplacian', 0.2);
            smoothedImage = imfilter(image, gaussKernel);
            imOut = imfilter(smoothedImage, laplacianKernel);
        case 2
            %method 2
            logKernel = fspecial('log', 5, 0.5);
            imOut = imfilter(image, logKernel);
        case 3
            gaussKernelHigh = gauss2D(sqrt(2) * 0.5, 5);
            imFilterHigh = imfilter(image, gaussKernelHigh);

            gaussKernelLow = gauss2D(0.5, 5);
            imFilterLow = imfilter(image, gaussKernelLow);
            imOut = imFilterHigh - imFilterLow;

            imOut  = mat2gray(imOut);
    end
        
figure
imshow(imOut)
end

