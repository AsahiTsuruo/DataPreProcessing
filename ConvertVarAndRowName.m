%関数: ConvertVarAndRowName 　行名と変数名を変換する
%引数: dataAll　table型の全データ
%返り値: dataAll, backTrackVarName, backTrackRowName　変数名を行名が変わったtable型の全データ、変数名のバックトラック用のtable型のデータ、行名のバックトラック用のtable型のデータ
function [dataAll, backTrackVarName, backTrackRowName] = ConvertVarAndRowName(dataAll)
[row, col] = size(dataAll);
varNameTmp = string(zeros([2 col] ));
rowNameTmp = string(zeros([row 2]));

for i = 1 : col
    varNameTmp(1,i) = dataAll.Properties.VariableNames{i};
    varNameTmp(2,i) = strcat('var',num2str(i));
    dataAll.Properties.VariableNames{i}=strcat('var',num2str(i));
end
for j = 1 : row
    rowNameTmp(j,1) = dataAll.Properties.RowNames{j};
    rowNameTmp(j,2) = strcat('row',num2str(j));
    dataAll.Properties.RowNames{j}=strcat('row',num2str(j));%変数名数字ダメ。var入れとく
end

backTrackVarName = array2table(varNameTmp);
backTrackRowName = array2table(rowNameTmp);
end