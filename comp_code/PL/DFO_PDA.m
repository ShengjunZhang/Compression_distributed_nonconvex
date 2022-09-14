function [performance_compare, x_agent, x_bar, transmit] = DFO_PDA(x0, n_agents, gc1, gc2, gc3, gc4, gc5, G_gf, L_aug, T)
    fprintf('Starting DFO_PDA ... \n');
    b = 64; 
    d = 5;
    x_agent = zeros(n_agents, T);
    x_bar = sum(x_agent) / n_agents;
    performance_compare = zeros(1, T);
    transmit = zeros(T, 1);
    x_agent(:, 1) = x0;
    
    gs = zeros(n_agents, 1);
    vs = zeros(n_agents, 1);
    
    eta = 0.03;
    alpha = 10;
    beta = 9;
    
    for t = 1:T
        
        x_iter = x_agent(:, t);
        
        gs(1) = gc1(x_iter(1));
        gs(2) = gc2(x_iter(2));
        gs(3) = gc3(x_iter(3));
        gs(4) = gc4(x_iter(4));
        gs(5) = gc5(x_iter(5));

        x_iter = x_iter - eta * ( alpha * L_aug * x_iter + beta*vs + gs);
        vs = vs + eta * beta * L_aug * x_iter;
        
        x_bar(t) = sum(x_iter) / n_agents;
        performance_compare(t) = (G_gf(x_bar(t)))^2 + norm(x_iter - x_bar(t), 2)^2 / n_agents;
        x_agent(:, t+1) = x_iter;
        transmit(t+1) = transmit(t) + 2*b*d;

    end
    
end