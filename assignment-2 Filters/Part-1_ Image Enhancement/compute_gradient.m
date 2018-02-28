function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)

    g_x = [1 0 -1; 2 0 -2; 1 0 -1];
    g_y = g_x';
    
    Gx = imfilter(im2double(image), g_x);
    Gy = imfilter(im2double(image), g_y);
    
    im_magnitude = sqrt(Gx.^2 + Gy.^2);
    
    im_direction = 1./tag(Gy, Gx);
    
end

