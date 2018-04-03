function [avg_prec] = compute_average_precision(targets, dec_vals)
    
    % Turn negative values to 0 for targets. This is needed for the
    % cumulative sum.
    targets(targets == -1) = 0;
    % Sort targets based on predict probability estimates.
    [~, sorted_indices] = sort(dec_vals, 'descend');
    sorted_targets = targets(sorted_indices);
    
    % Calculate average precision.
    m_c = sum(targets);
    n = length(targets);
    i = 1:n;
    
    avg_prec = cumsum(sorted_targets)' ./ i;
    avg_prec(sorted_targets == 0) = 0;
    avg_prec = sum(avg_prec) / m_c;
end