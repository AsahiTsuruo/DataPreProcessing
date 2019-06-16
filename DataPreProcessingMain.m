%DataPreProcessingメインスクリプト
clear;
clc;

run('Configuration.m');
load('conf.mat');

%mkdir result%resultディレクトリ作成
dataOriAll = readtable(filename,'ReadVariableNames',true,'ReadRowNames',true);%table形式でファイル読み込み

%変数名と行名を変更したデータ,対応表を書き出す
[dataAll, backTrackVarName,backTrackRowName] = ConvertVarAndRowName(dataOriAll);%変数名,行名を変換
writetable(dataAll, strcat('result/backTrack_',filename), 'WriteVariableNames', true,'WriteRowNames', true);
writetable(backTrackVarName, 'result/backTrackVarName.csv', 'WriteVariableNames', false, 'WriteRowNames', false);
writetable(backTrackRowName, 'result/backTrackRowName.csv', 'WriteVariableNames', false, 'WriteRowNames', false);



%データを数字、日付、記号に場合分けし、それぞれのデータを書き出しておく
[dataNum, dataSym, dataDate] = DivideDataType(dataAll);%データを数字、日付、記号にわける
writetable(dataNum,'result/DataNum.csv','WriteVariableNames',true,'WriteRowNames',true);
writetable(dataSym,'result/DataSym.csv','WriteVariableNames',true,'WriteRowNames',true);
writetable(dataDate,'result/DataDate.csv','WriteVariableNames',true,'WriteRowNames',true);

%数字データを数値なのか記号なのかを識別し、書き出し
[dataNumVal, dataNumSym] = DiscriminateNum(dataNum, numericThreshold);
writetable(dataNumVal,'result/dataNumVal.csv','WriteVariableNames',true,'WriteRowNames',true);
writetable(dataNumSym,'result/dataNumSym.csv','WriteVariableNames',true,'WriteRowNames',true);

%数値データを正規化、書き出し
dataZScore = CalculateZScore(dataNumVal, normalizationFlag);
writetable(dataZScore,'result/dataZScore.csv','WriteVariableNames',true,'WriteRowNames',true);

%数字データから記号データであると判定されたデータをOne-Hot vectorに変換、書き出し
dataNumSymOneHot = OneHotEncodingForNum(dataNumSym);
writetable(dataNumSymOneHot,'result/dataNumSymOneHot.csv','WriteVariableNames',true,'WriteRowNames',true);

%記号データをOne-Hot vectorに変換、書き出し
dataSymOneHot = OneHotEncodingForSym(dataSym, symbolThreshold);
writetable(dataSymOneHot,'result/dataSymOneHot.csv','WriteVariableNames',true,'WriteRowNames',true);

%日付をNot a Numberにする
dataDateNaN = DataToNaN(dataDate);
writetable(dataDateNaN,'result/dataDateNaN.csv','WriteVariableNames',true,'WriteRowNames',true);

%全データを連結 
dataFinal = horzcat(dataZScore, dataNumSymOneHot, dataSymOneHot, dataDateNaN);
dataFinalSorted = dataFinal(:, natsortfiles(dataFinal.Properties.VariableNames));%変数名でsort　Natural-Order Filename Sort が必要
writetable(dataFinalSorted,'result/dataFinalVer1.csv','WriteVariableNames',true,'WriteRowNames',true);
writetable(dataFinalSorted,'result/dataFinalVer2.csv','WriteVariableNames',false,'WriteRowNames',false);
