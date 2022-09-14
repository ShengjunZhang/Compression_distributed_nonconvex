function [performance_compare, x_agent, x_bar] = EXTRA(x0, n_agents, gc1, gc2, gc3, gc4, gc5, G_gf, W_EXTRA, W_EXTRA_tilde, T, alpha_EXTRA)

    fprintf('Starting EXTRA ... \n');
    
    x_agent = zeros(n_agents, T);
    x_bar = sum(x_agent) / n_agents;
    performance_compare = zeros(1, T);
    x_agent(:, 1) = x0;
    gs = zeros(n_agents, 1);
    gs_prev = zeros(n_agents, 1);
    gs(1) = gc1(x0(1));
    gs(2) = gc2(x0(2));
    gs(3) = gc3(x0(3));
    gs(4) = gc4(x0(4));
    gs(5) = gc5(x0(5));
    
    
    x1 = W_EXTRA * x0 - alpha_EXTRA * gs;
    x_agent(:, 2) = x1;
    
    gs_prev(1) = gc1(x0(1));
    gs_prev(2) = gc2(x0(2));
    gs_prev(3) = gc3(x0(3));
    gs_prev(4) = gc4(x0(4));
    gs_prev(5) = gc5(x0(5));
    
    gs(1) = gc1(x1(1));
    gs(2) = gc2(x1(2));
    gs(3) = gc3(x1(3));
    gs(4) = gc4(x1(4));
    gs(5) = gc5(x1(5));
    
    W_ = eye(n_agents) + W_EXTRA;
    
    x_bar(1) = sum(x0) / n_agents;
    x_bar(2) = sum(x1) / n_agents;
    performance_compare(1) = (G_gf(x_bar(1)))^2 + norm(x0 - x_bar(1), 2)^2 / n_agents;
    performance_compare(2) = (G_gf(x_bar(2)))^2 + norm(x1 - x_bar(1), 2)^2 / n_agents;
    
    for t = 3:T
        
        x_agent(:, t) = W_ * x_agent(:, t-1) - W_EXTRA_tilde * x_agent(:, t-2) - alpha_EXTRA * (gs - gs_prev);
        
        x_iter = x_agent(:, t);
        
        gs_prev = gs;
        
        gs(1) = gc1(x_iter(1));
        gs(2) = gc2(x_iter(2));
        gs(3) = gc3(x_iter(3));
        gs(4) = gc4(x_iter(4));
        gs(5) = gc5(x_iter(5));
        
        x_bar(t) = sum(x_iter) / n_agents;
        performance_compare(t) = (G_gf(x_bar(t)))^2 + norm(x_iter - x_bar(t), 2)^2 / n_agents;


    end
    
end