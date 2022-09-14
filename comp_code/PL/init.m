%% This code is used for response to the simulation comments from the reviewers
% 
% In this example, we demostrate the convergence of the proposed algorithms
% under the condition where the global cost function satisfies the PL
% condition. The global cost function is x^2 + 3sin(x)^2, which is given
% and verfied in the following paper: 
%
% Linear Convergence of Gradient and Proximal-Gradient Methods Under the 
% Polyak-Łojasiewicz Condition (https://arxiv.org/abs/1608.04636)
% 

%% Generate the graph randomly
n = 5;                      % agent number
radius = 0.4;               % radius parameter
d = 1;                      % dimension of the problem

[Adj, degree, num_of_edge, A, B, D, Lm, edge_index, eig_Lm, min_eig_Lm, ...
 WW, LN, L_hat, eig_L_hat, min_eig_L_hat] = Generate_Graph(n, radius, d);

[W_small, L_small] = transform_graph(Adj, n);

W_aug = sparse(kron(W_small, eye(d)));
L_aug = sparse(kron(L_small, eye(d)));

%% Generate local cost functions

cf1 = @(x) x^2;
cf2 = @(x) x^2 - sin(x);
cf3 = @(x) -x^2;
cf4 = @(x) sin(x);
cf5 = @(x) 3*sin(x)^2;

%% Generate gradients of local cost functions

gc1 = @(x) 2*x;
gc2 = @(x) 2*x - cos(x);
gc3 = @(x) -2*x;
gc4 = @(x) cos(x);
gc5 = @(x) 6*sin(x)*cos(x);

%% Global fucntion and its gradient

G_f = @(x) x^2 + 3*sin(x)^2;
G_gf = @(x) 2*x + 6*sin(x)*cos(x);