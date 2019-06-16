%関数: CalclateZScore   zscoreの計算をする
%引数: dataNumVal   table型の数値データ
%返り値: dataZScore  正規化されたtable型
function dataZScore = CalculateZScore(dataNumVal, normalizationFlag)
dataNumArray = table2array(dataNumVal);
[row,col] = size(dataNumArray);

dataNumArrayMean = nanmean(dataNumArray,1);%平均
dataNumArrayStd = nanstd(dataNumArray,0,1);%標準偏差：1/Nで割っている
dataZScore = dataNumVal;
if normalizationFlag == 1
    for i = 1 : col
        for j = 1 : row
            if isnan(dataNumArray(j,i)) == 1%元々のデータの値がNaNの場合
                dataZScore(j,i) = array2table(dataNumArray(j,i));%NaNを代入
            elseif dataNumArrayStd(1,i) == 0%標準偏差が０の場合
                dataZScore(j,i) = array2table(0);%0を代入
            else
                dataZScore(j,i) = array2table((dataNumArray(j, i) - dataNumArrayMean(1, i)) / dataNumArrayStd(1, i));
            end
        end
    end
end
end