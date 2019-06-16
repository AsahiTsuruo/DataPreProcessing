%�֐�: CalclateZScore   zscore�̌v�Z������
%����: dataNumVal   table�^�̐��l�f�[�^
%�Ԃ�l: dataZScore  ���K�����ꂽtable�^
function dataZScore = CalculateZScore(dataNumVal, normalizationFlag)
dataNumArray = table2array(dataNumVal);
[row,col] = size(dataNumArray);

dataNumArrayMean = nanmean(dataNumArray,1);%����
dataNumArrayStd = nanstd(dataNumArray,0,1);%�W���΍��F1/N�Ŋ����Ă���
dataZScore = dataNumVal;
if normalizationFlag == 1
    for i = 1 : col
        for j = 1 : row
            if isnan(dataNumArray(j,i)) == 1%���X�̃f�[�^�̒l��NaN�̏ꍇ
                dataZScore(j,i) = array2table(dataNumArray(j,i));%NaN����
            elseif dataNumArrayStd(1,i) == 0%�W���΍����O�̏ꍇ
                dataZScore(j,i) = array2table(0);%0����
            else
                dataZScore(j,i) = array2table((dataNumArray(j, i) - dataNumArrayMean(1, i)) / dataNumArrayStd(1, i));
            end
        end
    end
end
end