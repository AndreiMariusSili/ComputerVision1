function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface


if nargin == 2
    path_type = 'column';
end

[h, w] = size(p);
height_map = zeros(h, w);

switch path_type
    case 'column'
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value
        
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        
        % I believe that in the above algorithm, q should be switched with
        % q(or there has been an misunderstanding regarding the vector space 
        % and the used axes); the following line is the implementation of the 
        % above algorithm, but with q and p switched.
        height_map = cumsum(q,2) + cumsum(p(:,1)) - p(1,1) - q(:,1);
       
        % =================================================================
               
    case 'row'
        
        % =================================================================
        % YOUR CODE GOES HERE
        

        % =================================================================
          
    case 'average'
        
        % =================================================================
        % YOUR CODE GOES HERE

        
        % =================================================================
end


end

