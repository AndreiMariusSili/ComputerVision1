ball_reflectance = imread('ball_reflectance.png');
ball_shading = imread('ball_shading.png');
ball_original = imread('ball.png');

ball_recoloured_reflectance = zeros(size(ball_original));
ball_reconstructed = uint16(zeros(size(ball_original)));

pure_green = [0;255;0];
magenta = [255;0;255];

for row = 1:h
    for column = 1:w
        color = uint16(ball_reflectance(row, column, :));
        color = color(:);
        if isequal(color, [0;0;0]) == false
            ball_recoloured_reflectance(row, column, :) = magenta;
        end
        ball_reconstructed(row, column, :) = uint16(ball_recoloured_reflectance(row, column, :)) .* uint16(ball_shading(row, column, :));
    end
end
    
    
subplot(2,2,1), imshow(ball_original);
subplot(2,2,2), imshow(ball_reconstructed);
subplot(2,2,3), imshow(ball_recoloured_reflectance);
subplot(2,2,4), imshow(ball_shading);
