%�֐�: DataToNaN  ���̓f�[�^��NaN�ɂ���
%����: data   table�^�̃f�[�^
%�Ԃ�l: dataNaN�@table�^��NaN
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