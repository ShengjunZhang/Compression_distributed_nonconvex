%% Plot Algorithm 1 with different compressors

clear; clc; %close all;

load('DPDA.mat');
load('Alg_1_Unbiased_2_bits_quantizer.mat');
load('Alg_1_Greedy.mat');
load('Alg_1_Norm_sign.mat');
load('Alg_1_single_bit_binary_quantizer.mat');
load('Alg_1_Std_uniform_quantizer_8_bit.mat');

iter_num=1000;
%%
figure;
semilogy(p_DPDA(1:iter_num), '-', 'LineWidth', 2); hold on;
semilogy(p_Alg_1_Unbiased_2_bits_quantizer(1:iter_num), '-', 'LineWidth', 2);
semilogy(p_Alg_1_Greedy(1:iter_num), '-', 'LineWidth', 2);
semilogy(p_Alg_1_Norm_sign(1:iter_num), '-', 'LineWidth', 2);
semilogy(p_Alg_1_Std_uniform_quantizer_8_bit(1:iter_num), '-', 'LineWidth', 2);
semilogy(p_Alg_1_single_bit_binary_quantizer(1:iter_num), '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xticks(0:200:iter_num);
xlabel('Number of communication rounds','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'DPDA', ...
        'Alg-1 Unbiased 2-bits quantizer', ...
        'Alg-1 Greedy', ...
        'Alg-1 Norm-sign', ...
        'Alg-1 Standard uniform quantizer 8 bit', ...
        'Alg-1 1-bit binary quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');

%% Transmit plot all

figure;

semilogy(transmit_DPDA, p_DPDA, '-', 'LineWidth', 2); hold on;
semilogy(transmit_Alg_1_Unbiased_2_bits_quantizer(1:iter_num), p_Alg_1_Unbiased_2_bits_quantizer(1:iter_num), '-', 'LineWidth', 2);
semilogy(transmit_Alg_1_Greedy, p_Alg_1_Greedy, '-', 'LineWidth', 2);
semilogy(transmit_Alg_1_Norm_sign, p_Alg_1_Norm_sign, '-', 'LineWidth', 2);
semilogy(transmit_Alg_1_Std_uniform_quantizer_8_bit, p_Alg_1_Std_uniform_quantizer_8_bit, '-', 'LineWidth', 2);
semilogy(transmit_Alg_1_single_bit_binary_quantizer, p_Alg_1_single_bit_binary_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'DPDA', ...
        'Alg-1 Unbiased 2-bits quantizer', ...
        'Alg-1 Greedy', ...
        'Alg-1 Norm-sign', ...
        'Alg-1 Standard uniform quantizer 8 bit', ...
        'Alg-1 1-bit binary quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');
   
%% Transmit plot around 100000 transmitting bits

figure;

semilogy(transmit_DPDA(1:16), p_DPDA(1:16), '-', 'LineWidth', 2); hold on;
semilogy(transmit_Alg_1_Unbiased_2_bits_quantizer(1:234), p_Alg_1_Unbiased_2_bits_quantizer(1:234), '-', 'LineWidth', 2);
semilogy(transmit_Alg_1_Greedy(1:157), p_Alg_1_Greedy(1:157), '-', 'LineWidth', 2);
semilogy(transmit_Alg_1_Norm_sign(1:305), p_Alg_1_Norm_sign(1:305), '-', 'LineWidth', 2);
semilogy(transmit_Alg_1_Std_uniform_quantizer_8_bit(1:463), p_Alg_1_Std_uniform_quantizer_8_bit(1:463), '-', 'LineWidth', 2);
semilogy(transmit_Alg_1_single_bit_binary_quantizer, p_Alg_1_single_bit_binary_quantizer, '-', 'LineWidth', 2);

set(gca,'FontSize', 10);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'DPDA', ...
        'Alg-1 Unbiased 2-bits quantizer', ...
        'Alg-1 Greedy', ...
        'Alg-1 Norm-sign', ...
        'Alg-1 Standard uniform quantizer 8 bit', ...
        'Alg-1 1-bit binary quantizer';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');