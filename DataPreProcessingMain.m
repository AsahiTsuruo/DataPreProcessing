%DataPreProcessing���C���X�N���v�g
clear;
clc;

run('Configuration.m');
load('conf.mat');

%mkdir result%result�f�B���N�g���쐬
dataOriAll = readtable(filename,'ReadVariableNames',true,'ReadRowNames',true);%table�`���Ńt�@�C���ǂݍ���

%�ϐ����ƍs����ύX�����f�[�^,�Ή��\�������o��
[dataAll, backTrackVarName,backTrackRowName] = ConvertVarAndRowName(dataOriAll);%�ϐ���,�s����ϊ�
writetable(dataAll, strcat('result/backTrack_',filename), 'WriteVariableNames', true,'WriteRowNames', true);
writetable(backTrackVarName, 'result/backTrackVarName.csv', 'WriteVariableNames', false, 'WriteRowNames', false);
writetable(backTrackRowName, 'result/backTrackRowName.csv', 'WriteVariableNames', false, 'WriteRowNames', false);



%�f�[�^�𐔎��A���t�A�L���ɏꍇ�������A���ꂼ��̃f�[�^�������o���Ă���
[dataNum, dataSym, dataDate] = DivideDataType(dataAll);%�f�[�^�𐔎��A���t�A�L���ɂ킯��
writetable(dataNum,'result/DataNum.csv','WriteVariableNames',true,'WriteRowNames',true);
writetable(dataSym,'result/DataSym.csv','WriteVariableNames',true,'WriteRowNames',true);
writetable(dataDate,'result/DataDate.csv','WriteVariableNames',true,'WriteRowNames',true);

%�����f�[�^�𐔒l�Ȃ̂��L���Ȃ̂������ʂ��A�����o��
[dataNumVal, dataNumSym] = DiscriminateNum(dataNum, numericThreshold);
writetable(dataNumVal,'result/dataNumVal.csv','WriteVariableNames',true,'WriteRowNames',true);
writetable(dataNumSym,'result/dataNumSym.csv','WriteVariableNames',true,'WriteRowNames',true);

%���l�f�[�^�𐳋K���A�����o��
dataZScore = CalculateZScore(dataNumVal, normalizationFlag);
writetable(dataZScore,'result/dataZScore.csv','WriteVariableNames',true,'WriteRowNames',true);

%�����f�[�^����L���f�[�^�ł���Ɣ��肳�ꂽ�f�[�^��One-Hot vector�ɕϊ��A�����o��
dataNumSymOneHot = OneHotEncodingForNum(dataNumSym);
writetable(dataNumSymOneHot,'result/dataNumSymOneHot.csv','WriteVariableNames',true,'WriteRowNames',true);

%�L���f�[�^��One-Hot vector�ɕϊ��A�����o��
dataSymOneHot = OneHotEncodingForSym(dataSym, symbolThreshold);
writetable(dataSymOneHot,'result/dataSymOneHot.csv','WriteVariableNames',true,'WriteRowNames',true);

%���t��Not a Number�ɂ���
dataDateNaN = DataToNaN(dataDate);
writetable(dataDateNaN,'result/dataDateNaN.csv','WriteVariableNames',true,'WriteRowNames',true);

%�S�f�[�^��A�� 
dataFinal = horzcat(dataZScore, dataNumSymOneHot, dataSymOneHot, dataDateNaN);
dataFinalSorted = dataFinal(:, natsortfiles(dataFinal.Properties.VariableNames));%�ϐ�����sort�@Natural-Order Filename Sort ���K�v
writetable(dataFinalSorted,'result/dataFinalVer1.csv','WriteVariableNames',true,'WriteRowNames',true);
writetable(dataFinalSorted,'result/dataFinalVer2.csv','WriteVariableNames',false,'WriteRowNames',false);
