function [ p, q, SE ] = check_integrability( normals )
%CHECK_INTEGRABILITY check the surface gradient is acceptable
%   normals: normal image
%   p : df / dx
%   q : df / dy
%   SE : Squared Errors of the 2 second derivatives

% initalization
p = zeros(size(normals));
q = zeros(size(normals));
SE = zeros(size(normals));

% ========================================================================
% YOUR CODE GOES HERE
% Compute p and q, where
% p measures value of df / dx
% q measures value of df / dy

p = normals(:,:,1)./normals(:,:,3);
q = normals(:,:,2)./normals(:,:,3);

% ========================================================================



p(isnan(p)) = 0;
q(isnan(q)) = 0;



% ========================================================================
% YOUR CODE GOES HERE
% approximate second derivate by neighbor difference
% and compute the Squared Errors SE of the 2 second derivatives SE

% Adding an extra row so that "show_results(albedo, normals, SE);" runs is
% probably a hack. I don't know yet.
ones_row = ones(1, size(SE, 1)); 
SE =[ones_row; (diff(p) - diff(q)).^2 ];

% ========================================================================




end

