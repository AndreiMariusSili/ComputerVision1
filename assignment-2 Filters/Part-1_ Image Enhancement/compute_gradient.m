function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)

    g_x = [1 0 -1; 2 0 -2; 1 0 -1];
    g_y = g_x';
    
    Gx = conv2(image, g_x, 'same');
    Gy = conv2(image, g_y, 'same');
    
    im_magnitude = mat2gray(sqrt(Gx.^2 + Gy.^2));
    im_direction = mat2gray(-atan2(Gy, Gx));
    
    Gx = mat2gray(Gx);
    Gy = mat2gray(Gy);
end

