function [ albedo, normal ] = estimate_alb_nrm( image_stack, scriptV, shadow_trick)
%COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving
%   	linear equations
%   albedo : the surface albedo
%   normal : the surface normal


[h, w, n, c] = size(image_stack);
if nargin == 2
    shadow_trick = true;
end

% create arrays for 
%   albedo (1 channel)
%   normal (3 channels)
albedo = zeros(h, w, c);
normal = zeros(h, w, 3);

% =========================================================================
% YOUR CODE GOES HERE
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|

% warning('off','all')
for row = 1:h
    for col = 1:w
        for channel = 1:c
            i = image_stack(row, col, :, channel);
            i = i(:);
            if shadow_trick == true
                scriptI = diag(i);
                g = linsolve(scriptI * scriptV, scriptI * i);
            else
                g = linsolve(scriptV, i);
            end
            albedo(row, col, channel) = norm(g);
            nn = (g / norm(g));
            nn(isnan(nn)) = 0;
            normal(row, col, :) = squeeze(normal(row, col,:)) + nn;
        end
    end
end
normal = normal ./ 3;
% warning('on','all')
disp('Done..');

% =========================================================================

end

