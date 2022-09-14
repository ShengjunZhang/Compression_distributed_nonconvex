%% This code is used to run Algorithm 1 with different compressors.

clear; clc; close all;

load('opt_data.mat');
iter_num = 1000;


%% Alg_1_Unbiased_2_bits_quantizer

eta = 1.4;
alpha = 85;
beta = 5;
psi = 0.2;
iter_numC1 = 5000;
[xminuxbar_Alg_1_Unbiased_2_bits_quantizer, ...
 sq_grad_Alg_1_Unbiased_2_bits_quantizer,...
 transmit_Alg_1_Unbiased_2_bits_quantizer] = Alg_1_Unbiased_2_bits_quantizer(L_aug, ...
                                                                            y_temp, ...
                                                                            d, ...
                                                                            nodes_num, ...
                                                                            gc, ...
                                                                            function_lambda, ...
                                                                            function_aalpha, ...
                                                                            features, ...
                                                                            labels, ...
                                                                            batch_size, ...
                                                                            iter_numC1, ...
                                                                            eta, ...
                                                                            alpha, ...
                                                                            beta, ...
                                                                            psi);

n = nodes_num;
ef = n^2;

T = iter_numC1;
p_Alg_1_Unbiased_2_bits_quantizer = sq_grad_Alg_1_Unbiased_2_bits_quantizer/ef + xminuxbar_Alg_1_Unbiased_2_bits_quantizer/n;

for i=3:T
    p_Alg_1_Unbiased_2_bits_quantizer(i)=min(p_Alg_1_Unbiased_2_bits_quantizer(i-1:i));
end


figure;
semilogy(p_Alg_1_Unbiased_2_bits_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xticks(0:500:iter_numC1);
xlabel('Number of communication rounds','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-1 Unbiased 2-bits quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');



figure;
semilogy(transmit_Alg_1_Unbiased_2_bits_quantizer, p_Alg_1_Unbiased_2_bits_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-1 Unbiased 2-bits quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');
   
%% Alg_1_Greedy

eta = 1.4;
alpha = 85;
beta = 5;
psi = 0.05;
kG = 10;
iter_numC2 = 5000;
[xminuxbar_Alg_1_Greedy, ...
 sq_grad_Alg_1_Greedy,...
 transmit_Alg_1_Greedy] = Alg_1_Greedy(L_aug, ...
                                     y_temp, ...
                                     d, ...
                                     nodes_num, ...
                                     gc, ...
                                     function_lambda, ...
                                     function_aalpha, ...
                                     features, ...
                                     labels, ...
                                     batch_size, ...
                                     iter_numC2, ...
                                     eta, ...
                                     alpha, ...
                                     beta, ...
                                     psi, ...
                                     kG);

n = nodes_num;
ef = n^2;

T = iter_numC2;
p_Alg_1_Greedy = sq_grad_Alg_1_Greedy/ef + xminuxbar_Alg_1_Greedy/n;

for i=3:T
    p_Alg_1_Greedy(i)=min(p_Alg_1_Greedy(i-1:i));
end


figure;
semilogy(p_Alg_1_Greedy, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xticks(0:500:iter_numC2);
xlabel('Number of communication rounds','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-1 Greedy';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');



figure;
semilogy(transmit_Alg_1_Greedy, p_Alg_1_Greedy, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-1 Greedy';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');

%% Alg_1_single_bit_binary_quantizer

eta = 0.05;
alpha = 85;
beta = 5;
psi = 0.02;

[xminuxbar_Alg_1_single_bit_binary_quantizer, ...
 sq_grad_Alg_1_single_bit_binary_quantizer,...
 transmit_Alg_1_single_bit_binary_quantizer] = Alg_1_single_bit_binary_quantizer(L_aug, ...
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
                                     psi);

n = nodes_num;
ef = n^2;

T = iter_num;
p_Alg_1_single_bit_binary_quantizer = sq_grad_Alg_1_single_bit_binary_quantizer/ef + xminuxbar_Alg_1_single_bit_binary_quantizer/n;

for i=3:T
    p_Alg_1_single_bit_binary_quantizer(i)=min(p_Alg_1_single_bit_binary_quantizer(i-1:i));
end


figure;
semilogy(p_Alg_1_single_bit_binary_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xticks(0:200:iter_num);
xlabel('Number of communication rounds','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-1 1-bit binary quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');



figure;
semilogy(transmit_Alg_1_single_bit_binary_quantizer, p_Alg_1_single_bit_binary_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-1 1-bit binary quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');
   
%% Alg_1_Std_uniform_quantizer this is 8 bit.

eta = 1.6;
alpha = 85;
beta = 5;
psi = 0.2;
delta = 1;

[xminuxbar_Alg_1_Std_uniform_quantizer, ...
 sq_grad_Alg_1_Std_uniform_quantizer,...
 transmit_Alg_1_Std_uniform_quantizer] = Alg_1_Std_uniform_quantizer(L_aug, ...
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
                                     psi, ...
                                     delta);

n = nodes_num;
ef = n^2;

T = iter_num;
p_Alg_1_Std_uniform_quantizer = sq_grad_Alg_1_Std_uniform_quantizer/ef + xminuxbar_Alg_1_Std_uniform_quantizer/n;

for i=3:T
    p_Alg_1_Std_uniform_quantizer(i)=min(p_Alg_1_Std_uniform_quantizer(i-1:i));
end


figure;
semilogy(p_Alg_1_Std_uniform_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xticks(0:200:iter_num);
xlabel('Number of communication rounds','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-1 Standard uniform quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');



figure;
semilogy(transmit_Alg_1_Std_uniform_quantizer, p_Alg_1_Std_uniform_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-1 Standard uniform quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');

%% Alg_1_Norm_sign

eta = 1.3;
alpha = 85;
beta = 5;
psi = 0.05;
iter_numC3=5000;
[xminuxbar_Alg_1_Norm_sign, ...
 sq_grad_Alg_1_Norm_sign,...
 transmit_Alg_1_Norm_sign] = Alg_1_Norm_sign(L_aug, ...
                                     y_temp, ...
                                     d, ...
                                     nodes_num, ...
                                     gc, ...
                                     function_lambda, ...
                                     function_aalpha, ...
                                     features, ...
                                     labels, ...
                                     batch_size, ...
                                     iter_numC3, ...
                                     eta, ...
                                     alpha, ...
                                     beta, ...
                                     psi);

n = nodes_num;
ef = n^2;

T = iter_numC3;
p_Alg_1_Norm_sign = sq_grad_Alg_1_Norm_sign/ef + xminuxbar_Alg_1_Norm_sign/n;

for i=3:T
    p_Alg_1_Norm_sign(i)=min(p_Alg_1_Norm_sign(i-1:i));
end


figure;
semilogy(p_Alg_1_Norm_sign, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xticks(0:500:iter_numC3);
xlabel('Number of communication rounds','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-1 Norm-sign';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');



figure;
semilogy(transmit_Alg_1_Norm_sign, p_Alg_1_Norm_sign, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'Alg-1 Norm-sign';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');