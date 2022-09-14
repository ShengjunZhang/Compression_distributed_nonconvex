function [vec] = Unbiased_l_bits_quantizer(x, l)
    d = length(x);
    ptb = rand(d, 1);
    vec = (norm(x, Inf) / 2^(l - 1)) * sign(x) .*  floor(2^(l - 1) * abs(x) / norm(x, Inf) + ptb);
end