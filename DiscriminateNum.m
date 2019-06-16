%�֐�: DiscriminateNum   �����𐔒l�Ɛ����̋L���ɕ�����
%����: dataNum    table�^�̐����f�[�^
%�Ԃ�l: dataNumVal, dataNumSym  table�^�̐��l�f�[�^�Atable�^�̐��l�f�[�^�i�L���j
function [dataNumVal, dataNumSym] = DiscriminateNum(dataNum, numericThreshold)
[row,col]= size(dataNum);
firstSymFlag = 1;
firstValFlag = 1;
dataNumSym = table;
dataNumVal = table;
countNaN = 0;

for i = 1 : col
    for j = 1 : row
       countNaN = countNaN + isnan(table2array(dataNum(j,i)));%�e���NaN�̐����J�E���g
    end
    set = unique(dataNum(:,i));%NaN�����ꂼ��ʂ̂��̂Ƃ��ďW��������
    countSet = numel(set);%�W���̌�
    countSet = countSet - countNaN;%�W���̌�����NaN�̌����Ђ�
    if (1 <= countSet) && (countSet <= numericThreshold)%���������R�Ɍ��߂���悤��
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