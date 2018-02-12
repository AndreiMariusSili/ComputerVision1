function [result] = vectorStats(x)
% Return the mean, median, and stadard deviation of a vector

x_mean = mean(x);
x_median = median(x);
x_stddev = std(x);

result = [x_mean, x_median, x_stddev];

end