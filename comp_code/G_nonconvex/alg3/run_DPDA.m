%% This code is used to run DPDA

clear; clc; close all;

load('opt_data.mat');
iter_num = 1000;

%%
eta = 1;
alpha = 85;
beta = 5;

[xminuxbar_DPDA, sq_grad_DPDA, transmit_DPDA] = DPDA(L_aug, y_temp, d,nodes_num,gc,function_lambda,function_aalpha, features, labels,batch_size,iter_num, eta, alpha, beta);

%% Plot

n = nodes_num;
ef = n^2;

T = iter_num;
p_DPDA = sq_grad_DPDA/ef  +xminuxbar_DPDA/n;

for i=3:T
    p_DPDA(i)=min(p_DPDA(i-1:i));
end


figure;
semilogy(p_DPDA, '-', 'LineWidth', 2);

% ylim([1e-35, 1e0]);
set(gca,'FontSize', 10);
xticks(0:200:iter_num);
xlabel('Number of communication rounds','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'DPDA';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');

%% Transmit plot

figure;
T_trans = 938;
semilogy(transmit_DPDA(1:T_trans), p_DPDA(1:T_trans), '-', 'LineWidth', 2);

% ylim([1e-35, 1e0]);
set(gca,'FontSize', 10);
% xticks(0:200:iter_num);
xlabel('Number of transmitting','Interpreter', 'latex', ...
        'FontSize', 15, 'FontWeight','bold');
ylabel('$P(T)$', 'Interpreter','latex', ...
        'FontSize', 15, 'FontWeight','bold');
legend({'DPDA';}, ...
       'Interpreter', 'latex', 'FontSize', 10, 'FontWeight','bold');