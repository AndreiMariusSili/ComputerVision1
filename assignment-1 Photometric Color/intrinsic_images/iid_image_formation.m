ball_reflectance = imread('ball_reflectance.png');
ball_shading = imread('ball_shading.png');
ball_original = imread('ball.png');

[h, w, n] = size(ball_original);

%=======================================================
% YOUR CODE HERE

ball_reconstructed = uint16(ball_reflectance) .* uint16(ball_shading);

%=======================================================

subplot(2,2,1), imshow(ball_original);
title('Original image');
subplot(2,2,2), imshow(ball_reconstructed);
title('Reconstructed image');
subplot(2,2,3), imshow(ball_reflectance);
title('Reflectance');
subplot(2,2,4), imshow(ball_shading);
title('Shading');