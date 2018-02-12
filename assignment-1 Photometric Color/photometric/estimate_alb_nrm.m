function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal


[h, w, ~] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end

% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, 1);
normal = zeros(h, w, 3);

% =========================================================================
% YOUR CODE GOES HERE
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|

[X,Y] = meshgrid(1:w,1:h);
no_points = w*h;
    for index = 1:no_points
        i = image_stack(X(index),Y(index),:);
        i = i(:);
        if shadow_trick
            scriptI = diag(i);
            g = linsolve((scriptI*scriptV),(scriptI*i));
        else
            g = linsolve(scriptV,i);
        end
        albedo(Y(index),X(index)) = norm(g);
        normal(Y(index),X(index),:) = g/norm(g);
    end
    disp('Done..');

% =========================================================================

end

