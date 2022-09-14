function [xminuxbar, sq_grad, transmit] = Alg_1_Greedy(L_aug, x, dn,N,gc,lambda,aalpha, features, labels,bs, iter_num, eta, alpha, beta, psi, kG)

    fprintf('Alg_1_Greedy\n');

    sq_grad = zeros(iter_num, 1);
    xminuxbar = zeros(iter_num, 1);
    transmit = zeros(iter_num, 1);
    
    b = 64; 
    v = zeros(dn*N, iter_num);
    
    a_0 = zeros(dn*N, iter_num);
    b_0 = zeros(dn*N, iter_num);
    q_0 = zeros(dn*N, 1);
    
    x0 = reshape(x(:, 1), [dn, N]);
    
    for i = 1: N
        q_0( (i-1)*dn+1 : i*dn) = Greedy(x0(:, i), kG);
    end
    
    upd = textprogressbar(iter_num);
    
    for t = 2:iter_num
        
        a_0(:, t) = a_0(:, t-1) + psi * q_0;
        b_0(:, t) = b_0(:, t-1) + psi * (q_0 - L_aug*q_0);
        
        upd(t);
        
        gradient = zeros(N*dn,1);
        
        for ii = 1 : N 
            for jj=(ii-1)*bs+1:ii*bs 
                gradient((ii-1)*dn+1:ii*dn) = gradient((ii-1)*dn+1:ii*dn) + gc(x((ii-1)*dn+1:ii*dn,t-1),lambda,aalpha, features(:,jj), labels(jj),bs, N); % This is compute the gradient in each node, batch_size works here.
            end
        end
        
        x(:, t) = x(:, t-1) - eta*alpha*( a_0(:, t-1) - b_0(:, t-1) + L_aug*q_0 ) - eta*( beta*v(:, t-1) + gradient );
        
        v(:, t) = v(:, t-1) + eta*beta*( a_0(:, t-1) - b_0(:, t-1) + L_aug*q_0);
        
        x_comp = reshape(x(:, t), [dn, N]);
        a_comp = reshape(a_0(:, t), [dn, N]);
        
        for i = 1:N
            q_0( (i-1)*dn+1 : i*dn) = Greedy(x_comp(:, i) - a_comp(:, i), kG);
        end
        
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