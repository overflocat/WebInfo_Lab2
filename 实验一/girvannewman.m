function clustering = girvannewman(A, k)
    if(nargin == 0)
        res = open('./lab02-dataset/football.mat');
        A = res.A; k = res.k;
    end

    clustering = components(A);
    n = max(clustering);
    
    while(n < k)
        [~, E] = betweenness_centrality(A, struct('unweighted', 1));
        [row, col] = find(E == max(E(:)), 1);
        A(row, col) = 0; A(col, row) = 0;
        clustering = components(A);
        n = max(clustering);
    end
    
end