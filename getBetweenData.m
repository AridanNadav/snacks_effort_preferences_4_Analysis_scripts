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
ALLsubjects=[401:427]; % subject to include 401:426
subjects2EXclud= [423,426];% 423-only till training 426-only till BR2 423,426 
subjects=ALLsubjects(~ismember(ALLsubjects,subjects2EXclud));
forloop=length(subjects);


allsubT=[]

for subjectIndex = 1:forloop
    
    %%
    sub_name=num2str(subjects(subjectIndex))
%     load(['EVA4_' sub_name '_exp_parameters.mat'],'SelfPower')
%      allsubT(subjectIndex,5)=SelfPower;
     allsubT(subjectIndex,1)=subjects(subjectIndex);
%     %%
%     filename=dir([pwd '/EVA4_' sub_name '_personalDetails*.txt']);
%     filename = filename.name;
%     delimiter = '\t';
%     startRow = 2;
%     formatSpec = '%s%f%s%f%f%f%s%[^\n\r]';
%     fileID = fopen(filename,'r');
%     dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
%     fclose(fileID);
%     sex= dataArray{4};
%     clearvars filename delimiter startRow formatSpec fileID dataArray ans;
%     
%     allsubT(subjectIndex,2)=sex;
%     %%
%     load_bdm1_bdm2
%     
%     allsubT(subjectIndex,3)=mean(sub_array.BDM1{:,3});
%     allsubT(subjectIndex,4)=mean(sub_array.BDM2{:,3});
    
    %%
%     
%     
%     open([singleSUB_result_folder '/' sub_name ' Percived effort.fig']);
%     h = gcf %current figure handle;
%     axesObjs = get(h, 'Children');  %axes handles
%     dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
%     ydata = get(dataObjs{2}, 'YData');
%     
%     HE=mean([ydata{2,1}(3),ydata{3,1}(3),ydata{4,1}(3)]);%
%     ME=mean([ydata{2,1}(2),ydata{3,1}(2),ydata{4,1}(2)]);%
%     LE=mean([ydata{2,1}(1),ydata{3,1}(1),ydata{4,1}(1)]);%
%     
%     allsubT(subjectIndex,5)= mean(abs(9-HE)+abs(5-HE)+abs(1-HE));
%     close(h)
%     
    %%
%     open([singleSUB_result_folder '/' sub_name ' VAS Recognition.fig']);
%     h = gcf %current figure handle;
%     axesObjs = get(h, 'Children');  %axes handles
%     dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
%     ydata = get(dataObjs{2}, 'YData');
%     
%     HE=mean([ydata{2,1}(3),ydata{3,1}(3),ydata{4,1}(3)]);%
%     ME=mean([ydata{2,1}(2),ydata{3,1}(2),ydata{4,1}(2)]);%
%     LE=mean([ydata{2,1}(1),ydata{3,1}(1),ydata{4,1}(1)]);%
%     
%     allsubT(subjectIndex,6)= mean(abs(9-HE)+abs(5-HE)+abs(1-HE));
%     close(h)
    
open([singleSUB_result_folder '/' sub_name '_BDM_DofMeans.fig']);
    h = gcf %current figure handle;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    ydata = get(dataObjs{2}, 'YData');
    
    dbidmat=cell2mat(ydata(2:4,1));
    
    for i=1:3
 allsubT(subjectIndex,i+1)=dbidmat(i,3)-dbidmat(i,1);
    end
    close(h)
end
%%






rmpath('/Users/papanadipapanadi/Google_Drive/Tom_LAB/Experiments/EVA3/analysis_scripts')
