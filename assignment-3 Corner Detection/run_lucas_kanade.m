%% Run Lucas-Kanade on synthetic image.
img1 = imread('synth1.pgm');
img2 = imread('synth2.pgm');
lucas_kanade(img1,img2);

%% Run Lucas-Kanade on the sphere image.
img1 = imread('sphere1.ppm');
img2 = imread('sphere2.ppm');
lucas_kanade(img1,img2);
