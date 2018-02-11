% EVA3_analize_delta percieved effort of high and low effort items in probe

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% single subject level
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% run from  output folder
% require results folder with subfolders: singleSUB,allSUBS
addpath('/Users/papanadipapanadi/Google_Drive/Tom_LAB/Experiments/EVA3/analysis_scripts')
splitpath = strsplit(pwd,'/');
splitpath_minData=[splitpath(1:end-1)];
sub_fold=strjoin(splitpath_minData,'/');
allSUBS_result_folder=[sub_fold '/results/allSUBS'];
singleSUB_result_folder=[sub_fold '/results/singleSUB'];

% subjects to analys
ALLsubjects=[301:332]; % subject to include
subjects2EXclud= [302,309,318,320,321,324,327,329];
subjects=ALLsubjects(~ismember(ALLsubjects,subjects2EXclud));
forloop=length(subjects);
finalT=[];
%% probe data
for subjectIndex = 1:forloop
    subT=[];
    sub_name=num2str(subjects(subjectIndex))
    load(['EVA3_' sub_name '_exp_parameters.mat'],'order')
    %% probe
    
    logs=dir([pwd '/EVA3_' sub_name '_probe_block_*.txt' ]) ;
    
    subject_data=[];
    for datafile = 1:length(logs)
        fid=fopen([pwd '/' logs(datafile).name]);
        Data=textscan(fid, '%s%f%f%f%f%f%f%s%s%f%f%f%s%f%f%f%f%f' , 'HeaderLines', 1);     %read in probe output file into P ;
        
        % Convert all string variables into numbers
        Data{1}(:)={subjects(subjectIndex)}; %subject's code
        
        
        % convert stimuli names into numbers
        image_ending=Data{8}{1}(find(Data{8}{1}=='.'):end);
        [~,stimuls_name_is_numeric] = str2num(Data{8}{1}(1:end-length(image_ending)));
        % if the stimuli have numeric name, remove the '.xxx' ending
        if stimuls_name_is_numeric
            for i=1:length(Data{1})
                Data{8}{i}=str2num(Data{8}{i}(1:end-length(image_ending))); % left stimulus
                Data{9}{i}=str2num(Data{9}{i}(1:end-length(image_ending))); % right stimulus
            end
            
            % if the stimuli do not have numeric names, replace the columns with 0's
        else
            Data{8}={zeros(length(Data{8}),1)}; % left stimulus
            Data{9}={zeros(length(Data{9}),1)}; % right stimulus
        end
        
        Data{13}(strcmp(Data{13},'u'))={1}; % response: 1 for left
        Data{13}(strcmp(Data{13},'i'))={0}; % response: 0 for right
        Data{13}(strcmp(Data{13},'x'))={999}; % response: 99 for no response
        
        Data{1}=cell2mat(Data{1});
        Data{8}=cell2mat(Data{8});
        Data{9}=cell2mat(Data{9});
        %         Data{10}=cell2mat(Data{10});
        %     Data{11}=cell2mat(Data{11});
        
        Data{13}=cell2mat(Data{13});
        
        fclose(fid);
        subject_data(end+1:end+length(Data{1}),:)=cell2mat(Data);
    end % end of looping through probe files
    
    
    % bidIndex to 1:27
    import_roseta
    for reoutcome=1:length(subject_data)
        subject_data(reoutcome,19)=    find(roseta{:,order+4}==subject_data(reoutcome,10));
        subject_data(reoutcome,20)=     find(roseta{:,order+4}==subject_data(reoutcome,11));
    end
    
    probeT=array2table([subject_data(:,1) subject_data(:,3) subject_data(:,19) subject_data(:,20) subject_data(:,12) ones(length(subject_data),1)*2],'VariableNames',{'subjectID',' order',' Item_Left',' Item_Right',' Response','BeforeORafter_training'});
    
    subT=[subT ; probeT];
    
    %%  recode_probe_from_BR2
    
    % get data to mat
    logs=dir([pwd '/EVA3_' sub_name '_binary_ranking*.txt' ]) ;
    SIZE=size(logs);
    if SIZE(1)~=2; error('wrong number of files'); end
    
    for BRcount=1:2
        clear data
        fid=fopen([pwd '/' logs(BRcount).name]);
        Data=textscan(fid, '%s%f%f%s%s%f%f%s%f%f' , 'HeaderLines', 1);     %read in probe output file into P ;
        Data{1}(:)={subjects(subjectIndex)}; %subject's code
        % convert stimuli names into numbers
        image_ending=Data{4}{1}(find(Data{4}{1}=='.'):end);
        [~,stimuls_name_is_numeric] = str2num(Data{4}{1}(1:end-length(image_ending)));
        % if the stimuli have numeric name, remove the '.xxx' ending
        if stimuls_name_is_numeric
            for i=1:length(Data{1})
                Data{4}{i}=str2num(Data{4}{i}(1:end-length(image_ending))); % left stimulus
                Data{5}{i}=str2num(Data{5}{i}(1:end-length(image_ending))); % right stimulus
            end
            
            % if the stimuli do not have numeric names, replace the columns with 0's
        else
            Data{4}={zeros(length(Data{4}),1)}; % left stimulus
            Data{5}={zeros(length(Data{5}),1)}; % right stimulus
        end
        Data{8}(strcmp(Data{8},'u'))={1}; % response: 1 for left
        Data{8}(strcmp(Data{8},'i'))={0}; % response: 0 for right
        Data{8}(strcmp(Data{8},'x'))={999}; % response: 99 for no response
        Data{1}=cell2mat(Data{1});
        Data{4}=cell2mat(Data{4});
        Data{5}=cell2mat(Data{5});
        Data{8}=cell2mat(Data{8});
        fclose(fid);
        subject_BR2data=cell2mat(Data);
        BRdata=array2table([subject_BR2data(:,1) ones(length(subject_BR2data),1)*order subject_BR2data(:,6) subject_BR2data(:,7) subject_BR2data(:,8) ones(length(subject_BR2data),1)*BRcount],'VariableNames',{'subjectID',' order',' Item_Left',' Item_Right',' Response','BeforeORafter_training'});
        
        subT=[subT ; BRdata];
    end
    %% bids
    bids=array2table([subject_data(:,19) subject_data(:,17)  ]);
    bids=sortrows(bids);
    location=1  ;
    for cntr=1:height(bids)
        if  bids{cntr,1}==location
            newBIDS(location,:)=  bids{cntr,:};
            location=location+1   ;
        end
    end
    
    if length(newBIDS)~=27
        error ('bids did not work')
    end
    
    for i=1:height(subT)
        bid(i,1)=   newBIDS(subT{i,'Item_Left'},2);
        bid(i,2)=   newBIDS(subT{i,'Item_Right'},2);
    end
    bid(:,3)=bid(:,1)-bid(:,2);
    BIDsT=array2table(bid,'VariableNames',{'bid_left','bid_right','delta_bid'});
    subT=[subT BIDsT];
    
%% vas data
     %_practice_VAS
    sub_num=[num2str(subjects(subjectIndex))];
    sub_name=['sub_' num2str(subjects(subjectIndex))];
    
    load(['EVA3_' sub_num '_exp_parameters.mat'],'order')
    
    filE=dir([pwd '/EVA3_' sub_num '_practice_VAS*.txt']);
    filename=filE.name;
    delimiter = '\t';
    startRow = 2;
    formatSpec = '%f%f%f%f%f%f%s%[^\n\r]';
    % Open the text file.
    fileID = fopen(filename,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
    % Close the text file.
    fclose(fileID);
    % Create output variable
    sub_tableGpVs = table(dataArray{1:end-1}, 'VariableNames', {'Image_num','Effort_level','Effort_rate','VAS_res_time','Goal','time2Goal','V_vector'});
    % Clear temporary variables
    clearvars filename delimiter startRow formatSpec fileID  ans;
    sub_tableGpVs=sortrows(sub_tableGpVs);
    
    % mean across 10 PE of each of the 27
    PEvec=[];
    for i=1:10:270
        PEvec= [PEvec mean(sub_tableGpVs{i:i+9,3})];
    end
    subsPE.(sub_name).('vas_1')=(PEvec);
    
    % vas recog
    filE=dir([pwd '/EVA3_' sub_num 'VAS_*.txt']);
    filename=filE.name;
    delimiter = '\t';
    startRow = 2;
    formatSpec = '%f%f%f%f%f%f%s%[^\n\r]';
    fileID = fopen(filename,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
    fclose(fileID);
    sub_tableVrcg = table(dataArray{1:4}, 'VariableNames', {'Image_num','Effort_level','VAS_recognition','VAS_res_time'});
    clearvars filename delimiter startRow formatSpec fileID dataArray ans;
    sub_tableVrcg=sortrows(sub_tableVrcg);
    
    
    subsPE.(sub_name).('vas_2')=(sub_tableVrcg{:,3});
    
    
    

%% PE into finalT
PEs=[];

    for k=1:height(subT)
        PEs(k,1)=subsPE.(sub_name).vas_1(subT{k,'Item_Left'});
        PEs(k,2)=subsPE.(sub_name).vas_1(subT{k,'Item_Right'});
        PEs(k,3)=subsPE.(sub_name).vas_2(subT{k,'Item_Left'});
        PEs(k,4)=subsPE.(sub_name).vas_2(subT{k,'Item_Right'});
       
    end

PEallsubTable=array2table(PEs,'VariableNames',{'PE1_left','PE1_right','PE2_left','PE2_right'});
    subT=[subT PEallsubTable];








%%
D_LminR_PE1=subT{:,'PE1_left'}-subT{:,'PE1_right'};
D_LminR_PE2=subT{:,'PE2_left'}-subT{:,'PE2_right'};

D=array2table([D_LminR_PE1 D_LminR_PE2],'VariableNames',{'D_LminR_PE1','D_LminR_PE2'});
subT=[subT D];


    %%
    
    
    
    finalT=[finalT; subT];
    
    
    
end % single sub for loop

% extract value levels and comparison type% join tables
finalT{(finalT{:,'Response'}==999),'Response'}=NaN;




%%
writetable(finalT,[pwd '/EVA3_2308BR.csv'])
