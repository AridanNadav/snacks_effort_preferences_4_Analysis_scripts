splitpath = strsplit(pwd,'/');
splitpath_minData=[splitpath(1:end-1)];
sub_fold=strjoin(splitpath_minData,'/');
allSUBS_result_folder=[sub_fold '/results/allSUBS'];
singleSUB_result_folder=[sub_fold '/results/singleSUB'];

% subjects to analys
ALLsubjects=[301:320]; % subject to include
subjects2EXclud= [302];% subject to exclude !302 (no data)
subjects=ALLsubjects(~ismember(ALLsubjects,subjects2EXclud));
forloop=length(subjects);

for subjectIndex = 1:forloop
    
    clearvars -except allSUBS_result_folder  singleSUB_result_folder subjects forloop subjectIndex Corrs
    % sub level variabels
    sub_name=num2str(subjects(subjectIndex));
    load(['EVA3_' sub_name '_exp_parameters.mat'],'order')

   
    % BR_D
sub_name=num2str(sub_name);
ranks=(1:27);
ranks=ranks';
%% get _stopGoList_trainingstim
filE=dir([pwd '/EVA3_' sub_name '_stopGoList_trainingstim*.txt']);
filename=filE.name;
delimiter = '\t';
startRow = 1;
formatSpec = '%s%f%f%f%f';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter );
fclose(fileID);
sub_tableBR.trainingstim = table(dataArray{1:3}, 'VariableNames', {'Image','type','bid'});
sub_tableBR.trainingstim=sortrows(sub_tableBR.trainingstim);

clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% get _ItemRankingResults1

filE=dir([pwd '/EVA3_' sub_name '_ItemRankingResults*.txt']);
filename=filE(1).name;
delimiter = '\t';
startRow = 2;
formatSpec = '%s%s%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);

sub_tableBR.BR1 = table(dataArray{2:4}, 'VariableNames', {'Image','rank','coli_Weight'});
sub_tableBR.BR1=sortrows(sub_tableBR.BR1,3);
sub_tableBR.BR1{:,2}=ranks;
sub_tableBR.BR1=sortrows(sub_tableBR.BR1);

clearvars filename delimiter startRow formatSpec fileID dataArray ans;

Corrs(subjectIndex,1)=subjects(subjectIndex);
Corrs(subjectIndex,2)=corr(sub_tableBR.BR1{:,2},sub_tableBR.trainingstim {:,3} );
Corrs(subjectIndex,3)=corr(sub_tableBR.BR1{:,2},sub_tableBR.trainingstim {:,3},'type','Spearman' );

    
end % single sub for loop

BDM_BR_COrrs = table(Corrs(:,1),Corrs(:,2),Corrs(:,3), 'VariableNames', {'subject','pearson','spearman'});
save ([allSUBS_result_folder '/BDM_BR_COrrs.mat'],'BDM_BR_COrrs')
