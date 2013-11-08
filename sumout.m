function resultFactor = sumout( factor, variable )
% A function that sums out a variable given a factor

keylist = keys(factor); % return the list of variables e.g. {'A,B,C','D,E,F'}
valuelist = values(factor);

newkeyset = {};
newvalueset = [];

% tokenize the given variable
tokenVar = textscan(variable, '%s', 'delimiter',',');
tokenVar = tokenVar{1};
k = strfind(tokenVar,'-');
if isempty(k{1}) == 1
    tokenVar2 = '-';
    tokenVar2 = strcat(tokenVar2, tokenVar);
else
    tokenVar2 = '';
    tokenVar2 = strcat(tokenVar2, tokenVar);
end

count = 0;
for i = 1:numel(keylist)
    tempKey = keylist(i);    
    tempKey = tempKey{:}
    % tokenize the tempkey
    tokenKey = textscan(tempKey, '%s', 'delimiter', ',');
    tokenKey = tokenKey{1};
    
    for j = 1:numel(keylist)
    % if found variable tokens in the XOR set, give up
    % else this is available to sum up
        tempKey2 = keylist(j);
        tempKey2 = tempKey2{:};
        tokenKey2 = textscan(tempKey2, '%s', 'delimiter', ',');
        tokenKey2 = tokenKey2{1};
                
        isSumout = 1;
        noIntersect = setxor(tokenKey, tokenKey2);
        noIntersect = rot90(noIntersect);
        sizeXOR = numel(noIntersect);
        if sizeXOR == 2
            if ismember(tokenVar, noIntersect) == 1
                if ismember(tokenVar2, noIntersect) == 1
                    isSumout = 0;
                end
            end
        end
        if isSumout == 0
            % means we found the right entries to add up
            count = count + 1;
            sum1 = valuelist(i);
            sum2 = valuelist(j);
            sumEntry = sum1{1} + sum2{1};
            newvalueset = [newvalueset, sumEntry];
            tempInter = intersect(tokenKey, tokenKey2);
            tempSS = '';
            for k = 1:numel(tempInter)-1
                temp = tempIntern(k);
                tempS = strcat(temp(1),',');
                tempSS = strcat(tempSS, tempS);
            end
            temp = tempInter(numel(tempInter));
            tempS = strcat(temp(1));
            tempSS = strcat(tempSS, tempS);              
            tempSS = char(tempSS);
            newkeyset{end+1} = tempSS;
        end
    end
        
end
        resultFactor = containers.Map(newkeyset,newvalueset);
end

