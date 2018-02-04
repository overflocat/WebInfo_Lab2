function seeds = greedy(G, k)
    seeds = greedy_ref(G, k);
    %seeds = greedy_mine(G, k);
end

function seeds = greedy_ref(G, k)
    S = [];
    for i = 1:k
        maxI = 0;
        for j = 1:size(G, 1)
            if(nnz(S == j) ~= 0)
                continue;
            end
            S_t = [S, j];
            N = ICM(G, S_t);
            if(nnz(N) > maxI)
                maxI = nnz(N);
                S_maxt = S_t;
            end
        end
        S = S_maxt;
    end
    
    seeds = S;
end

function N = ICM(G, seeds)
    N = false(1, size(G, 1));
    N(seeds) = true;
    N_nxt = N;
    N_viewed = false(1, size(G, 1));
    while(true)
        indexV = find(N_nxt);
        N_viewed = N_viewed | N_nxt;
        N_nxt = false(1, size(G, 1));
        for j = 1:size(indexV, 2)
            indexVA = find(G(indexV(j), :));
            R = rand(size(indexVA));
            indexVRa = R <= G(indexV(j), indexVA);
            N_nxt(indexVA(indexVRa)) = true;
        end
        N_nxt = N_nxt & ~N_viewed;
        if(nnz(N_nxt) == 0)
            break;
        end
        N = N | N_nxt;
    end
end

function seeds = greedy_mine(G, k)
    G = logical(G);
    seeds = zeros(1, k);
    for i = 1:k
        xU = sum(G, 2);
        [~, curMaxI] = max(xU);
        adjacentV = G(curMaxI, :);
        G(:, curMaxI) = false;
        G(:, adjacentV) = false;
        seeds(i) = curMaxI;
    end 
end