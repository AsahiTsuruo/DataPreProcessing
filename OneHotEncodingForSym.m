%関数: OneHotEncodingForSym2   記号データをOneHotVectorにする (記号のパターンが多すぎるときその列をNaNに)
%引数: dataSym  table型の記号データ
%返り値: dataSymOneHot    table型のOneHotVector
function dataSymOneHot = OneHotEncodingForSym(dataSym, symbolThreshold)
dataSymArray = table2array(dataSym);%table形式をarray形式に変換,table2cellにすることも考える
[row,col] = size(dataSymArray);%行列のサイズ取得

dataSymOneHot = table;
flagFirstLoopFlag = 1;
NaNFlag = -1;%欠損値があるかどうかの確認
for i = 1 : col
        limitSym = symbolThreshold;
        columnVecter = dataSymArray(:,i);
        set = unique(columnVecter,'stable');%列の集合を取得
        [setRow,~]= size(set);%集合のサイズ取得
        
        %集合の列において、欠損値を確認したときにそのインデックスを取得
        for j = 1 : setRow
            if (ismissing(set(j,1)) == 1) && (NaNFlag == -1)
                deleteIndex = j;
                NaNFlag = 1;
                limitSym = limitSym + 1;%集合に欠損値が入っている場合setRowの値が実際より１大きくなるため調整
            end
        end

        %OneHotVector作成
        if setRow <= limitSym%決められた上限より小さい場合
                 [~,location] = ismember(columnVecter,set);%columnVectorの各要素の、columnVectorにおけるインデックス(location)を取得
                 indVecter = ind2vec(transpose(location));%インデックス(location)をベクトルへ変換　　ind2vec  (Neural Network Toolboxを追加する必要あり)
                 oneHotVector = transpose(indVecter);

                  %新たな変数名の作成
                 varNamePlus = strcat(dataSym.Properties.VariableNames{i}, '_');
                 for m = 1 : setRow
                     set(m,1) = strcat(varNamePlus, set(m,1));
                 end
                 
                 %欠損処理
                 if NaNFlag == 1%列に欠損値があった場合
                    set(deleteIndex) = [];
                    oneHotVector(:,deleteIndex) = []; 
                 end
                 if isempty(set) == 1%列がすべて欠損値であった場合
                    oneHotVector = (zeros([row,1]));
                    oneHotVector(oneHotVector == 0) = NaN;
                    set = string(dataSym.Properties.VariableNames{i});
                 end
                 
                 set = matlab.lang.makeValidName(set);%変数として適用可能な名前に変換
                 tmpTable = array2table(oneHotVector, 'VariableNames', transpose(set));
        else%決められた上限より大きい場合
                oneHotVector = zeros([row 1]);
                oneHotVector(:,1)=NaN;%すべての行をNaNに
                varName = matlab.lang.makeValidName(dataSym.Properties.VariableNames{i});%変数として適用可能な名前に変換
                tmpTable = array2table(oneHotVector, 'VariableNames', string(varName));
        end
        
        if flagFirstLoopFlag == 1
            dataSymOneHot = tmpTable; 
            flagFirstLoopFlag = -1;
        else
            dataSymOneHot = horzcat(dataSymOneHot, tmpTable);
        end
        
        NaNFlag = -1;
end
end