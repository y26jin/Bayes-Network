function restrictFact = restrictFactor( factor, value )
% A function that restricts a variable to some value in a given factor

keylist = keys(factor); % return the list of variables e.g. {'A,B,C','D,E,F'}
keylistsize = size(keylist);
keylistsize = keylistsize(2) % because keylistsize is 2 col x 1 row

newkeyset = {};
newvalueset = [];

for i = 1:keylistsize
    tempKey = keylist{i};    
    % tokenize the tempkey
    tokenKey = textscan(tempKey, '%s', 'delimiter', {',','|'});
    tokenKey = tokenKey{1};
    
    % tokenize the given value of corresponding variable
    tokenVar = textscan(value, '%s', 'delimiter', {',','|'});
    tokenVar = tokenVar{1};
    
    % if found variable tokens in the XOR set, give up
    % else this is available to restrict
    noIntersect = setxor(tokenVar, tokenKey);
    sizeXOR = size(noIntersect);
    sizeXOR = size(1);
    
    isRestrictable = 0;
    for j = 1:sizeXOR
        if ismember(tokenVar(j), noIntersect) == 1
            isRestrictable = 1;
            break;
        end
    end
    
    if isRestrictable == 0
        % good to restrict
        tempNewVar = setdiff(tokenKey, tokenVar);
        tempNewVar = rot90(tempNewVar);
        newvalueset = [newvalueset, factor(tempKey)];
        
        if(numel(tempNewVar) ~= 0)
            tempSS = '';
            for k = 1:numel(tempNewVar)-1
                temp = tempNewVar(k);
                tempS = strcat(temp(1),',');
                tempSS = strcat(tempSS,tempS);
            end
            temp = tempNewVar(numel(tempNewVar));
            tempS = strcat(temp(1));
            tempSS = strcat(tempSS, tempS);
            tempSS = char(tempSS);
            newkeyset{end+1} = tempSS;
        else
            isRestrictable = 1;
        end
        
    end
  
end

if isRestrictable == 0
    restrictFact = containers.Map(newkeyset, newvalueset);
elseif isRestrictable == 1
    restrictFact = factor;
end

end

