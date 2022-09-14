function [xminuxbar, sq_grad, transmit] = Alg_1_Std_uniform_quantizer(L_aug, x, n,N,gc,lambda,aalpha, features, labels,bs, iter_num, eta, alpha, beta, psi, delta)

    fprintf('Alg_1_Std_uniform_quantizer\n');

    sq_grad = zeros(iter_num, 1);
    xminuxbar = zeros(iter_num, 1);
    transmit = zeros(iter_num, 1);
    
%     b = 32; % in this case, we use single for q_0, not double, so it is 32 bit. 
%     b = 64;
    b = 8;
%     b = 16;
    d = 50;
    v = zeros(n*N, iter_num);
    
    a_0 = zeros(n*N, iter_num);
    b_0 = zeros(n*N, iter_num);
    q_0 = zeros(n*N, 1);
    
    x0 = reshape(x(:, 1), [n, N]);
    
    for i = 1: N
        q_0( (i-1)*n+1 : i*n) = Std_uniform_quantizer(x0(:, i), delta);
    end
%     q_0 = single(q_0);
%     q_0 = int8(q_0);
    q_0 = int8(q_0);
    L_aug = full(L_aug);
    upd = textprogressbar(iter_num);
    
    for t = 2:iter_num
        q_0 = double(q_0);
        
        a_0(:, t) = a_0(:, t-1) + psi * q_0;
        b_0(:, t) = b_0(:, t-1) + psi * (q_0 - L_aug*q_0);
        
        upd(t);
        
        gradient = zeros(N*n,1);
        
        for ii = 1 : N 
            for jj=(ii-1)*bs+1:ii*bs 
                gradient((ii-1)*n+1:ii*n) = gradient((ii-1)*n+1:ii*n) + gc(x((ii-1)*n+1:ii*n,t-1),lambda,aalpha, features(:,jj), labels(jj),bs, N); % This is compute the gradient in each node, batch_size works here.
            end
        end        
        x(:, t) = x(:, t-1) - eta*alpha*( a_0(:, t-1) - b_0(:, t-1) + L_aug*q_0 ) - eta*( beta*v(:, t-1) + gradient );
        
        v(:, t) = v(:, t-1) + eta*beta*( a_0(:, t-1) - b_0(:, t-1) + L_aug*q_0);
        
        x_comp = reshape(x(:, t), [n, N]);
        a_comp = reshape(a_0(:, t), [n, N]);
        
        for i = 1:N
            q_0( (i-1)*n+1 : i*n) = Std_uniform_quantizer(x_comp(:, i) - a_comp(:, i), delta);
        end
        
%         q_0 = Std_uniform_quantizer(x(:, t) - a_0(:, t), delta);
%         q_0 = single(q_0);
%         trans = ceil(sum(log2(ceil(abs(x(:, t) - a_0(:, t) - 0.5)))));
        q_0 = int8(q_0);
        
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
        
        transmit(t) = transmit(t-1) + 2*d + b;
    end
    
end