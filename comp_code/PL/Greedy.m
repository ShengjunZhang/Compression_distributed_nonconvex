function [vec] = Greedy(x, k)
    d = length(x);
    x_temp = sort(x, 'descend', 'ComparisonMethod', 'abs');
    x_temp = x_temp(1:k);
    vec = zeros(d, 1);
    for j = 1:k
        target = x_temp(j);
        for i = 1: d
            if x(i) == target
                vec(i) = target;
            end 
        end
    end
end