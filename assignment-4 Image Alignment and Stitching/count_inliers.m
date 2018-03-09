function [inliers_count] = count_inliers(first_points, translated_first_points)
    inliers_count = 0;
    for i = 1:size(first_points,2)
        distance = pdist([first_points(1,i),first_points(2,i); translated_first_points(1,i),translated_first_points(2,i)],'euclidean');
        if distance < 10 
            inliers_count =  inliers_count + 1;
        end
    end
end