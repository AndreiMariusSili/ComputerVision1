ball_reflectance = imread('ball_reflectance.png');
ball_shading = imread('ball_shading.png');
ball_original = imread('ball.png');

ball_recoloured_reflectance_g = zeros(size(ball_original));
ball_recoloured_reflectance_m = zeros(size(ball_original));
ball_reconstructed_g = uint16(zeros(size(ball_original)));
ball_reconstructed_m = uint16(zeros(size(ball_original)));

[h, w, n] = size(ball_original);

pure_green = [0;255;0];
magenta = [255;0;255];

for row = 1:h
    for column = 1:w
        color = uint16(ball_reflectance(row, column, :));
        color = color(:);
        if isequal(color, [0;0;0]) == false
            ball_recoloured_reflectance_g(row, column, :) = pure_green;
            ball_recoloured_reflectance_m(row, column, :) = magenta;
        end
        ball_reconstructed_g(row, column, :) = uint16(ball_recoloured_reflectance_g(row, column, :)) .* uint16(ball_shading(row, column, :));
        ball_reconstructed_m(row, column, :) = uint16(ball_recoloured_reflectance_m(row, column, :)) .* uint16(ball_shading(row, column, :));
    end
end
    
subplot(3,2,1), imshow(ball_original);
title('Original image');
subplot(3,2,2), imshow(ball_shading);
title('Shading');
subplot(3,2,3), imshow(ball_recoloured_reflectance_g);
title('Recoloured reflectance');
subplot(3,2,4), imshow(ball_reconstructed_g);
title('Reconstructed image');
subplot(3,2,5), imshow(ball_recoloured_reflectance_m);
title('Recoloured reflectance');
subplot(3,2,6), imshow(ball_reconstructed_m);
title('Reconstructed image');


