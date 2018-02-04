function seeds = random(G, k)
    index = randperm(size(G, 1));
    seeds = index(1:k);
end