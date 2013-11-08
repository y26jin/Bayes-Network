function productFactor = multiply( factor1, factor2 )
% A function that multiples two factors

keylist1 = keys(factor1);
keylist2 = keys(factor2);

newkeyset = {};
newvalueset = [];

if numel(keylist1) < numel(keylist2)
    for i = 1:numel(keylist1)
        tempKey1 = keylist1(i);
        tempKey1 = tempKey1{:};
        % tokenize symbol from factor 1
        tokenKey1 = textscan(tempKey1, '%s', 'delimiter', ',');
        tokenKey1 = tokenKey1{1};
        
        for j = 1:numel(keylist2)
            tempKey2 = keylist2(j);
            tempKey2 = tempKey2{:};
            % tokenize symbol from factor 2
            tokenKey2 = textscan(tempKey2, '%s', 'delimiter', ',');
            tokenKey2 = tokenKey2{1};
            % if found occurrence in XOR set, dont multiply
            % else do multipky
            noIntersect = setxor(tokenKey2, tokenKey1);
            noIntersect = rot90(noIntersect);
            sizeXOR = size(noIntersect);
            sizeXOR = sizeXOR(2);
            
            isMultiable = 0;
            %if sizeXOR >= size(tokenKey1) + size(tokenKey2)
             %   isMultiable = 1;
            %end
            
            if isMultiable == 0
                newtempvalue = factor2(tempKey2) * factor1(tempKey1);
                newvalueset = [newvalueset, newtempvalue];
                tempUnion = union(tokenKey1, tokenKey2);
                tempUnion = rot90(tempUnion);
                
                tempSS = '';
                for k = 1:numel(tempUnion)-1
                    temp = tempUnion(k);
                    tempS = strcat(temp(1),',');
                    tempSS = strcat(tempSS, tempS);
                end
                temp = tempUnion(numel(tempUnion));
                tempS = strcat(temp(1));
                tempSS = strcat(tempSS, tempS);              
                tempSS = char(tempSS);
                newkeyset{end+1} = tempSS;
            end
        end
    end
else
 for i = 1:numel(keylist2)
        tempKey2 = keylist2(i);
        tempKey2 = tempKey2{:};
        % tokenize symbol from factor 1
        tokenKey2 = textscan(tempKey2, '%s', 'delimiter', ',');
        tokenKey2 = tokenKey2{1};
        
        for j = 1:numel(keylist1)
            tempKey1 = keylist1(j);
            tempKey1 = tempKey1{:};
            % tokenize symbol from factor 2
            tokenKey1 = textscan(tempKey1, '%s', 'delimiter', ',');
            tokenKey1 = tokenKey1{1};
            % if found occurrence in XOR set, dont multiply
            % else do multipky
            noIntersect = setxor(tokenKey2, tokenKey1);
            noIntersect = rot90(noIntersect);
            sizeXOR = size(noIntersect);
            sizeXOR = sizeXOR(2);
            
            isMultiable = 0;
            %if sizeXOR >= size(tokenKey1) + size(tokenKey2)
             %   isMultiable = 1;
            %end
            
            if isMultiable == 0
                newtempvalue = factor2(tempKey2) * factor1(tempKey1);
                newvalueset = [newvalueset, newtempvalue];
                tempUnion = union(tokenKey1, tokenKey2);
                tempUnion = rot90(tempUnion);
                
                tempSS = '';
                for k = 1:numel(tempUnion)-1
                    temp = tempUnion(k);
                    tempS = strcat(temp(1),',');
                    tempSS = strcat(tempSS, tempS);
                end
                temp = tempUnion(numel(tempUnion));
                tempS = strcat(temp(1));
                tempSS = strcat(tempSS, tempS);
                tempSS = char(tempSS);
                newkeyset{end+1} = tempSS;
            end
        end
    end
end

    % generate return factor
     productFactor = containers.Map(newkeyset, newvalueset);

end

