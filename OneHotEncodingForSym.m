%�֐�: OneHotEncodingForSym2   �L���f�[�^��OneHotVector�ɂ��� (�L���̃p�^�[������������Ƃ����̗��NaN��)
%����: dataSym  table�^�̋L���f�[�^
%�Ԃ�l: dataSymOneHot    table�^��OneHotVector
function dataSymOneHot = OneHotEncodingForSym(dataSym, symbolThreshold)
dataSymArray = table2array(dataSym);%table�`����array�`���ɕϊ�,table2cell�ɂ��邱�Ƃ��l����
[row,col] = size(dataSymArray);%�s��̃T�C�Y�擾

dataSymOneHot = table;
flagFirstLoopFlag = 1;
NaNFlag = -1;%�����l�����邩�ǂ����̊m�F
for i = 1 : col
        limitSym = symbolThreshold;
        columnVecter = dataSymArray(:,i);
        set = unique(columnVecter,'stable');%��̏W�����擾
        [setRow,~]= size(set);%�W���̃T�C�Y�擾
        
        %�W���̗�ɂ����āA�����l���m�F�����Ƃ��ɂ��̃C���f�b�N�X���擾
        for j = 1 : setRow
            if (ismissing(set(j,1)) == 1) && (NaNFlag == -1)
                deleteIndex = j;
                NaNFlag = 1;
                limitSym = limitSym + 1;%�W���Ɍ����l�������Ă���ꍇsetRow�̒l�����ۂ��P�傫���Ȃ邽�ߒ���
            end
        end

        %OneHotVector�쐬
        if setRow <= limitSym%���߂�ꂽ�����菬�����ꍇ
                 [~,location] = ismember(columnVecter,set);%columnVector�̊e�v�f�́AcolumnVector�ɂ�����C���f�b�N�X(location)���擾
                 indVecter = ind2vec(transpose(location));%�C���f�b�N�X(location)���x�N�g���֕ϊ��@�@ind2vec  (Neural Network Toolbox��ǉ�����K�v����)
                 oneHotVector = transpose(indVecter);

                  %�V���ȕϐ����̍쐬
                 varNamePlus = strcat(dataSym.Properties.VariableNames{i}, '_');
                 for m = 1 : setRow
                     set(m,1) = strcat(varNamePlus, set(m,1));
                 end
                 
                 %��������
                 if NaNFlag == 1%��Ɍ����l���������ꍇ
                    set(deleteIndex) = [];
                    oneHotVector(:,deleteIndex) = []; 
                 end
                 if isempty(set) == 1%�񂪂��ׂČ����l�ł������ꍇ
                    oneHotVector = (zeros([row,1]));
                    oneHotVector(oneHotVector == 0) = NaN;
                    set = string(dataSym.Properties.VariableNames{i});
                 end
                 
                 set = matlab.lang.makeValidName(set);%�ϐ��Ƃ��ēK�p�\�Ȗ��O�ɕϊ�
                 tmpTable = array2table(oneHotVector, 'VariableNames', transpose(set));
        else%���߂�ꂽ������傫���ꍇ
                oneHotVector = zeros([row 1]);
                oneHotVector(:,1)=NaN;%���ׂĂ̍s��NaN��
                varName = matlab.lang.makeValidName(dataSym.Properties.VariableNames{i});%�ϐ��Ƃ��ēK�p�\�Ȗ��O�ɕϊ�
                tmpTable = array2table(oneHotVector, 'VariableNames', string(varName));
        end
        
        if flagFirstLoopFlag == 1
            dataSymOneHot = tmpTable; 
            flagFirstLoopFlag = -1;
        else
            dataSymOneHot = horzcat(dataSymOneHot, tmpTable);
        end
        
        NaNFlag = -1;
end
end