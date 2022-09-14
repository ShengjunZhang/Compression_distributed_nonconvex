%% This code is used for the reponse of TAC PLC compressor
clear; clc; close all;

%% initializing

init;

x_init = ones(n, 1);
T = 3000;

%% Performing algorithms

% DPDA
[performance_compare_DFO_PDA, x_agent_DFO_PDA, x_bar_DFO_PDA, transmit_DFO_PDA] = DFO_PDA(x_init, n, gc1, gc2, gc3, gc4, gc5, G_gf, L_aug, T);

%% Alg_1 with Compressors

% Alg_1 C1
[performance_compare_Alg1_C1, x_agent_Alg1_C1, x_bar_Alg1_C1, transmit_Alg1_C1] = Alg1_C1(x_init, n, gc1, gc2, gc3, gc4, gc5, G_gf, L_aug, T);

% Alg_1 C2
kG = 1;
[performance_compare_Alg1_C2, x_agent_Alg1_C2, x_bar_Alg1_C2, transmit_Alg1_C2] = Alg1_C2(x_init, n, gc1, gc2, gc3, gc4, gc5, G_gf, L_aug, T, kG);

% Alg_1 C3
[performance_compare_Alg1_C3, x_agent_Alg1_C3, x_bar_Alg1_C3, transmit_Alg1_C3] = Alg1_C3(x_init, n, gc1, gc2, gc3, gc4, gc5, G_gf, L_aug, T);

%% Alg_2 with Compressors

% Alg_2 C2
kG = 1;
[performance_compare_Alg2_C2, x_agent_Alg2_C2, x_bar_Alg2_C2, transmit_Alg2_C2] = Alg2_C2(x_init, n, gc1, gc2, gc3, gc4, gc5, G_gf, L_aug, T, kG);

% Alg_2 C3
[performance_compare_Alg2_C3, x_agent_Alg2_C3, x_bar_Alg2_C3, transmit_Alg2_C3] = Alg2_C3(x_init, n, gc1, gc2, gc3, gc4, gc5, G_gf, L_aug, T);
%% Alg_3 with Compressors

% Alg_3 C2
kG = 1;
[performance_compare_Alg3_C2, x_agent_Alg3_C2, x_bar_Alg3_C2, transmit_Alg3_C2] = Alg3_C2(x_init, n, gc1, gc2, gc3, gc4, gc5, G_gf, L_aug, T, kG);

% Alg_3 C3
[performance_compare_Alg3_C3, x_agent_Alg3_C3, x_bar_Alg3_C3, transmit_Alg3_C3] = Alg3_C3(x_init, n, gc1, gc2, gc3, gc4, gc5, G_gf, L_aug, T);

% Alg_3 C4
[performance_compare_Alg3_C4, x_agent_Alg3_C4, x_bar_Alg3_C4, transmit_Alg3_C4] = Alg3_C4(x_init, n, gc1, gc2, gc3, gc4, gc5, G_gf, L_aug, T);

% Alg_3 C5
[performance_compare_Alg3_C5, x_agent_Alg3_C5, x_bar_Alg3_C5, transmit_Alg3_C5] = Alg3_C5(x_init, n, gc1, gc2, gc3, gc4, gc5, G_gf, L_aug, T);


%% Plot
figure;
semilogy(performance_compare_DFO_PDA, '-', 'LineWidth', 2); hold on;
semilogy(performance_compare_Alg1_C1, '-', 'LineWidth', 2);
semilogy(performance_compare_Alg1_C2, '-', 'LineWidth', 2);
semilogy(performance_compare_Alg1_C3, '-', 'LineWidth', 2);
semilogy(performance_compare_Alg2_C2, '-', 'LineWidth', 2);
semilogy(performance_compare_Alg2_C3, '-', 'LineWidth', 2);
semilogy(performance_compare_Alg3_C2, '-', 'LineWidth', 2);
semilogy(performance_compare_Alg3_C3, '-', 'LineWidth', 2);
semilogy(performance_compare_Alg3_C4, '-', 'LineWidth', 2);
semilogy(performance_compare_Alg3_C5, '-', 'LineWidth', 2);


set(gca,'FontSize', 15);
xlabel('iterations','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$\|\nabla f(\bar{x}_k)\|^ {2}+\frac{1}{n}\sum_{i=1}^{n}\|x_{i,k}-\bar{x}_k\|^ {2}$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'DPDA', ...
        'Algorithm 1-$\mathcal{C}_1$', ...
        'Algorithm 1-$\mathcal{C}_2$', ...
        'Algorithm 1-$\mathcal{C}_3$', ...
        'Algorithm 2-$\mathcal{C}_2$', ...
        'Algorithm 2-$\mathcal{C}_3$', ...
        'Algorithm 3-$\mathcal{C}_2$', ...
        'Algorithm 3-$\mathcal{C}_3$', ...
        'Algorithm 3-$\mathcal{C}_4$', ...
        'Algorithm 3-$\mathcal{C}_5$';}, ...
       'Interpreter', 'latex', 'FontSize', 15, 'FontWeight','bold');


% legend({'Algorithm 1', ...
%         'EXTRA';}, ...
%        'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');

% figure;
% semilogy(x_bar_DFO_PDA.^2, '-', 'LineWidth', 2); hold on;
% semilogy(x_bar_Alg1_C1.^2, '-', 'LineWidth', 2);
% semilogy(x_bar_Alg1_C2.^2, '-', 'LineWidth', 2);
% semilogy(x_bar_Alg1_C3.^2, '-', 'LineWidth', 2);
% semilogy(x_bar_Alg2_C2.^2, '-', 'LineWidth', 2);
% semilogy(x_bar_Alg2_C3.^2, '-', 'LineWidth', 2);
% 
% set(gca,'FontSize', 15);
% xlabel('iterations','Interpreter', 'latex', ...
%         'FontSize', 15, 'FontWeight','bold');
% ylabel('$\|\bar{x}_k - x_{\textnormal{opt}}\|^ {2}$', 'Interpreter','latex', ...
%         'FontSize', 15, 'FontWeight','bold');
% legend({'DPDA', ...
%         ;}, ...
%        'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');
% 

%%

figure;
plot(transmit_DFO_PDA, 'LineWidth', 4);hold on
plot(transmit_Alg1_C1, '-', 'LineWidth', 2);
plot(transmit_Alg1_C2, '-', 'LineWidth', 2);
plot(transmit_Alg1_C3, '-', 'LineWidth', 2);
plot(transmit_Alg2_C2, '-', 'LineWidth', 2);
plot(transmit_Alg2_C3, '-', 'LineWidth', 2);
plot(transmit_Alg3_C2, '-', 'LineWidth', 2);
plot(transmit_Alg3_C3, '-', 'LineWidth', 2);
plot(transmit_Alg3_C4, '-', 'LineWidth', 2);
plot(transmit_Alg3_C5, '-', 'LineWidth', 2);
set(gca,'FontSize', 15);
xlabel('iterations','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('transmitited bits', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');

% 
% legend({'DPDA', ...
%         'alg1';}, ...
%        'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');