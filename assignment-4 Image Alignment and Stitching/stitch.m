function [ stitched_image ] = stitch(image_left, image_right, N, P)
    if nargin == 2
        N = 50;
        P = 3;
    end
    
[m1, m2, m3, m4, t1, t2] = RANSAC(image_left, image_right, N);
T = affine2d([m1 m2 0; m3 m4 0; t1 t2 1]);

transformed_image = imwarp(image_right, T);
% figure; imshow(image_right);
% figure; imshow(transformed_image);

[hl, wl, ~] = size(image_left);
[hr, wr, ~] = size(image_right);
[htr, wtr, ~] = size(transformed_image);

% !!! This manual tuning needs to be corrected
output_limits = num2cell(max(round([m1 m2; m3 m4]*[1 1 wr wr; 1 hr 1 hr] + [abs(t1)+35; abs(t2)-40]), [], 2));
[x_end, y_end] = output_limits{:};

ws = max([x_end wl]);
hs = max([y_end hl]);

new_right=uint8(zeros(hs,ws));
new_left=uint8(zeros(hs,ws));

new_left(1:hl,1:wl,:) = image_left;
new_right((y_end-htr+1):y_end,(x_end-wtr+1):x_end,:) = transformed_image;

stitched_image = imadd(imsubtract(new_left,new_right),new_right);

figure, imshow(image_left), title('Left')
figure, imshow(image_right), title('Right')
figure, imshow(transformed_image), title('Right Transformed')
figure, imshow(stitched_image), title('Stitched')
end