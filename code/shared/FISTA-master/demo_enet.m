function demo_enet()
	clc
	d      = 30; 	% data dimension
	N      = 20; 	% number of samples 
	k      = 10; 	% dictionary size 
	lambda = 0.01;
	lambda2 = 0.01;
	Y      = normc(rand(d, N));
	D      = normc(rand(d, k));
	%% cost function 
	function c = calc_F(X)
		c = (0.5*normF2(Y - D*X) + lambda2/2*normF2(X) + lambda*norm1(X))/size(X, 2);
	end
	%% fista solution 
    opts.pos          = 0; %non negativity constraint(1) or not (0);
    opts.lambda       = lambda;
    opts.lambda2      = lambda2;
    opts.check_grad   = 0;
    opts.backtracking = false;
	X_fista = fista_enet(Y, D, [], opts);
    %% fista solution with backtracking
    opts.L0 = .1;
    opts.eta = 1.05;
    X_fista_bt = fista_enet_backtracking(Y, D, [], opts);

	%% spams solution 
	param.lambda     = lambda;
	param.lambda2    = lambda2;
	param.numThreads = 1;
	param.mode       = 2;
	param.pos        = opts.pos;
	X_spams          = mexLasso(Y, D, param); 
	%% compare costs 
	cost_spams = calc_F(X_spams);
    cost_fista = calc_F(X_fista);
	cost_fista_bt = calc_F(X_fista_bt);
    fprintf('Test with Elastic Net problem\n');
	fprintf('cost_spams    = %.5s\n', cost_spams);    
    fprintf('cost_fista    = %.5s\n', cost_fista);
    fprintf('cost_fista_bt = %.5s\n', cost_fista_bt);
    
%     [full(X_spams), X_fista, X_fista_bt]
end
