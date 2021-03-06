% EVA4_analize_delta percieved effort of high and low effort items in probe

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


%% probe data
allsubT=[];

for subjectIndex = 1:forloop
    
    sub_name=num2str(subjects(subjectIndex))
    load(['EVA4_' sub_name '_exp_parameters.mat'],'order')
    Probe_analysis
    % bidIndex to 1:27
    import_roseta
    for reoutcome=1:length(subject_data)
        subject_data(reoutcome,19)=    find(roseta{:,order+4}==subject_data(reoutcome,10));
        subject_data(reoutcome,20)=     find(roseta{:,order+4}==subject_data(reoutcome,11));
    end
    allsubT=[ allsubT ; subject_data ];
end % single sub for loop

allsubTable=array2table(allsubT,'VariableNames',{ 'subjectID','scanner','order','block','run','trial','onsettime','ImageLeft','ImageRight','bidIndexLeft','bidIndexRight','IsleftGo','Response_is_L','PairType','Outcome_RealEffort','RT','bidLeft','bidRight','itemL','itemR'});
% extract value levels and comparison type
pairtype2val_comp;
% join tables
finalT=[allsubTable(:,{'subjectID','itemL','itemR','Response_is_L'}) valcomp allsubTable(:,{'Outcome_RealEffort'})];

finalT{(finalT{:,'Response_is_L'}==999),'Response_is_L'}=NaN;
%% vas data

 
for subjectIndex = 1:forloop
    
    sub_num=[num2str(subjects(subjectIndex))];
    sub_name=['sub_' num2str(subjects(subjectIndex))];
    
    load(['EVA4_' sub_num '_exp_parameters.mat'],'order')
    
    logs=dir([pwd '/EVA4_' sub_num '_vas_*.txt' ]) ;
    
    for i=1:length(logs)
        subsPE.(sub_name).(['vas_' num2str(i)])=readVAS(logs(i).name);
        
        
%         zz=zscore( subsPE.(sub_name).(['vas_' num2str(i)]){~isnan(subsPE.(sub_name).(['vas_' num2str(i)]){:,'Effort_rate'}),'Effort_rate'});
%         locZ=1;
%         for x=1:height(subsPE.(sub_name).(['vas_' num2str(i)]))
%             if ~isnan(subsPE.(sub_name).(['vas_' num2str(i)]){x,'Effort_rate'})
%                 subsPE.(sub_name).(['vas_' num2str(i)]){x,'Effort_rate'}=    zz(locZ);
%                 locZ=locZ+1;
%             end
%         end
    end % single sub for loop
end




%% PE into finalT
PEs=[];
for subjectIndex = 1:forloop
    sub_name=['sub_' num2str(subjects(subjectIndex))];
    for k=1:162
    PEs((((subjectIndex-1)*162)+k),1)=subsPE.(sub_name).vas_1{finalT{(((subjectIndex-1)*162)+k),'itemL'},'Effort_rate'};
    PEs((((subjectIndex-1)*162)+k),2)=subsPE.(sub_name).vas_1{finalT{(((subjectIndex-1)*162)+k),'itemR'},'Effort_rate'};
    PEs((((subjectIndex-1)*162)+k),3)=subsPE.(sub_name).vas_2{finalT{(((subjectIndex-1)*162)+k),'itemL'},'Effort_rate'};
    PEs((((subjectIndex-1)*162)+k),4)=subsPE.(sub_name).vas_2{finalT{(((subjectIndex-1)*162)+k),'itemR'},'Effort_rate'};   
    PEs((((subjectIndex-1)*162)+k),5)=subsPE.(sub_name).vas_3{finalT{(((subjectIndex-1)*162)+k),'itemL'},'Effort_rate'};
    PEs((((subjectIndex-1)*162)+k),6)=subsPE.(sub_name).vas_3{finalT{(((subjectIndex-1)*162)+k),'itemR'},'Effort_rate'};       
        

    end
end

PEallsubTable=array2table(PEs,'VariableNames',{'PE1_left','PE1_right','PE2_left','PE2_right','PE3_left','PE3_right'});
finalT2=[finalT PEallsubTable];

%%     %! independent variable: Delta PE of RE high-low 
IVs=[]
for count=1:height(finalT2)
    if finalT2{count,'itemL'}> finalT2{count,'itemR'}
        IVs(count,1)= finalT2{count,'PE1_left'}- finalT2{count,'PE1_right'};
        IVs(count,2)= finalT2{count,'PE2_left'}- finalT2{count,'PE2_right'};
    else
       IVs(count,1)= finalT2{count,'PE1_right'}- finalT2{count,'PE1_left'};
       IVs(count,2)= finalT2{count,'PE2_right'}- finalT2{count,'PE2_left'};
    end
end    
DVsallsubTable=array2table(IVs,'VariableNames',{'D_PE_HL_byRE_vas1','D_PE_HL_byRE_vas2'});
finalT2=[finalT2 DVsallsubTable];


%%     %! independent variable: Delta PE of PE high-low 
IVs=[]
for count=1:height(finalT2)
    if finalT2{count,'PE1_left'}> finalT2{count,'PE1_right'}
        IVs(count,1)= finalT2{count,'PE1_left'}- finalT2{count,'PE1_right'};
    else
       IVs(count,1)= finalT2{count,'PE1_right'}- finalT2{count,'PE1_left'};
    end

    if finalT2{count,'PE2_left'}> finalT2{count,'PE2_right'}
        IVs(count,2)= finalT2{count,'PE2_left'}- finalT2{count,'PE2_right'};
    else
       IVs(count,2)= finalT2{count,'PE2_right'}- finalT2{count,'PE2_left'};
    end
end    
DVsallsubTable=array2table(IVs,'VariableNames',{'D_PE_HL_byPE_vas1','D_PE_HL_byPE_vas2'});
finalT2=[finalT2 DVsallsubTable];




%% recalculate outcome to choose higher PE 2
for PEs=1:3
    PES=num2str(PEs);
Outs=[]
for count=1:height(finalT2)
    % PE hiegher is chosen
        if ~isnan(finalT2{count,['PE' PES '_left']}) &&  ~isnan(finalT2{count,['PE' PES '_right']}) &&  ~isnan(finalT2{count,'Response_is_L'})

    if ((finalT2{count,['PE' PES '_left']}>finalT2{count,['PE' PES '_right']})&&(finalT2{count,'Response_is_L'}))||((finalT2{count,['PE' PES '_left']}<finalT2{count,['PE' PES '_right']})&& ~(finalT2{count,'Response_is_L'}))
    Outs(count,1)= 1;
    elseif finalT2{count,['PE' PES '_left']}==finalT2{count,['PE' PES '_right']}
    Outs(count,1)=NaN;
    else
    Outs(count,1)=0;
    
    end
      else
        Outs(count,1)=NaN;
    end
end    
Outs=array2table(Outs,'VariableNames',{['Outcome_PE_vas' PES ]});
finalT2=[finalT2 Outs];
end

%%
D_LminR_PE1=finalT2{:,'PE1_left'}-finalT2{:,'PE1_right'};
D_LminR_PE2=finalT2{:,'PE2_left'}-finalT2{:,'PE2_right'};
D_LminR_PE3=finalT2{:,'PE3_left'}-finalT2{:,'PE3_right'};

D=array2table([D_LminR_PE1 D_LminR_PE2 D_LminR_PE3],'VariableNames',{'D_LminR_PE1','D_LminR_PE2','D_LminR_PE3'});
finalT2=[finalT2 D];

%%



%%
writetable(finalT2,[pwd '/EVA4_2308.csv'])
