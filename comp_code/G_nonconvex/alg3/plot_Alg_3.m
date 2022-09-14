%% Plot Algorithm 3 with different compressors

clear; clc; %close all;

iter_num = 1000;

load('DPDA.mat');
load('Alg_3_Unbiased_2_bits_quantizer.mat');
load('Alg_3_Greedy.mat');
load('Alg_3_Norm_sign.mat');
load('Alg_3_Std_uniform_quantizer.mat');
load('Alg_3_single_bit_binary_quantizer.mat');

%% loss vs iteration
figure;
semilogy(p_DPDA, '-', 'LineWidth', 2); hold on;
semilogy(p_Alg_3_Unbiased_2_bits_quantizer, '-', 'LineWidth', 2);
semilogy(p_Alg_3_Greedy, '-', 'LineWidth', 2);
semilogy(p_Alg_3_Norm_sign, '-', 'LineWidth', 2);
semilogy(p_Alg_3_Std_uniform_quantizer, '-', 'LineWidth', 2);
semilogy(p_Alg_3_single_bit_binary_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xticks(0:2000:iter_num);
xlabel('Number of communication rounds','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'DPDA', ...
        'Alg-3 Unbiased 2-bits quantizer', ...
        'Alg-3 Greedy', ...
        'Alg-3 Norm-sign', ...
        'Alg-3 Standard uniform quantizer', ...
        'Alg-3 1-bit binary quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');

%% Transmit plot all

figure;

semilogy(transmit_DPDA, p_DPDA, '-', 'LineWidth', 2); hold on;
semilogy(transmit_Alg_3_Unbiased_2_bits_quantizer, p_Alg_3_Unbiased_2_bits_quantizer, '-', 'LineWidth', 2);
semilogy(transmit_Alg_3_Greedy, p_Alg_3_Greedy, '-', 'LineWidth', 2);
semilogy(transmit_Alg_3_Norm_sign, p_Alg_3_Norm_sign, '-', 'LineWidth', 2);
semilogy(transmit_Alg_3_Std_uniform_quantizer, p_Alg_3_Std_uniform_quantizer, '-', 'LineWidth', 2);
semilogy(transmit_Alg_3_single_bit_binary_quantizer, p_Alg_3_single_bit_binary_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'DPDA', ...
        'Alg-3 Unbiased 2-bits quantizer', ...
        'Alg-3 Greedy', ...
        'Alg-3 Norm-sign', ...
        'Alg-3 Standard uniform quantizer', ...
        'Alg-3 1-bit binary quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');
   
%% Transmit plot around 100000 transmitting

figure;

semilogy(transmit_DPDA(1:32), p_DPDA(1:32), '-', 'LineWidth', 2); hold on;
semilogy(transmit_Alg_3_Unbiased_2_bits_quantizer(1:468), p_Alg_3_Unbiased_2_bits_quantizer(1:468), '-', 'LineWidth', 2);
semilogy(transmit_Alg_3_Greedy(1:79), p_Alg_3_Greedy(1:79), '-', 'LineWidth', 2);
semilogy(transmit_Alg_3_Norm_sign(1:610), p_Alg_3_Norm_sign(1:610), '-', 'LineWidth', 2);
semilogy(transmit_Alg_3_Std_uniform_quantizer(1:926), p_Alg_3_Std_uniform_quantizer(1:926), '-', 'LineWidth', 2);
semilogy(transmit_Alg_3_single_bit_binary_quantizer, p_Alg_3_single_bit_binary_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'DPDA', ...
        'Alg-3 Unbiased 2-bits quantizer', ...
        'Alg-3 Greedy', ...
        'Alg-3 Norm-sign', ...
        'Alg-3 Standard uniform quantizer', ...
        'Alg-3 1-bit binary quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');