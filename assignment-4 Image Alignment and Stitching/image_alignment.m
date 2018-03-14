%% question 1.1
boat1 = imread('./boat1.pgm');
boat2 = imread('./boat2.pgm');
[f1,d1,f2,d2,matches,scores] = keypoint_matching(boat1,boat2);

%% question 1.2
perm = randperm(size(matches, 2)) ;
selected_matches = matches(:,perm(1:50));
plot_images(boat1,boat2, f1(1,selected_matches(1,:)), f1(2,selected_matches(1,:)), f2(1,selected_matches(2,:)), f2(2,selected_matches(2,:)));

%% question 1.3 
boat1 = imread('./boat1.pgm');
boat2 = imread('./boat2.pgm');

[m1, m2, m3, m4, t1, t2, ~] = RANSAC(boat2,boat1, 0.9999, false);

I = boat1;
K = boat2;
J = transform(I, m1, m2, m3, m4, t1, t2, 'matlab');
figure, imshow(I)
figure, imshow(J)
figure, imshow(K)

%% question 2.2
boat1 = imread('./boat1.pgm');
boat2 = imread('./boat2.pgm');
best = zeros(25, 2);

c = 1;
for t =1:10
    for N = 1:5
        [m1, m2, m3, m4, t1, t2, best_inliers_count] = RANSAC(boat2,boat1, N);
        best(c, :) = [N, best_inliers_count];
        c = c+1;
    end
end
scatter(best(:,1), best(:, 2))