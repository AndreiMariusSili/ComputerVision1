function [stitched] = stitch(left, right)

[rh,rw,~] = size(right);
left = im2double(imresize(left, [rh, rw]));
[lh,lw,~] = size(left);
right = im2double(right);

[m1, m2, m3, m4, t1, t2] = RANSAC(left, right, 0.9999);

warped_right = transform(right, m1,m2,m3,m4,t1,t2,'matlab');
figure; imshow(warped_right);

[wh,ww, ~]= size(warped_right);

T = [m1 m2 0; m3 m4 0; t1 t2 1];

round([1, 1, 1]*T)
ul = round([1, 1, 1]/T);
xul = ul(2);
yul= ul(1);
ur = round([1, rw, 1]/T);
xur = ur(2);
yur = ur(1);
bl = round([rh, 1, 1]/T);
xbl = bl(2);
ybl = bl(1);
br = round([rh, rw, 1]/T);
xbr = br(2);
ybr = br(1);

% hMax =max([yur yur ybl ybr])
pad = round((wh-lh)/2)

figure; imshow(padarray(left, [pad, pad]));
hold on;
plot(xul, yul, 'r+');
plot(xur, yur, 'b+');
plot(xbl, ybl, 'g+');
plot(xbr, ybr, 'y+');
hold off;
figure; imshow(right);
hold on;
plot(1,1, 'r+');
plot(rw, 1, 'b+');
plot(1, rh, 'g+');
plot(rw,rh, 'y+');
hold off;

stitched = zeros;
end