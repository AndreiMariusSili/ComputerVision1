function [m1, m2, m3, m4, t1, t2, best_inliers_count] = RANSAC(img1,img2, p, plot)
    % Returns the transform from image 2 to image 1. So if you call imwarp
    % like imwarp(img2, T) you should get image 2 from the perspective of
    % image 1. In other words, the source is img2 and the target is img1 in 
    % this implementation. This is all because we are actually returning
    % the parameters for the inverse affine transform.
    % Check this out: http://www.cse.psu.edu/~rtc12/CSE486/lecture15.pdf 
    
    if nargin == 3
        plot = false;
    end

    [f1,~,f2,~,matches,~] = keypoint_matching(img1,img2);
    if p < 1
        n = size(matches, 2);
        s = 3;
        e = s/n;
        N = round(log(1-p)/log(1-(1-e)^s));
    else
        n = size(matches, 2);
        s = 3;
        e = s/n;
        N = p;
    end
    
    all_first_points = f1(:, matches(1,:));
    all_first_points = all_first_points(1:2,:);
    all_second_points = f2(:, matches(2,:));
    all_second_points = all_second_points(1:2,:);

    ransac_best_count = 0;
    for i  = 1:N
        perm = randperm(size(matches, 2));
        selected_matches = matches(:,perm(1:s));

        selected_first_points = f1(:, selected_matches(1,:));
        selected_first_points = selected_first_points(1:2,:);
        selected_second_points = f2(:,selected_matches(2,:));
        selected_second_points = selected_second_points(1:2,:);
        
        [m1, m2, m3, m4, t1, t2] = solve_least_squares(selected_first_points, selected_second_points);

        if plot
            translated_first_points= [m1 m2; m3 m4] * [selected_first_points(1,:); selected_first_points(2,:)] + [t1;t2];
            plot_images(img1,img2, selected_first_points(1,:), selected_first_points(2,:), translated_first_points(1,:), translated_first_points(2,:));
        end
        
        transformed_all_first_points = [m1 m2; m3 m4] * all_first_points + [t1;t2];

        [inliers_count, inliers] = detect_inliers(all_second_points, transformed_all_first_points);
        if inliers_count > ransac_best_count
            ransac_best_count = inliers_count;
            ransac_best_inliers = inliers;
        end
    end
    
    if ransac_best_count == 0
        m1=1;
        m2=0;
        m3=0;
        m4=1;
        t1=0;
        t2=0;
    else
        best_first_points = all_first_points(:, ransac_best_inliers);
        best_second_points = all_second_points(:, ransac_best_inliers);
        [m1, m2, m3, m4, t1, t2] = solve_least_squares(best_first_points, best_second_points);
        
        transformed_all_first_points = [m1 m2; m3 m4] * all_first_points + [t1;t2];
        [~, best_inliers] = detect_inliers(all_second_points, transformed_all_first_points);
        
        best_first_points = all_first_points(:, best_inliers);
        best_second_points = all_second_points(:, best_inliers);
        
        [m1, m2, m3, m4, t1, t2] = solve_least_squares(best_first_points, best_second_points);
        
        transformed_all_first_points = [m1 m2; m3 m4] * all_first_points + [t1;t2];
        [best_inliers_count, ~] = detect_inliers(all_second_points, transformed_all_first_points);
        
    end
    
end