function [xminuxbar, sq_grad, transmit] = DPDA(L_aug, x, n,N,gc,lambda,aalpha, features, labels,bs, iter_num, eta, alpha, beta)

    fprintf('Starting DPDA\n');

    sq_grad = zeros(iter_num, 1);
    xminuxbar = zeros(iter_num, 1);
    transmit = zeros(iter_num, 1);
    b = 64; d = 50;
    v = zeros(n*N, iter_num);
    
    upd = textprogressbar(iter_num);
    
    for t = 2:iter_num
        
        upd(t);        
        gradient = zeros(N*n,1);
        
        for ii = 1 : N 
            for jj=(ii-1)*bs+1:ii*bs 
                gradient((ii-1)*n+1:ii*n) = gradient((ii-1)*n+1:ii*n) + gc(x((ii-1)*n+1:ii*n,t-1),lambda,aalpha, features(:,jj), labels(jj),bs, N); % This is compute the gradient in each node, batch_size works here.
            end
        end
        
        x(:, t) = x(:, t-1) - eta*( alpha*L_aug*x(:, t-1) + beta*v(:, t-1) + gradient );
        v(:, t) = v(:, t-1) + eta*beta*L_aug*x(:, t-1);
         
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
        transmit(t) = transmit(t-1) + b*d;
    end
    
end