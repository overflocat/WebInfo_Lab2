function clustering = ncut(A, k)
    if(nargin == 0)
        res = open('./lab02-dataset/football.mat');
        A = res.A; k = res.k;
    end
    
    Dv = sum(A);
    D = sparse(diag(Dv));
    Dr = sparse(diag(1./sqrt(Dv)));
    
    L = Dr * (D - A) * Dr;
    try
        [V, ~] = eigs(L, k, 'sm');
    catch
        [V, ~] = eigs(full(L), k, 'sm');
    end
    clustering = kmeans(V, k);
end