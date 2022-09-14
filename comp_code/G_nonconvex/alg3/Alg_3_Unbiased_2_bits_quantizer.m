function [xminuxbar, sq_grad, transmit] = Alg_3_Unbiased_2_bits_quantizer(L_aug, x, n,N,gc,lambda,aalpha, features, labels,bs, iter_num, eta, alpha, beta, s0, gamma)

    fprintf('Alg_3_Unbiased_2_bits_quantizer\n');

    sq_grad = zeros(iter_num, 1);
    xminuxbar = zeros(iter_num, 1);
    transmit = zeros(iter_num, 1);
    
    b = 64;
    d = 50;
    v = zeros(n*N, iter_num);
    
    x_hat = zeros(n*N, iter_num);
    y = zeros(n*N, iter_num);
    q_0 = zeros(n*N, 1);
    
    l = 2; 
    x0 = reshape(x(:, 1), [n, N]);
    
    for i = 1: N
        q_0( (i-1)*n+1 : i*n) = Unbiased_l_bits_quantizer(x0(:, i) / s0, l);
    end
    x_hat(:, 2) = x_hat(:, 1) + s0*q_0;
    y(:, 2) = y(:, 1) + s0*q_0 -s0*L_aug*q_0;
    upd = textprogressbar(iter_num);
    
    for t = 2:iter_num
        
        s = s0 * gamma^(t-1);
        
        x_hat(:, t+1) = x_hat(:, t) + s * q_0;
        y(:, t+1) = y(:, t) + s * q_0 - s *L_aug*q_0;
        
        upd(t);
        gradient = zeros(N*n,1);
        
        for ii = 1 : N 
            for jj=(ii-1)*bs+1:ii*bs 
                gradient((ii-1)*n+1:ii*n) = gradient((ii-1)*n+1:ii*n) + gc(x((ii-1)*n+1:ii*n,t-1),lambda,aalpha, features(:,jj), labels(jj),bs, N); % This is compute the gradient in each node, batch_size works here.
            end
        end
        
        x(:, t) = x(:, t-1) - eta*alpha*( x_hat(:, t+1) - y(:, t+1) ) - eta*( beta*v(:, t-1) + gradient );
        
        v(:, t) = v(:, t-1) + eta*beta*( x_hat(:, t+1) - y(:, t+1) );
        
        x_comp = reshape(x(:, t), [n, N]);
        x_hat_comp = reshape(x_hat(:, t), [n, N]);
        
        for i = 1:N
            q_0( (i-1)*n+1 : i*n) = Unbiased_l_bits_quantizer((x_comp(:, i) - x_hat_comp(:, i))/s, l);
        end
        
%         q_0 = Unbiased_l_bits_quantizer((x(:, t) - x_hat(:, t)) / s, l);
        
        xs = reshape(x(:,t), [n, N]);
        x_avg = sum(xs, 2) / N;
        
        for k = 1:N
            xminuxbar(t) = xminuxbar(t)+(norm(xs(:, k)-x_avg))^2;
        end
        
        temp_grad = zeros(N*n,1);
        for ii = 1 : N
            for jj=(ii-1)*bs+1:ii*bs 
               temp_grad((ii-1)*n+1:ii*n) = temp_grad((ii-1)*n+1:ii*n) + gc(x_avg,lambda,aalpha, features(:,jj), labels(jj),bs, N); % This is compute the gradient in each node, batch_size works here.
            end
        end
        g = reshape(temp_grad, [n, N]);
        sq_grad(t) = sum(sum(g, 2).^2);
        
        transmit(t) = transmit(t-1) + (l+1)*d + b;
    end
    
end