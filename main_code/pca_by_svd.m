function [PC Y varPC] = pca_by_svd(X, num_to_save)
    %# PCA_BY_SVD
    %#   X      data matrix of size n-by-p where n<<p
    %#   PC     columns are first n principal components
    %#   Y      data projected on those PCs
    %#   varPC  variance along the PCs
    %#
    
    
    X = normr(X);                          %normalize database in case it isn't already
    X0 = bsxfun(@minus, X, mean(X,1));     %shift data to zero-mean
    [U,S,PC] = svd(X0,'econ');             %SVD decomposition
    PC=PC(:,1:num_to_save);
    S = S(1:num_to_save,1:num_to_save);
    Y = X0*PC;                             %project X on PC
    varPC = diag(S'*S)' / size(X,1);       %variance explained
end