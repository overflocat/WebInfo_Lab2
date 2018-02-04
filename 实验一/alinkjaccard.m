function clustering = alinkjaccard(A, k)
    if(nargin == 0)
        res = open('./lab02-dataset/football.mat');
        A = res.A; k = res.k;
    end

    S = pdist(A, 'jaccard');
    T = linkage(S, 'average');
    clustering = cluster(T, 'MaxClust', k);
end