function [m1, m2, m3, m4, t1, t2] = solve_least_squares(selected_first_points, selected_second_points)
    A = zeros(2*size(selected_first_points,2), 6);
    b = zeros(2*size(selected_first_points,2), 1);
    for j=1:size(selected_first_points,2)
        A(j*2-1,:) = [selected_first_points(1,j) selected_first_points(2,j) 0 0 1 0];
        A(j*2,:) = [0 0 selected_first_points(1,j) selected_first_points(2,j) 0 1];
        b(j*2-1,1) = selected_second_points(1,j);
        b(j*2,1) = selected_second_points(2,j);
    end

    result = num2cell(pinv(A)*b);
    [m1, m2, m3, m4, t1, t2] = result{:};
end