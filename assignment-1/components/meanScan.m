function [result] = meanScan(A)

B = zeros(size(A,1)-2, size(A,2)-2);

for i = 2:size(A,1)-1
    for j = 2:size(A,1)-1
        window = A(i-1:i+1,j-1:j+1);
        B(i-1,j-1) = mean(window(:));
    end
end

result = B;
