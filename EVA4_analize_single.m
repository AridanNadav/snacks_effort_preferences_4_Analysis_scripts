% EVA4_analize_single
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% single subject level
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% run from  output folder
% require results folder with subfolders: singleSUB,allSUBS
 addpath('/Users/papanadipapanadi/Google_Drive/Tom_LAB/Experiments/EVA4/analysis_scripts')
% set result_folder
splitpath = strsplit(pwd,'/');
splitpath_minData=[splitpath(1:end-1)];
sub_fold=strjoin(splitpath_minData,'/');
allSUBS_result_folder=[sub_fold '/results/allSUBS'];
singleSUB_result_folder=[sub_fold '/results/singleSUB'];

% subjects to analys
ALLsubjects=[401:426]; % subject to include 401:426
subjects2EXclud= [423];% 423-only till training 426-only till BR2 423,426
subjects=ALLsubjects(~ismember(ALLsubjects,subjects2EXclud));
forloop=length(subjects);
allsubT=[]
allsubs=zeros(forloop,5)
for subjectIndex = 1:forloop
    
    %clearvars -except allSUBS_result_folder  singleSUB_result_folder subjects forloop subjectIndex ALLsubjects sub_fold
    % sub level variabels
    sub_name=num2str(subjects(subjectIndex)); 
matlogs=dir([pwd '/EVA4_' sub_name '_calib*.mat' ]) ;
% load(matlogs(1).name,'SelfPower')
% allsubT=[allsubT; SelfPower]

% %  demos   
% %   BDM_analysis
% %       grip_practice_and_VAS_analysis
% %       VAS_recognition
% %      BR_D
        Probe_analysis
% %     recode_BR_Xtra
% %     recode_BR1_Xtra
end % single sub for loop

rmpath('/Users/papanadipapanadi/Google_Drive/Tom_LAB/Experiments/Effort_Value_Association/thired_run_300s/EVAsnacks/analysis_scripts')
