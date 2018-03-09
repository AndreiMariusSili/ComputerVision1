% question 1.1
boat1 = imread('./boat1.pgm');
boat2 = imread('./boat2.pgm');
[f1,d1,f2,d2,matches,scores] = keypoint_matching(boat1,boat2);

% question 1.2
perm = randperm(size(matches, 2)) ;
selected_matches = matches(:,perm(1:50));
% plot_images(boat1,boat2, f1(1,selected_matches(1,:)), f1(2,selected_matches(1,:)), f2(1,selected_matches(2,:)), f2(2,selected_matches(2,:)));


% question 1.3 

[m1, m2, m3, m4, t1, t2] = RANSAC(boat1,boat2, 100);


% http://inside.mines.edu/~whoff/courses/EENG510/lectures/04-InterpolationandSpatialTransforms.pdf

% the section below should be replaced with our implementation.
I = boat1;
K = boat2;
% I am putting minus m2 and minus m3 because it makes the image
% boat1 to rotate in the other direction. Although, I expected to rotate in
% the good direction with m2 and m3 as they are.
tform = maketform('affine',[m1 -m2 0; -m3 m4 0; t1 t2 1]);
J = imtransform(I,tform);

figure, imshow(I)
figure, imshow(J)
figure, imshow(K)