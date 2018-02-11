addpath('/Users/papanadipapanadi/Google_Drive/Tom_LAB/Experiments/Effort_Value_Association/thired_run_300s/EVAsnacks/analysis_scripts')
% set result_folder
splitpath = strsplit(pwd,'/');
splitpath_minData=[splitpath(1:end-1)];
sub_fold=strjoin(splitpath_minData,'/');
allSUBS_result_folder=[sub_fold '/results/allSUBS'];
singleSUB_result_folder=[sub_fold '/results/singleSUB'];

% subjects to analys
ALLsubjects=[301:332]; % subject to include
% subjects2EXclud= [302,309,318,321,324,327,320,];% subject to exclude: *no data(302),*low bdm (309,318,321,324,327), didnt fast (320)


% PROBE X
subjects2EXclud= [302,309,318,321,324,327,320,329];% subject to exclude: *no data(302),*low bdm (309,318,321,324,327), didnt fast (320)

subjects=ALLsubjects(~ismember(ALLsubjects,subjects2EXclud));
forloop=length(subjects);


ALLSubData=[]

for subjectIndex = 1:forloop
    % sub level variabels
    sub_name=num2str(subjects(subjectIndex));
    load([ 'EVA3_' sub_name '_exp_parameters.mat'],'order')
    
%     Probe_recode_mac
%     recalc_is_choice1
%     recode_probe_from_BR2
%    recode_probe_from_BR1
 
recode_BR_Xtra


 % subject_data(:,2:13)=[]   ;
subject_data(:,2:3)=[]
subject_data(:,1)=subjects(subjectIndex);
ALLSubData =[ALLSubData ; subject_data];
 

end % single sub for loop
