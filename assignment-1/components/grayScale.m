function [gray] = grayScale(img_path)
%Display and image as grayscale and return the
%representation

X = imread(img_path);
X_db = im2double(X);
X_gray = rgb2gray(X_db);
figure(1);
imshow(X_gray);

gray = X_gray;

end