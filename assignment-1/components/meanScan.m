function [result] = meanScan(A)

B  = 1/9 ./ ones(3,3);

% the short way
result = conv2(A,B, 'valid');

% the long way
% for i = 2:size(A,1)-1
%     for j = 2:size(A,1)-1
%         window = A(i-1:i+1,j-1:j+1);
%         B(i-1,j-1) = mean(window(:));
%     end
% end
%  
%  result = B;
