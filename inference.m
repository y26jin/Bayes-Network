function resultFactor = inference( factorList, queryVariables, orderedListOfHiddenVariables, evidenceList )
% A function that computes Pr{queryVariable | evidenceList} by variable
% elimination.

factorListSize = numel(factorList);
queryVariableSize = numel(queryVariables);
hiddenSize = numel(orderedListOfHiddenVariables);
evidenceSize = numel(evidenceList);

tempFactorList = {};
% restrict factorList with evidenceList
for i = 1:factorListSize
    tempFactor = factorList{i};
    for j = 1:evidenceSize
        tempEv = evidenceList{j};
        tempRestrict = restrictFactor(tempFactor, tempEv);
        tempFactorList{end+1} = tempRestrict;
    end
end

tempFactorListSize = numel(tempFactorList);
% product factors
tempFactor = tempFactorList{1};
for i = 2:tempFactorListSize
    tempFactor = multiply(tempFactor, tempFactorList{i});
end

% sum out hidden variables
for i = 1:hiddenSize
    tempFactor = sumout(tempFactor, orderedListOfHiddenVariables{i});
end

resultFactor = tempFactor;

% normalize
resultValueSet = values(resultFactor);
sumResult = 0;
for p = 1:numel(resultValueSet)
    tempCell = resultValueSet(p);
    sumResult = sumResult + tempCell{:};
end

newResultKeys = keys(resultFactor);
newResultValues = [];
for t = 1:numel(resultValueSet)
    tempRV = resultValueSet(t);
    newResultValues = [newResultValues, tempRV{:}/sumResult];
end

resultFactor = containers.Map(newResultKeys,newResultValues);

end

