function [result] = RGB2BGR(img_path)

RGB = imread(img_path);

R = RGB(:,:,1);
G = RGB(:,:,2);
B = RGB(:,:,3);

BGR = cat(3, B,G,R);

figure(1)
subplot(1,2,1)
imshow(RGB)

subplot(1,2,2)
imshow(BGR)

end