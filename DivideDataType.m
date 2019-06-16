%�֐�: DivideDataType  table���f�[�^�̎�ނ��Ƃɕ�����
%����: dataAll  table�^�̑S�f�[�^
%�Ԃ�l: dataNum, dataSym, dataDate  table�^�̐����̓������f�[�^�Atable�^�̋L���f�[�^�Atable�^�̓��t
function [dataNum, dataSym, dataDate] = DivideDataType(dataAll)
[~, col] = size(dataAll);
typeNumeric = vartype('numeric');
dataNum = dataAll(:,typeNumeric);
typeCeller = vartype('cellstr');
dataSym = dataAll(:,typeCeller);
typeDate = vartype('datetime');
dataDate = dataAll(:,typeDate);

%���ꂼ��̍s��T�C�Y�擾
[~, dataNumColumnLen] = size(dataNum);
[~, dataSymColumnLen] = size(dataSym);
[~, dataDateColumnLen] = size(dataDate);

%���ׂĂ̕ϐ����ꍇ�����ł��Ă��邩�m�F
if col ~= (dataNumColumnLen + dataSymColumnLen + dataDateColumnLen)
    disp('�ϐ����ꍇ�����ł��Ă��܂���')
else
    disp('�ꍇ��������')
end

end