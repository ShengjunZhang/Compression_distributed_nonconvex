function [vec] = Std_uniform_quantizer(x, delta)
    d = length(x);
    vec =  delta * floor(x/delta + ones(d, 1)/2);
end