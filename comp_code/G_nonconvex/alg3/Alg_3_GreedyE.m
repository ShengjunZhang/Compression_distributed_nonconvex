function [xminuxbar, sq_grad, transmit] = Alg_3_GreedyE(L_aug, x, dn,N,gc,lambda,aalpha, features, labels,bs, iter_num, eta, alpha, beta, s0, gamma, kG)
%for greedy compressor, it is not needed to use s_0 and gamma
    fprintf('Alg_3_Greedy\n');

    sq_grad = zeros(iter_num, 1);
    xminuxbar = zeros(iter_num, 1);
    transmit = zeros(iter_num, 1);
    
    b = 64; 
    v = zeros(dn*N, iter_num);
    
    x_hat = zeros(dn*N, iter_num);
    q_0 = zeros(dn*N, 1);
    
    x0 = reshape(x(:, 1), [dn, N]);
    
    for i = 1: N
        q_0( (i-1)*dn+1 : i*dn) = Greedy(x0(:, i), kG);
    end
    
    x_hat(:, 1) = x_hat(:, 1) + q_0;
    upd = textprogressbar(iter_num);
    
    for t = 2:iter_num
               
        upd(t);
        
        gradient = zeros(N*dn,1);
        
        for ii = 1 : N 
            for jj=(ii-1)*bs+1:ii*bs 
                gradient((ii-1)*dn+1:ii*dn) = gradient((ii-1)*dn+1:ii*dn) + gc(x((ii-1)*dn+1:ii*dn,t-1),lambda,aalpha, features(:,jj), labels(jj),bs, N); % This is compute the gradient in each node, batch_size works here.
            end
        end
        
        x(:, t) = x(:, t-1) - eta*(alpha*L_aug*x_hat(:, t-1) + beta*v(:, t-1) + gradient );       
        v(:, t) = v(:, t-1) + eta*beta*L_aug*x_hat(:, t-1);
        
        x_comp = reshape(x(:, t), [dn, N]);
        x_hat_comp = reshape(x_hat(:, t-1), [dn, N]);
        
        for i = 1:N
            q_0( (i-1)*dn+1 : i*dn) = Greedy(x_comp(:, i) - x_hat_comp(:, i), kG);
        end
        x_hat(:, t) = x_hat(:, t-1) + q_0;
%         q_0 = Greedy((x(:, t) - x_hat(:, t)) / s, k);
        
        xs = reshape(x(:,t), [dn, N]);
        x_avg = sum(xs, 2) / N;
        
        for k = 1:N
            xminuxbar(t) = xminuxbar(t)+(norm(xs(:, k)-x_avg))^2;
        end
        
        temp_grad = zeros(N*dn,1);
        for ii = 1 : N
            for jj=(ii-1)*bs+1:ii*bs 
               temp_grad((ii-1)*dn+1:ii*dn) = temp_grad((ii-1)*dn+1:ii*dn) + gc(x_avg,lambda,aalpha, features(:,jj), labels(jj),bs, N); % This is compute the gradient in each node, batch_size works here.
            end
        end
        g = reshape(temp_grad, [dn, N]);
        sq_grad(t) = sum(sum(g, 2).^2);
        
        transmit(t) = transmit(t-1) + kG*b;
    end
    
end