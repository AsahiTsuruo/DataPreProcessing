%関数: DivideDataType  tableをデータの種類ごとに分ける
%引数: dataAll  table型の全データ
%返り値: dataNum, dataSym, dataDate  table型の数字の入ったデータ、table型の記号データ、table型の日付
function [dataNum, dataSym, dataDate] = DivideDataType(dataAll)
[~, col] = size(dataAll);
typeNumeric = vartype('numeric');
dataNum = dataAll(:,typeNumeric);
typeCeller = vartype('cellstr');
dataSym = dataAll(:,typeCeller);
typeDate = vartype('datetime');
dataDate = dataAll(:,typeDate);

%それぞれの行列サイズ取得
[~, dataNumColumnLen] = size(dataNum);
[~, dataSymColumnLen] = size(dataSym);
[~, dataDateColumnLen] = size(dataDate);

%すべての変数を場合分けできているか確認
if col ~= (dataNumColumnLen + dataSymColumnLen + dataDateColumnLen)
    disp('変数を場合分けできていません')
else
    disp('場合分け完了')
end

end