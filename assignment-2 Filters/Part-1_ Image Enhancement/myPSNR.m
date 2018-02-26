function [ PSNR ] = myPSNR( orig_image, approx_image )
    [h,w, ~] = size(orig_image);
    
    orig_image = im2double(orig_image);
    approx_image = im2double(approx_image);
  
    MSE = sum(sum((orig_image-approx_image).^2))/(h*w);
    I_max = max(max(orig_image));
    PSNR = 20*log10(double(I_max/sqrt(MSE)));
end 