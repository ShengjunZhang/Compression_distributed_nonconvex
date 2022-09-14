function [vec] = Norm_sign(x)
    vec =  (norm(x, Inf) / 2) * sign(x);
end