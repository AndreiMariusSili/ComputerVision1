function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb

    [R, G, B] = getColorChannels(input_image);
    
    R_G_B = R + G + B;
    
    output_image = zeros(size(input_image));
    output_image(:,:,1) = R ./ R_G_B;
    output_image(:,:,2) = G ./ R_G_B;
    output_image(:,:,3) = B ./ R_G_B;

end

