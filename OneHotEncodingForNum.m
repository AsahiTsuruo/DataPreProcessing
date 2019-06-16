%関数: OneHotEncodingForNum   数字の記号データをOneHotVectorにする
%引数: dataNumSym   table型の数字データ
%返り値: dataNumSymOneHot    table型のOneHotVecter
function dataNumSymOneHot = OneHotEncodingForNum(dataNumSym)
dataNumSymArray = table2array(dataNumSym);%table形式をarray形式に変換
[row, col] = size(dataNumSymArray);%行列のサイズ取得

dataNumSymOneHot = table;
flagFirstLoopF = 1;
zeroFlag = 1;
for i = 1 : col
        columnVector = dataNumSymArray(:,i);
        set = myUnique(columnVector);%列の集合を取得
        [setRow,~]= size(set);%集合のサイズ取得
             
        %OneHotVector作成
        [~,location] = ismember(columnVector,set);%columnVectorの各要素の、columnVectorにおけるインデックス(location)を取得
        zeroFlag = unique(location(location==0));
        if zeroFlag == 0
            location(location == 0) = (max(location) + 1);%ind2vecを使えるようにインデックスを調整
        end
            
        indVecter = ind2vec(transpose(location));%インデックス(location)をベクトルへ変換
        oneHotVector = transpose(indVecter);
        if zeroFlag == 0
            set(setRow)=[];%集合からNaNを削除,これはMyUniqueのおかげでできる
            oneHotVector(:,setRow) = []; %oneHotVectorからNaNのベクトルを削除,これはMyUniqueのおかげでできる
        end
        if isempty(set) == 1%列がすべて欠損値であった場合
            oneHotVector = (zeros([row,1]));
            oneHotVector(oneHotVector == 0) = NaN;
            newVarName = string(dataNumSym.Properties.VariableNames{i});%変数名はそのまま
        else
            [newSetRow, ~]= size(set); %行列のサイズを再取得      
            varNamePlus = strcat(dataNumSym.Properties.VariableNames{i}, '_');%新たな変数名を与える
            %変数名の配列をつくる。
            newVarName = string(zeros([1 newSetRow])); %NaNのOneHotベクトルを削除している場合のため
            for m = 1 : newSetRow
                 newVarName(1,m) = strcat(varNamePlus, string(set(m,1)));
            end 
        end
        newVarName = matlab.lang.makeValidName(newVarName);%変数として適用可能な名前に変換
        tmpTable = array2table(oneHotVector, 'VariableNames', newVarName);
        if flagFirstLoopF == 1
            dataNumSymOneHot = tmpTable; 
            flagFirstLoopF = -1;
        else
            dataNumSymOneHot = horzcat(dataNumSymOneHot, tmpTable);
        end
        
        zeroFlag = 1;
end
end

function y = myUnique(x)
  y = unique(x,'stable');
  if any(isnan(y))
    y(isnan(y)) = []; % remove all nans
    y(end+1,1) = NaN; % add the unique one.
  end
end