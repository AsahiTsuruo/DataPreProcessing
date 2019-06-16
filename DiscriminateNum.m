%関数: DiscriminateNum   数字を数値と数字の記号に分ける
%引数: dataNum    table型の数字データ
%返り値: dataNumVal, dataNumSym  table型の数値データ、table型の数値データ（記号）
function [dataNumVal, dataNumSym] = DiscriminateNum(dataNum, numericThreshold)
[row,col]= size(dataNum);
firstSymFlag = 1;
firstValFlag = 1;
dataNumSym = table;
dataNumVal = table;
countNaN = 0;

for i = 1 : col
    for j = 1 : row
       countNaN = countNaN + isnan(table2array(dataNum(j,i)));%各列のNaNの数をカウント
    end
    set = unique(dataNum(:,i));%NaNをそれぞれ別のものとして集合をえる
    countSet = numel(set);%集合の個数
    countSet = countSet - countNaN;%集合の個数からNaNの個数をひく
    if (1 <= countSet) && (countSet <= numericThreshold)%ここを自由に決められるように
            if firstSymFlag == 1
                dataNumSym = dataNum(:,i);
                firstSymFlag = -1;
            else
                dataNumSym = horzcat(dataNumSym, dataNum(:,i));
            end
    else
            if firstValFlag == 1
                dataNumVal = dataNum(:,i);
                firstValFlag = -1;
            else
                dataNumVal = horzcat(dataNumVal, dataNum(:,i));
            end
    end
    countNaN = 0;
end

end