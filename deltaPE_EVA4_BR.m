% EVA4_analize_delta percieved effort of high and low effort items in probe

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% single subject level
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% require results folder with subfolders: singleSUB,allSUBS
% run from  analysis_scripts folder

%set paths
splitpath = strsplit(pwd,'/');
mainfold=strjoin(splitpath(1:end-1),'/');
Output_folder=[mainfold '/Output'];
result_folder=[mainfold '/results/'];


% subjects to analize
ALLsubjects=[401:427]; % subject to include 401:426
subjects2EXclud= [423,426,421];% 423-only till training 426-only till BR2 423,426  % 421 wrong number of choice data?
subjects=ALLsubjects(~ismember(ALLsubjects,subjects2EXclud));
forloop=length(subjects);
finalT=[];% all subject data
%% probe data
for subjectIndex = 1:forloop
    subT=[];% subject data
    sub_name=num2str(subjects(subjectIndex))
    load([ Output_folder '/EVA4_' sub_name '_exp_parameters.mat'],'order')
    
    %% probe
    logs=dir([Output_folder '/EVA4_' sub_name '_probe_block_*.txt' ]) ;
    subject_data=[];
    for datafile = 1:length(logs)
        fid=fopen([Output_folder '/' logs(datafile).name]);
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
        Data{2}=(ones(length(Data{13}),1)*datafile);

        fclose(fid);
        subject_data(end+1:end+length(Data{1}),:)=cell2mat(Data);
    end % end of looping through probe files
    
    
    % bidIndex to 1:27
    import_roseta
    for reoutcome=1:length(subject_data)
        subject_data(reoutcome,19)=    find(roseta{:,order+4}==subject_data(reoutcome,10));
        subject_data(reoutcome,20)=     find(roseta{:,order+4}==subject_data(reoutcome,11));
    end
    
    %=array2table([subject_data(:,1) subject_data(:,3) subject_data(:,19) subject_data(:,20) subject_data(:,12) ones(length(subject_data),1)*2],'VariableNames',{'subjectID',' order',' Item_Left',' Item_Right',' Response','BeforeORafter_training'});
    probeT=array2table([subject_data(:,1) subject_data(:,2) subject_data(:,3) subject_data(:,6) subject_data(:,19) subject_data(:,20) subject_data(:,12) ones(length(subject_data),1)*2],'VariableNames',{'subjectID','probeRun',' order','trial',' Item_Left',' Item_Right',' Response','BeforeORafter_training'});

    subT=[subT ; probeT];
    
    %%  recode_probe_from_BR2
    
    % get data to mat
    logs=dir([Output_folder '/EVA4_' sub_name '_binary_ranking*.txt' ]) ;
    SIZE=size(logs);
    if SIZE(1)~=2; error('wrong number of files'); end
    
    for BRcount=1:2
        clear data
        fid=fopen([Output_folder '/' logs(BRcount).name]);
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
                Data{3}=zeros(length(Data{3}),1);

        fclose(fid);
        subject_BR2data=cell2mat(Data);
        BRdata=array2table([subject_BR2data(:,1) subject_BR2data(:,3) subject_BR2data(:,2) ones(length(subject_BR2data),1)*order subject_BR2data(:,6) subject_BR2data(:,7) subject_BR2data(:,8) ones(length(subject_BR2data),1)*BRcount],'VariableNames',{'subjectID','probeRun','trial',' order',' Item_Left',' Item_Right',' Response','BeforeORafter_training'});
        %BRdata=array2table([subject_BR2data(:,1) subject_BR2data(:,2) ones(length(subject_BR2data),1)*order subject_BR2data(:,6) subject_BR2data(:,7) subject_BR2data(:,8) ones(length(subject_BR2data),1)*BRcount],'VariableNames',{'subjectID','trial',' order',' Item_Left',' Item_Right',' Response','BeforeORafter_training'});

        subT=[subT ; BRdata];
    end
    %% bids

filename = [Output_folder '/EVA4_' sub_name '_stopGoList_trainingstim.txt'];
delimiter = '\t';
formatSpec = '%s%f%f%f%f%[^\n\r]';
fileID = fopen([ filename],'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
itemsbids = table(dataArray{3:4}, 'VariableNames', {'itemNum','bid'});
clearvars filename delimiter formatSpec fileID dataArray ans t27;
for i=1:height(itemsbids)
t27(i,1)= find(roseta{:,order+4}==itemsbids{i,'itemNum'});
end
t27=array2table(t27,'VariableNames',{'item27'});
itemsbids=[itemsbids t27 ];
    itemsbids=sortrows(itemsbids,'item27');

    for i=1:height(subT)
       
        bid(i,1)=   itemsbids{subT{i,'Item_Left'},2};
        bid(i,2)=   itemsbids{subT{i,'Item_Right'},2};
    end    
    bid(:,3)=zscore(bid(:,1)-bid(:,2));

    BIDsT=array2table(bid,'VariableNames',{'bid_left','bid_right','delta_bid'});
    subT=[subT BIDsT];
%% vas data
     %_practice_VAS
    sub_num=[num2str(subjects(subjectIndex))];
    sub_name=['sub_' num2str(subjects(subjectIndex))];
    
    

    % vas recog
    filE=dir([Output_folder '/EVA4_' sub_num '_VAS_*.txt']);
    for i=1:length(filE)
    filename=filE(i).name;
    delimiter = '\t';
    startRow = 2;
    formatSpec = '%f%f%f%f%f%f%s%[^\n\r]';
    fileID = fopen([Output_folder '/' filename],'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
    fclose(fileID);
    sub_tableVrcg = table(dataArray{1:4}, 'VariableNames', {'Image_num','Effort_level','VAS_recognition','VAS_res_time'});
    clearvars filename delimiter startRow formatSpec fileID dataArray ans;
    sub_tableVrcg=sortrows(sub_tableVrcg);
    
    
    subsPE.(sub_name).(['vas_' num2str(i)])=(sub_tableVrcg{:,3});
    
    end
    

%% PE into finalT
PEs=[];

%  for vas=1:3
%         PEs(k,i*2-1)=subsPE.(sub_name).(['vas_' num2str(i)])(subT{k,'Item_Left'});
%         PEs(k,i*2)=subsPE.(sub_name).(['vas_' num2str(i)])(subT{k,'Item_Right'});
%  end
        
    for k=1:height(subT)
        PEs(k,1)=subsPE.(sub_name).vas_1(subT{k,'Item_Left'});
        PEs(k,2)=subsPE.(sub_name).vas_1(subT{k,'Item_Right'});
        PEs(k,3)=subsPE.(sub_name).vas_2(subT{k,'Item_Left'});
        PEs(k,4)=subsPE.(sub_name).vas_2(subT{k,'Item_Right'});
        PEs(k,5)=subsPE.(sub_name).vas_3(subT{k,'Item_Left'});
        PEs(k,6)=subsPE.(sub_name).vas_3(subT{k,'Item_Right'});
    end

PEs((PEs(:,:)==11))= NaN;
    
    
PEallsubTable=array2table(PEs,'VariableNames',{'PE1_left','PE1_right','PE2_left','PE2_right','PE3_left','PE3_right'});
    subT=[subT PEallsubTable];








%%
D_LminR_PE1=nanmean([subT{:,'PE1_left'}-subT{:,'PE1_right'} subT{:,'PE2_left'}-subT{:,'PE2_right'}],2);
D_LminR_PE2=subT{:,'PE3_left'}-subT{:,'PE3_right'};



D=array2table([(D_LminR_PE1) (D_LminR_PE2) ],'VariableNames',{'D_LminR_PE1','D_LminR_PE2'});
subT=[subT D];
subT=[subT(:,'subjectID') subT(:,'BeforeORafter_training') subT(:,'Response') subT(:,'delta_bid') subT(:,'D_LminR_PE1') subT(:,'D_LminR_PE2') ];


    %%
    finalT=[finalT; subT];
    
    
    
end % single sub for loop

% extract value levels and comparison type% join tables
finalT{(finalT{:,'Response'}==999),'Response'}=NaN;




%%
writetable(finalT,[Output_folder '/EVA4_1509BR.csv'])
