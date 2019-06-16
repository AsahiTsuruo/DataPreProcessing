%�֐�: ConvertVarAndRowName �@�s���ƕϐ�����ϊ�����
%����: dataAll�@table�^�̑S�f�[�^
%�Ԃ�l: dataAll, backTrackVarName, backTrackRowName�@�ϐ������s�����ς����table�^�̑S�f�[�^�A�ϐ����̃o�b�N�g���b�N�p��table�^�̃f�[�^�A�s���̃o�b�N�g���b�N�p��table�^�̃f�[�^
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
    dataAll.Properties.RowNames{j}=strcat('row',num2str(j));%�ϐ��������_���Bvar����Ƃ�
end

backTrackVarName = array2table(varNameTmp);
backTrackRowName = array2table(rowNameTmp);
end