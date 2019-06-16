%�֐�: OneHotEncodingForNum   �����̋L���f�[�^��OneHotVector�ɂ���
%����: dataNumSym   table�^�̐����f�[�^
%�Ԃ�l: dataNumSymOneHot    table�^��OneHotVecter
function dataNumSymOneHot = OneHotEncodingForNum(dataNumSym)
dataNumSymArray = table2array(dataNumSym);%table�`����array�`���ɕϊ�
[row, col] = size(dataNumSymArray);%�s��̃T�C�Y�擾

dataNumSymOneHot = table;
flagFirstLoopF = 1;
zeroFlag = 1;
for i = 1 : col
        columnVector = dataNumSymArray(:,i);
        set = myUnique(columnVector);%��̏W�����擾
        [setRow,~]= size(set);%�W���̃T�C�Y�擾
             
        %OneHotVector�쐬
        [~,location] = ismember(columnVector,set);%columnVector�̊e�v�f�́AcolumnVector�ɂ�����C���f�b�N�X(location)���擾
        zeroFlag = unique(location(location==0));
        if zeroFlag == 0
            location(location == 0) = (max(location) + 1);%ind2vec���g����悤�ɃC���f�b�N�X�𒲐�
        end
            
        indVecter = ind2vec(transpose(location));%�C���f�b�N�X(location)���x�N�g���֕ϊ�
        oneHotVector = transpose(indVecter);
        if zeroFlag == 0
            set(setRow)=[];%�W������NaN���폜,�����MyUnique�̂������łł���
            oneHotVector(:,setRow) = []; %oneHotVector����NaN�̃x�N�g�����폜,�����MyUnique�̂������łł���
        end
        if isempty(set) == 1%�񂪂��ׂČ����l�ł������ꍇ
            oneHotVector = (zeros([row,1]));
            oneHotVector(oneHotVector == 0) = NaN;
            newVarName = string(dataNumSym.Properties.VariableNames{i});%�ϐ����͂��̂܂�
        else
            [newSetRow, ~]= size(set); %�s��̃T�C�Y���Ď擾      
            varNamePlus = strcat(dataNumSym.Properties.VariableNames{i}, '_');%�V���ȕϐ�����^����
            %�ϐ����̔z�������B
            newVarName = string(zeros([1 newSetRow])); %NaN��OneHot�x�N�g�����폜���Ă���ꍇ�̂���
            for m = 1 : newSetRow
                 newVarName(1,m) = strcat(varNamePlus, string(set(m,1)));
            end 
        end
        newVarName = matlab.lang.makeValidName(newVarName);%�ϐ��Ƃ��ēK�p�\�Ȗ��O�ɕϊ�
        tmpTable = array2table(oneHotVector, 'VariableNames', newVarName);
        if flagFirstLoopF == 1
            dataNumSymOneHot = tmpTable; 
            flagFirstLoopF = -1;
        else
            dataNumSymOneHot = horzcat(dataNumSymOneHot, tmpTable);
        end
        
        zeroFlag = 1;
end
end

function y = myUnique(x)
  y = unique(x,'stable');
  if any(isnan(y))
    y(isnan(y)) = []; % remove all nans
    y(end+1,1) = NaN; % add the unique one.
  end
end