function clustering = modularity(A, k)
    if(nargin == 0)
        res = open('./lab02-dataset/polbooks.mat');
        A = res.A; k = res.k;
    end

    d = sum(A)';
    B = A - d*d' / (nnz(A));
    try
        [V, ~] = eigs(B, k, 'lm');
    catch
        [V, ~] = eigs(full(B), k, 'lm');
    end
    clustering = kmeans(V, k);
end