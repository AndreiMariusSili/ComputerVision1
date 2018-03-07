function [H, r, c] = harris_corner_detector(img_path, sigma, threshold)

% Reading image and setting window size
I = double(rgb2gray(imread(img_path)));
n = 6 * sigma;

% Generating the derivative of Gasussian
G =fspecial('gauss', n, sigma);
[Gx, Gy] = gradient(G);

% Computing cornerness H
Ix = imfilter(I, Gx, 'replicate', 'corr');
Ix2 = Ix .^2;
Iy = imfilter(I, Gy, 'replicate', 'corr');
Iy2 = Iy .^2;

A = imfilter(Ix2, G, 'replicate', 'conv');
B = imfilter(Ix.*Iy, G, 'replicate', 'conv');
C = imfilter(Iy2, G, 'replicate', 'conv');
H = (A.*C - B.^2) - 0.04 *(A+C).^2;

% Getting points of maximum cornerness
windowMax = ordfilt2(H, n^2, true(n));
maxLocations = (H == windowMax) & (H > threshold);
[r,c] = find(maxLocations);

figure
subplot(1,2,1);
surf(1:length(Gx), 1:length(Gy), Gx)
title('Gaussian derivative horizontal direction');
subplot(1,2,2)
surf(1:length(Gx), 1:length(Gy), Gy)
title('Gaussian derivative vertical direction');

% Plots
figure
subplot(1,3,1)
title('Derivatives and corners');
imshow(Ix, [])
title('Derivative in horiontal direction')
subplot(1,3,2)
imshow(Iy, [])
title('Derivative in vertical direction')
subplot(1,3,3)
imshow(I, [])
hold on
plot(c(:), r(:), 'r+')
title('Corners')

end