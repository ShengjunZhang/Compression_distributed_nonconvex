%% This is used to test different communication compressors

clear; clc; close all;
rng('default');
s = rng;
d = 50;
x_test = -5 + (5+5) * rand(d,1);
x_test(33) = 0;
%% Unbiased l-bits quantizer
% Linear Convergent Decentralized Optimization with Compression 
% https://arxiv.org/abs/2007.00232

l = 2;

ptb = rand(d, 1);

C_1 = @(x) (norm(x, Inf) / 2^(l - 1)) * sign(x) .*  floor(2^(l - 1) * abs(x) / norm(x, Inf) + ptb);
test_C_1 = C_1(x_test);

%% Greedy(Top-k) sparsifier
% On Biased Compression for Distributed Learning
% https://arxiv.org/abs/2002.12410

k = 4;

x_test_2 = sort(x_test, 'descend', 'ComparisonMethod', 'abs');

x_test_2 = x_test_2(1 : k);
x_temp = zeros(d, 1);

for j = 1:k
    target = x_test_2(j);
    for i = 1: d
        if x_test(i) == target
           x_temp(i) = target;
        end 
    end
    j = j+1;
end 


%% Norm-sign compressor
% Compressed Gradient Tracking Methods for Decentralized Optimization with Linear Convergence
% http://export.arxiv.org/abs/2103.13748

C_3 = @(x) (norm(x, Inf) / 2) * sign(x);
test_C_3 = C_3(x_test);

%% Standard uniform quantizer

delta = 1;

C_4 = @(x) delta * floor(x/delta + ones(d, 1)/2);
test_C_4 = C_4(x_test);

%% 1-bit quantizer
% Innovation Compression for Communication-efficient Distributed Optimization with Linear Convergence
% https://arxiv.org/abs/2105.06697

test_C_5 = C_5(x_test);

function vec = C_5(x)
    x(x>=0) = 0.5;
    x(x<0) = -0.5;
    vec = x;
end

