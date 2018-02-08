addpath('components')

% random image
img_path = 'peppers.png';
% random vector
x = randi(100,[5,1]);
% random matrix
A = randi(3,[5,5]);

% get statistics of a vector
% vectorStats(x)

% convert image to grayscale
% grayScale(img_path);

% split image into 2 cards and flip them
% shuffleCards(img_path);

% swap RGB to BGR values in an image
% RGB2BGR(img_path);

% walk over an matrix with a 9x9 lens and compute mean
meanScan(A)
