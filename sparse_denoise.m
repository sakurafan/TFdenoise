function subcubes_out=sparse_denoise(subcubes,varargin)
opts=varargin{1};

% Starting point
opts1.init=2;        % starting from a zero point
% Termination
opts1.tFlag=4;
opts1.tol=1e-2;
% Normalization
opts1.nFlag=0;       % without normalization
% Regularization
opts1.rFlag=0;
opts1.mFlag=1;       % smooth reformulation
opts1.lFlag=1;       % adaptive line search

mean_val=mean(subcubes,1);
subcubes=bsxfun(@minus,subcubes,mean_val);
subcubes_out=opts.D*mcLeastR(opts.D,subcubes,opts.lambda*sqrt(size(subcubes,2)),opts1);
subcubes_out=bsxfun(@plus,subcubes_out,mean_val);