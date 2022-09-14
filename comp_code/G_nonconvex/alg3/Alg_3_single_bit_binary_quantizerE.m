function [xminuxbar, sq_grad, transmit] = Alg_3_single_bit_binary_quantizerE(L_aug, x, n,N,gc,lambda,aalpha, features, labels,bs, iter_num, eta, alpha, beta, s0, gamma)

    fprintf('Alg_3_single_bit_binary_quantizer\n');

    sq_grad = zeros(iter_num, 1);
    xminuxbar = zeros(iter_num, 1);
    transmit = zeros(iter_num, 1);
    
    d = 50;
    v = zeros(n*N, iter_num);
    
    x_hat = zeros(n*N, iter_num);
    y = zeros(n*N, iter_num);
    q_0 = zeros(n*N, 1);
    
    x0 = reshape(x(:, 1), [n, N]);
    
    for i = 1: N
        q_0( (i-1)*n+1 : i*n) = Single_bit_binary_quantizer(x0(:, i) );
    end
    
    x_hat(:, 2) = x_hat(:, 1) + s0*q_0;
    y(:, 2) = y(:, 1) + s0*q_0 -s0*L_aug*q_0;
    upd = textprogressbar(iter_num);
    
    for t = 2:iter_num
               
        upd(t);
        
        gradient = zeros(N*n,1);
        
        for ii = 1 : N 
            for jj=(ii-1)*bs+1:ii*bs 
                gradient((ii-1)*n+1:ii*n) = gradient((ii-1)*n+1:ii*n) + gc(x((ii-1)*n+1:ii*n,t-1),lambda,aalpha, features(:,jj), labels(jj),bs, N); % This is compute the gradient in each node, batch_size works here.
            end
        end
        
        x(:, t) = x(:, t-1) - eta*(alpha*L_aug*x_hat(:, t) + beta*v(:, t-1) + gradient );      
        v(:, t) = v(:, t-1) + eta*beta*L_aug*x_hat(:, t);
        
        x_comp = reshape(x(:, t), [n, N]);
        x_hat_comp = reshape(x_hat(:, t), [n, N]);
        
        for i = 1:N
            q_0( (i-1)*n+1 : i*n) = Single_bit_binary_quantizer(x_comp(:, i) - x_hat_comp(:, i));
        end
        s = s0 * gamma^(t-1);       
        x_hat(:, t+1) = x_hat(:, t) + s * q_0;
        
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
        
        transmit(t) = transmit(t-1) + d;
    end
    
end