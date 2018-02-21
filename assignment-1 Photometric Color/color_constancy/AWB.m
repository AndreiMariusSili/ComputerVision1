A = imread('awb.jpg');
A = im2double(A);

figure
subplot(1,2,1)
imshow(A)
title('Original image');

[h, w, n] = size(A);
R = A(:,:,1);
G = A(:,:,2);
B = A(:,:,3);

sums = sum(sum(A,1),2);
illum = sums(:) ./ (h*w);

%===========================
scale=sum(illum)/3;

R = R*scale/illum(1);
G = G*scale/illum(2);
B = B*scale/illum(3);

%===========================

new_image = zeros(size(A));
new_image(:,:,1) = R;
new_image(:,:,2) = G;
new_image(:,:,3) = B;

subplot(1,2,2)
imshow(new_image)
title('Corrected image');
