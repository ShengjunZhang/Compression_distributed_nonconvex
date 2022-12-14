%% This code is used to run Algorithm 3 with different compressors.

clear; clc; close all;

load('opt_data.mat');
iter_num = 1000;

%% Alg_3_Greedy

eta = 0.46;
alpha = 85;
beta = 5;
s0 = 1; % 20, 30
gamma = 0.99;

kG = 10;

[xminuxbar_Alg_3_Greedy, ...
 sq_grad_Alg_3_Greedy,...
 transmit_Alg_3_Greedy] = Alg_3_Greedy(L_aug, ...
                                     y_temp, ...
                                     d, ...
                                     nodes_num, ...
                                     gc, ...
                                     function_lambda, ...
                                     function_aalpha, ...
                                     features, ...
                                     labels, ...
                                     batch_size, ...
                                     iter_num, ...
                                     eta, ...
                                     alpha, ...
                                     beta, ...
                                     s0, ...
                                     gamma, ...
                                     kG);

n = nodes_num;
ef = n^2;

T = iter_num;
p_Alg_3_Greedy = sq_grad_Alg_3_Greedy/ef + xminuxbar_Alg_3_Greedy/n;

for i=3:T
    p_Alg_3_Greedy(i)=min(p_Alg_3_Greedy(i-1:i));
end


figure;
semilogy(p_Alg_3_Greedy, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xticks(0:200:iter_num);
xlabel('Number of communication rounds','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-3 Greedy';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');



figure;
semilogy(transmit_Alg_3_Greedy, p_Alg_3_Greedy, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-3 Greedy';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold'); 


%% Alg_3_single_bit_binary_quantizer

eta = 0.46;
alpha = 85;
beta = 5;
s0 = 1;
gamma = 0.99;

[xminuxbar_Alg_3_single_bit_binary_quantizer, ...
 sq_grad_Alg_3_single_bit_binary_quantizer,...
 transmit_Alg_3_single_bit_binary_quantizer] = Alg_3_single_bit_binary_quantizer(L_aug, ...
                                     y_temp, ...
                                     d, ...
                                     nodes_num, ...
                                     gc, ...
                                     function_lambda, ...
                                     function_aalpha, ...
                                     features, ...
                                     labels, ...
                                     batch_size, ...
                                     iter_num, ...
                                     eta, ...
                                     alpha, ...
                                     beta, ...
                                     s0, ...
                                     gamma);

n = nodes_num;
ef = n^2;

T = iter_num;
p_Alg_3_single_bit_binary_quantizer = sq_grad_Alg_3_single_bit_binary_quantizer/ef + xminuxbar_Alg_3_single_bit_binary_quantizer/n;

for i=3:T
    p_Alg_3_single_bit_binary_quantizer(i)=min(p_Alg_3_single_bit_binary_quantizer(i-1:i));
end


figure;
semilogy(p_Alg_3_single_bit_binary_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xticks(0:200:iter_num);
xlabel('Number of communication rounds','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-3 1-bit binary quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');



figure;
semilogy(transmit_Alg_3_single_bit_binary_quantizer, p_Alg_3_single_bit_binary_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-3 1-bit binary quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');
   
%% Alg_3_Std_uniform_quantizer 8 bit

eta = 0.46; % 0.05
alpha = 85;
beta = 5;
s0 = 0.01;
gamma = 0.99;

delta = 1;

[xminuxbar_Alg_3_Std_uniform_quantizer, ...
 sq_grad_Alg_3_Std_uniform_quantizer,...
 transmit_Alg_3_Std_uniform_quantizer] = Alg_3_Std_uniform_quantizer(L_aug, ...
                                     y_temp, ...
                                     d, ...
                                     nodes_num, ...
                                     gc, ...
                                     function_lambda, ...
                                     function_aalpha, ...
                                     features, ...
                                     labels, ...
                                     batch_size, ...
                                     iter_num, ...
                                     eta, ...
                                     alpha, ...
                                     beta, ...
                                     s0, ...
                                     gamma, ...
                                     delta);

n = nodes_num;
ef = n^2;

T = iter_num;
p_Alg_3_Std_uniform_quantizer = sq_grad_Alg_3_Std_uniform_quantizer/ef + xminuxbar_Alg_3_Std_uniform_quantizer/n;

for i=3:T
    p_Alg_3_Std_uniform_quantizer(i)=min(p_Alg_3_Std_uniform_quantizer(i-1:i));
end


figure;
semilogy(p_Alg_3_Std_uniform_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xticks(0:200:iter_num);
xlabel('Number of communication rounds','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-3 Standard uniform quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');



figure;
semilogy(transmit_Alg_3_Std_uniform_quantizer, p_Alg_3_Std_uniform_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-3 Standard uniform quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');

%% Alg_3_Norm_sign

eta = 0.3;
alpha = 85;
beta = 5;
s0 = 50;
gamma = 0.5;

[xminuxbar_Alg_3_Norm_sign, ...
 sq_grad_Alg_3_Norm_sign,...
 transmit_Alg_3_Norm_sign] = Alg_3_Norm_sign(L_aug, ...
                                     y_temp, ...
                                     d, ...
                                     nodes_num, ...
                                     gc, ...
                                     function_lambda, ...
                                     function_aalpha, ...
                                     features, ...
                                     labels, ...
                                     batch_size, ...
                                     iter_num, ...
                                     eta, ...
                                     alpha, ...
                                     beta, ...
                                     s0, ...
                                     gamma);

n = nodes_num;
ef = n^2;

T = iter_num;
p_Alg_3_Norm_sign = sq_grad_Alg_3_Norm_sign/ef + xminuxbar_Alg_3_Norm_sign/n;

for i=3:T
    p_Alg_3_Norm_sign(i)=min(p_Alg_3_Norm_sign(i-1:i));
end


figure;
semilogy(p_Alg_3_Norm_sign, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xticks(0:200:iter_num);
xlabel('Number of communication rounds','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-3 Norm-sign';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');



figure;
semilogy(transmit_Alg_3_Norm_sign, p_Alg_3_Norm_sign, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-3 Norm-sign';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold'); 

%% Alg_3_Unbiased_2_bits_quantizer

eta = 0.3;
alpha = 85;
beta = 5;
s0 = 50;
gamma = 0.5;

[xminuxbar_Alg_3_Unbiased_2_bits_quantizer, ...
 sq_grad_Alg_3_Unbiased_2_bits_quantizer,...
 transmit_Alg_3_Unbiased_2_bits_quantizer] = Alg_3_Unbiased_2_bits_quantizer(L_aug, ...
                                                                            y_temp, ...
                                                                            d, ...
                                                                            nodes_num, ...
                                                                            gc, ...
                                                                            function_lambda, ...
                                                                            function_aalpha, ...
                                                                            features, ...
                                                                            labels, ...
                                                                            batch_size, ...
                                                                            iter_num, ...
                                                                            eta, ...
                                                                            alpha, ...
                                                                            beta, ...
                                                                            s0, ...
                                                                            gamma);

n = nodes_num;
ef = n^2;

T = iter_num;
p_Alg_3_Unbiased_2_bits_quantizer = sq_grad_Alg_3_Unbiased_2_bits_quantizer/ef + xminuxbar_Alg_3_Unbiased_2_bits_quantizer/n;

for i=3:T
    p_Alg_3_Unbiased_2_bits_quantizer(i)=min(p_Alg_3_Unbiased_2_bits_quantizer(i-1:i));
end


figure;
semilogy(p_Alg_3_Unbiased_2_bits_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xticks(0:200:iter_num);
xlabel('Number of communication rounds','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-3 Unbiased 2-bits quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');



figure;
semilogy(transmit_Alg_3_Unbiased_2_bits_quantizer, p_Alg_3_Unbiased_2_bits_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-3 Unbiased 2-bits quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');