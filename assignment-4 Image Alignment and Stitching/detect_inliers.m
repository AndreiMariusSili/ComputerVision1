function [inliers_count, inliers] = detect_inliers(second_points, translated_first_points)
    inliers_count = 0;
    inliers = [];
    for i = 1:size(second_points,2)
        distance = pdist([second_points(1,i),second_points(2,i); translated_first_points(1,i),translated_first_points(2,i)],'euclidean');
        if distance < 10
            inliers_count =  inliers_count + 1;
            inliers = [inliers, i];
        end
    end
end