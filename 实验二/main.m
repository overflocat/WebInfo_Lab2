function main
    T = 100;

    G = buildgraph('./lab02-dataset/graph.txt');
    fp_random = fopen('./results/random.txt', 'w');
    fp_closeness = fopen('./results/closeness_centrality.txt', 'w');
    fp_degree = fopen('./results/degreee_centrality.txt', 'w');
    fp_greedy = fopen('./results/greedy.txt', 'w');
    
    for i = 1:20
        %For random
        tic
        seeds = random(G, i);
        N = ICM(G, seeds, T);
        putline(fp_random, N, seeds);
        toc
        fprintf('random finished when k = %d!\n', i);
        
        %For degree_centrality
        tic
        seeds = degree_centrality(G, i);
        N = ICM(G, seeds, T);
        putline(fp_degree, N, seeds);
        toc
        fprintf('degree_centrality finished when k = %d!\n', i);
        
        %For closeness_centrality
        tic
        seeds = closeness_centrality(G, i);
        N = ICM(G, seeds, T);
        putline(fp_closeness, N, seeds);
        toc
        fprintf('closeness_centrality finished when k = %d!\n', i);
        
        %For greedy
        tic
        seeds = greedy(G, i);
        N = ICM(G, seeds, T);
        putline(fp_greedy, N, seeds);
        toc
        fprintf('greedy finished when k = %d!\n', i);
    end
    
    fclose(fp_random);
    fclose(fp_closeness);
    fclose(fp_degree);
    fclose(fp_greedy);
end

function G = buildgraph(pathName)
    fileID = fopen(pathName, 'r');
    tempS = sscanf(fgetl(fileID), '%d %d %d');
    nodes = tempS(1); edges = tempS(2);
    links = fscanf(fileID, '%f %f %f', [3 edges]);
    G = sparse(nodes, nodes);
    G(sub2ind(size(G), links(1, :)+1, links(2, :)+1)) = links(3, :);
    fclose(fileID);
end

function putline(fp, N, seeds)
    for i = 1:size(seeds, 2)-1
       fprintf(fp, '%d,', seeds(i));
    end
    fprintf(fp, '%d;', seeds(end));
    fprintf(fp, '%d\r\n', nnz(N));
end

function N = ICM(G, seeds, T)
    N = false(1, size(G, 1));
    N(seeds) = true;
    N_nxt = N;
    N_viewed = false(1, size(G, 1));
    for i = 1:T
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
        N = N | N_nxt;
    end
end