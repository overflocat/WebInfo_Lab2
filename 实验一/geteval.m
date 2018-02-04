function geteval()
    NMI = zeros(1, 5);
    ACC = zeros(1, 5);
    [NMI(1), ACC(1)] = evaluation(strcat('./results/polbooks_', 'alinkjaccard', '.txt'), './lab02-dataset/polbooks_gd.txt', 3);
    [NMI(2), ACC(2)] = evaluation(strcat('./results/polbooks_', 'girvannewman', '.txt'), './lab02-dataset/polbooks_gd.txt', 3);
    [NMI(3), ACC(3)] = evaluation(strcat('./results/polbooks_', 'ncut', '.txt'), './lab02-dataset/polbooks_gd.txt', 3);
    [NMI(4), ACC(4)] = evaluation(strcat('./results/polbooks_', 'rcut', '.txt'), './lab02-dataset/polbooks_gd.txt', 3);
    [NMI(5), ACC(5)] = evaluation(strcat('./results/polbooks_', 'modularity', '.txt'), './lab02-dataset/polbooks_gd.txt', 3);
    NMI
    ACC
    
    NMI = zeros(1, 5);
    ACC = zeros(1, 5);
    [NMI(1), ACC(1)] = evaluation(strcat('./results/football_', 'alinkjaccard', '.txt'), './lab02-dataset/football_gd.txt', 12);
    [NMI(2), ACC(2)] = evaluation(strcat('./results/football_', 'girvannewman', '.txt'), './lab02-dataset/football_gd.txt', 12);
    [NMI(3), ACC(3)] = evaluation(strcat('./results/football_', 'ncut', '.txt'), './lab02-dataset/football_gd.txt', 12);
    [NMI(4), ACC(4)] = evaluation(strcat('./results/football_', 'rcut', '.txt'), './lab02-dataset/football_gd.txt', 12);
    [NMI(5), ACC(5)] = evaluation(strcat('./results/football_', 'modularity', '.txt'), './lab02-dataset/football_gd.txt', 12);
    NMI
    ACC
    
end