% test your code by using this simple script

clear
clc


I = imread('peppers.png');

% close all
figure('Name','Opponent')
J = ConvertColorSpace(I,'opponent');
visualize(J);
 
% close all
figure('Name','Normalised RGB')
J = ConvertColorSpace(I,'rgb');
visualize(J);

% close all
figure('Name', 'HSV')
J = ConvertColorSpace(I,'hsv');
visualize(J);

% close all
figure('Name', 'YCBCR');
J = ConvertColorSpace(I,'ycbcr');
visualize(J);

% close all
figure('Name', 'Gray')
J = ConvertColorSpace(I,'gray');
visualize(J);