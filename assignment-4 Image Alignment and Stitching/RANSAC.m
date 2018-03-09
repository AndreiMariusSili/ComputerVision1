function [m1, m2, m3, m4, t1, t2] = RANSAC(img1,img2, N,P)
    
    if nargin == 2
        N = 50;
        P = 50;
    end
    if nargin == 3
        P = 50;
    end

    [f1,d1,f2,d2,matches,scores] = keypoint_matching(img1,img2);

    best_inliers = 0;
    best_transformation = [];
    for i  = 1:N
        perm = randperm(size(matches, 2)) ;
        selected_matches = matches(:,perm(1:P));

        first_points = f1(:, selected_matches(1,:));
        first_points = first_points(1:2,:);
        second_points = f2(:,selected_matches(2,:));
        second_points = second_points(1:2,:);

        A = [];
        b = [];
        for j= 1:size(first_points,2)
            A = [A; first_points(1,j) first_points(2,j) 0 0 1 0; 0 0 first_points(1,j) first_points(2,j) 0 1];
            b = [b; second_points(1,j); second_points(2,j)];
        end

        result = num2cell(pinv(A)*b);
        [m1, m2, m3, m4, t1, t2] = result{:};

        translated_first_points= [m1 m2; m3 m4] * [first_points(1,:); first_points(2,:)] + [t1;t2];

    %     plot_images(boat1,boat2, first_points(1,:), first_points(2,:), translated_first_points(1,:), translated_first_points(2,:));

        inliers_count = count_inliers(first_points, translated_first_points);

        if inliers_count > best_inliers
            best_inliers = inliers_count;
            best_transformation = [m1, m2, m3, m4, t1, t2];
        end

    end
    
    m1=best_transformation(1);
    m2=best_transformation(2);
    m3=best_transformation(3);
    m4=best_transformation(4);
    t1=best_transformation(5);
    t2=best_transformation(6);
    
end