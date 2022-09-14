function [vec] = Single_bit_binary_quantizer(x)
    x(x >= 0) = 0.5;
    x(x < 0) = -0.5;
    vec = x;
end