function [performance_compare, x_agent, x_bar, transmit] = Alg3_C2(x0, n_agents, gc1, gc2, gc3, gc4, gc5, G_gf, L_aug, T, kG)
    
    fprintf('Starting Alg3_C2 ... \n');
    iter_num = T;
    x_agent = zeros(n_agents, T);
    x_bar = sum(x_agent) / n_agents;
    performance_compare = zeros(1, T);
    x_agent(:, 1) = x0;

    transmit = zeros(iter_num, 1);
    gs = zeros(n_agents, 1);
    vs = zeros(n_agents, T);

    q_0 = zeros(n_agents, 1);
    b = 64; 
    x_hat = zeros(n_agents,iter_num);

    eta = 0.03;
    alpha = 10;
    beta = 9;


    for i = 1:n_agents
        q_0(i) = Greedy(x0(i), kG);
    end
    x_hat(:, 1) = x_hat(:, 1) + q_0;

    for t = 2:T

        x_iter = x_agent(:, t - 1);
        vs_iter = vs(:, t - 1);

        gs(1) = gc1(x_iter(1));
        gs(2) = gc2(x_iter(2));
        gs(3) = gc3(x_iter(3));
        gs(4) = gc4(x_iter(4));
        gs(5) = gc5(x_iter(5));

        x_iter = x_iter - eta * ( alpha * L_aug * ( x_hat(:, t) ) + beta*vs_iter + gs);
        vs(:, t) = vs_iter + eta * beta * L_aug * ( x_hat(:, t) );
        
        x_hat_temp = x_hat(:, t);
        for i = 1:n_agents
            q_0(i) = Greedy(x_iter(i) - x_hat_temp(i), kG);
        end
        x_hat(:, t+1) = x_hat(:, t) + q_0;

        x_bar(t) = sum(x_iter) / n_agents;

        performance_compare(t) = (G_gf(x_bar(t)))^2 + norm(x_iter - x_bar(t), 2)^2 / n_agents;
        x_agent(:, t) = x_iter;
        transmit(t) = transmit(t-1) + kG*b;
    end
    
end