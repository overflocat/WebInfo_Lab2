function seeds = closeness_centrality(G, k)
    G = double(logical(G));
    D = all_shortest_paths(G, struct('algname', 'johnson'));
    D(~isfinite(D)) = 0.01 * size(G, 1); %set inf to a large enough number, or results will be meaningless
    cC = (size(G, 1)-1) ./ sum(D, 2);
    [~, index] = sort(cC, 'descend');
    seeds = index(1:k)';
end