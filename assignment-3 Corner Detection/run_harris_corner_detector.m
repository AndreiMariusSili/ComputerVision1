%% Run Harris Corner Detector on test images.
clear;clc;

img_path = 'person_toy/00000001.jpg';
sigma = 1.5;
threshold = 10000;

[H, r, c] = harris_corner_detector(img_path,sigma, threshold, true, true, false);

%% Expriment with different values for the threshold.

img_path = 'pingpong/0000.jpeg';
sigma = 1.5;
thresholds = [20, 100, 1000, 10000];
for threshold = thresholds
    [H, r, c] = harris_corner_detector(img_path,sigma, threshold, false, false, true);
end

%% Generate rotated images.

img_path = 'person_toy/00000001.jpg';
I = imread(img_path);
for i = 1:4
    angle = fix(90 * i);
    rotatedI = imrotate(I, angle);
    imwrite(rotatedI, sprintf('rotations/person_toy_%d.png', angle));
end

%% Run detector on rotated images.

for i = 1:4
    img_path = sprintf('rotations/person_toy_%d.png', 90 * i);
    threshold = 1000;
    sigma = 1.5;
    [H, r, c] = harris_corner_detector(img_path, sigma, threshold, false, false, true);
end
