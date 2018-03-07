function [H, r, c] = harris_corner_detector(img_path, sigma, threshold, show_gauss, show_derivative_corner, show_only_corner)

switch nargin
    case 3
        show_gauss = false;
        show_derivative_corner = false;
        show_only_corner = false;
    case 4
        show_derivative_corner = false;
        show_only_corner = false;
    case 5
        show_only_corner = false;
end

% Reading image and setting window size
colorI = imread(img_path);
I = double(rgb2gray(colorI));
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

if show_gauss
    figure
    subplot(1,2,1);
    surf(1:length(Gx), 1:length(Gy), Gx)
    title('Gaussian derivative horizontal direction');
    subplot(1,2,2)
    surf(1:length(Gx), 1:length(Gy), Gy)
    title('Gaussian derivative vertical direction');
end

if show_derivative_corner
    figure
    subplot('Position', [0 0.1 0.32 0.32])
    imshow(Ix, [])
    title('Derivative in horizontal direction');
    subplot('Position', [0.33 0.1 0.32 0.32]);
    imshow(Iy, [])
    title('Derivative in vertical direction')
    subplot('Position', [0.66 0.1 0.32 0.32]);
    imshow(colorI, [])
    hold on
    plot(c(:), r(:), 'r+')
    title('Corners');
    print(sprintf('corner_detection_s%.3f_t%.3f.png', sigma, threshold),'-dpng')
end

if show_only_corner
    figure
    imshow(colorI, [])
    hold on
    plot(c(:), r(:), 'r+')
    a = strsplit(img_path, '/');
    b = strcat('rotation_', a(2));
    print(sprintf('%s', b{1}),'-dpng');
end

end