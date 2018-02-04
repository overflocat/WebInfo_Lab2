function seeds = degree_centrality(G, k)
    G = logical(G);
    [~, index] = sort(sum(G, 2), 'descend');
    seeds = index(1:k)';
end