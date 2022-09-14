%% This is used to show x^2 + 3sin(x)^2
% % This is from the following paper:
% % Linear Convergence of Gradient and Proximal-Gradient Methods Under the Polyak-Łojasiewicz Condition
% % https://arxiv.org/abs/1608.04636

clear; clc; close all;
x = -10 : 0.01: 10;

y = x.^2 + 3*sin(x).^2;
grad_y = 2.*x + 6.*sin(x).*cos(x);

varifying_value = (0.5 * grad_y.^2)./y;
mu = 1/32;
bound = mu.*ones(1, length(x));

figure;
plot(x, y , 'LineWidth', 2); hold on;
plot(x, grad_y  , 'LineWidth', 2); hold on;
title('Demo one function satisfying Polyak-$\L$ojasiewicz Condition function', ...
      'Interpreter', 'latex');
xlabel('$x$', 'Interpreter', 'latex');
ylabel('values', 'Interpreter', 'latex');
legend({'$y = x^{2} + 3\sin^{2} (x)$', '$\nabla y(x)$'}, ...
        'Interpreter', 'latex');

figure;
plot(x, varifying_value , 'LineWidth', 2); hold on;
plot(x, bound, 'LineWidth', 2);
title('Corresponding Polyak-$\L$ojasiewicz Condition', 'Interpreter', 'latex');
xlabel('$x$', 'Interpreter', 'latex');
ylabel('$\frac{\frac{1}{2}||\nabla f(x)||^{2}}{f(x)-f^{*}}$', ...
        'Interpreter', 'latex');
legend({'$\frac{\frac{1}{2}||\nabla f(x)||^{2}}{f(x)-f^{*}}$','$\mu$'}, ...
        'Interpreter', 'latex');