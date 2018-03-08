%% Get all frames from a folder.

clear; clc;
folder = 'pingpong/';
file_pattern = fullfile(folder, '*.jpeg');
files = dir(file_pattern);

%% Rescale the first image for Harris Detector if necessary.

first_frame_path = fullfile(folder, files(1).name);
resized_first_frame_path = fullfile('resized/', 'pingpong.jpeg');
imwrite(imresize(imread(first_frame_path), [200, NaN]), 'resized/pingpong.jpeg');

%% Track interest points over sequence of frames.
result_path = 'feature_tracking_15_resized_pingpong.gif';
[H,r,c] = harris_corner_detector(resized_first_frame_path, 1.5, 1000,false,false,false);
r = r(:);
c = c(:);

for k = 1:length(files)-1
    current_frame = imread(fullfile(folder, files(k).name));
    current_frame = imresize(current_frame, [200, NaN]);
    
    next_frame = imread(fullfile(folder, files(k+1).name));
    next_frame = imresize(next_frame, [200, NaN]);
    [xs,ys,us,vs] = lucas_kanade(current_frame, next_frame, [r, c]);
    
    frame = getframe;
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    if k == 1
      imwrite(imind,cm,result_path,'gif', 'Loopcount',inf);
    else 
      imwrite(imind,cm,result_path,'gif','WriteMode','append');
    end
    
    r = r + vs;
    c = c + us;
end

disp('done');