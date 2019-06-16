%関数: DataToNaN  入力データをNaNにする
%引数: data   table型のデータ
%返り値: dataNaN　table型のNaN
function dataNaN = DataToNaN(data)
[row, col] = size(data);
dataNaN = zeros([row, col]);
for i = 1 : col
   dataNaN(:,i) = NaN;
end
dataNaN = array2table(dataNaN);
for i = 1 : col
    dataNaN.Properties.VariableNames{i} = data.Properties.VariableNames{i};
end

end