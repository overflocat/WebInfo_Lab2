function main
    VIS = true;
    %For polbooks dataset
    res = open('./lab02-dataset/polbooks.mat');
    A = res.A; k = res.k;
    
    callfunc('polbooks', 'girvannewman', A, k, VIS);
    callfunc('polbooks', 'alinkjaccard', A, k, VIS);
    callfunc('polbooks', 'ncut', A, k, VIS);
    callfunc('polbooks', 'rcut', A, k, VIS);
    callfunc('polbooks', 'modularity', A, k, VIS);

    %For football dataset
    res = open('./lab02-dataset/football_corr.mat');
    A = res.A; k = res.k;
    
    callfunc('football', 'girvannewman', A, k, VIS);
    callfunc('football', 'alinkjaccard', A, k, VIS);
    callfunc('football', 'ncut', A, k, VIS);
    callfunc('football', 'rcut', A, k, VIS);
    callfunc('football', 'modularity', A, k, VIS);
    
    %For DBLP dataset
    res = open('./lab02-dataset/DBLP.mat');
    A = res.A; k = res.k;
    
    callfunc('DBLP', 'girvannewman', A, k, VIS);
    callfunc('DBLP', 'alinkjaccard', A, k, VIS);
    callfunc('DBLP', 'ncut', A, k, VIS);
    callfunc('DBLP', 'rcut', A, k, VIS);
    callfunc('DBLP', 'modularity', A, k, VIS);
    
    %For Egonet dataset
    res = open('./lab02-dataset/Egonet.mat');
    A = res.x; k = 14;
    
    callfunc('Egonet', 'girvannewman', A, k, VIS);
    callfunc('Egonet', 'alinkjaccard', A, k, VIS);
    callfunc('Egonet', 'ncut', A, k, VIS);
    callfunc('Egonet', 'rcut', A, k, VIS);
    callfunc('Egonet', 'modularity', A, k, VIS);
    
end

function saveresult(clustering, datasetName, methodName)
    pathName = strcat('./results/', datasetName, '_', methodName, '.txt');
    dlmwrite(pathName, clustering, 'precision', '%d', 'newline', 'pc');
    fprintf('%s on %s has been finished!\n', methodName, datasetName);
end

function visualiztion(clustering, A, datasetName, methodName)
    pathName = strcat('./results/', datasetName, '_', methodName, '_edge', '.csv');
    [x, y] = find(A);
    source = num2cell(x);
    target = num2cell(y);
    type = repmat({'undirected'}, size(x, 1), 1);
    weight = repmat({'1'}, size(x, 1), 1);
    edgeResult = [source, target, type, weight];
    T = cell2table(edgeResult, 'VariableNames', {'Source', 'Target', 'Type', 'Weight'});
    writetable(T, pathName);
    
    pathName = strcat('./results/', datasetName, '_', methodName, '_vertex', '.csv');
    id = num2cell([1:1:size(A, 1)]');
    modClass = num2cell(clustering);
    vexResult = [id, modClass];
    T = cell2table(vexResult, 'VariableNames', {'Id', 'Modularity_Class'});
    writetable(T, pathName);
end

function callfunc(datasetName, methodName, A, k, VIS)
    tfunc = str2func(methodName);
    clustering = tfunc(A, k);
    saveresult(clustering, datasetName, methodName);
    if(VIS)
        visualiztion(clustering, A, datasetName, methodName);
    end
end