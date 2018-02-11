% EVA4_analize_delta percieved effort and binary ranking

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% single subject level
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% run from  output folder
% require results folder with subfolders: singleSUB,allSUBS
addpath('/Users/canadav/Google Drive/Tom_LAB/Experiments/Snacks_Effort_preferences/EVA4/analysis_scripts')
splitpath = strsplit(pwd,'/');
splitpath_minData=[splitpath(1:end-1)];
sub_fold=strjoin(splitpath_minData,'/');
allSUBS_result_folder=[sub_fold '/results/allSUBS'];
singleSUB_result_folder=[sub_fold '/results/singleSUB'];

% subjects to analys
ALLsubjects=[401:427]; % subject to include 401:426
subjects2EXclud= [423,426,421];% 423-only till training 426-only till BR2 423,426  % 421 wrong number of choice data?
subjects=ALLsubjects(~ismember(ALLsubjects,subjects2EXclud));
forloop=length(subjects);
finalT=[];
%% loop over all subs
for subjectIndex = 1:forloop
    
    %% % choice of item BR1
    BRs={'BR1','BR2'};
    subT=[];
    sub_name=num2str(subjects(subjectIndex))
    %% get order
    %correct 310
    if subjects(subjectIndex)==310;
        order=1    ;
    else
        load(['EVA4_' sub_name '_exp_parameters.mat'],'order')
    end
    %% BR 1 2 ranking results
    
    % BR_D
    ranks=(1:27)';
    % get _stopGoList_trainingstim
    filE=dir([pwd '/EVA4_' sub_name '_stopGoList_trainingstim*.txt']);
    filename=filE.name;
    delimiter = '\t';
    startRow = 1;
    formatSpec = '%s%f%f%f%f';
    fileID = fopen(filename,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter );
    fclose(fileID);
    sub_tableBR.trainingstim = table(dataArray{1:4}, 'VariableNames', {'Image','type','bidnum','bid'});
    sub_tableBR.trainingstim=sortrows(sub_tableBR.trainingstim);
    
    clearvars filename delimiter startRow formatSpec fileID dataArray ans;
    
    %% get _ItemRankingResults1
    
    filE=dir([pwd '/EVA4_' sub_name '_ItemRankingResults*.txt']);
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
    
    %% get _ItemRankingResults2
    
    filename=filE(2).name;
    delimiter = '\t';
    startRow = 2;
    formatSpec = '%s%s%f%f%f%f%f%[^\n\r]';
    fileID = fopen(filename,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
    fclose(fileID);
    
    sub_tableBR.BR2 = table(dataArray{2:4}, 'VariableNames', {'Image','rank','coli_Weight'});
    sub_tableBR.BR2=sortrows(sub_tableBR.BR2,3);
    sub_tableBR.BR2{:,2}=ranks;
    sub_tableBR.BR2=sortrows(sub_tableBR.BR2);
    
    clearvars filename delimiter startRow formatSpec fileID dataArray ans;
    
    
    %% integrate
    
    subT=table(sub_tableBR.trainingstim{:,1},sub_tableBR.trainingstim{:,4},sub_tableBR.trainingstim{:,3},sub_tableBR.BR1{:,2},sub_tableBR.BR1{:,3},sub_tableBR.BR2{:,2},sub_tableBR.BR2{:,3}   , 'VariableNames', {'Image','bid','bidnum','BR1_rank','BR1_coli','BR2_rank','BR2_coli'});
    
    
    
    
    
    %% PEs
    
    %_practice_VAS
    sub_num=[num2str(subjects(subjectIndex))];
    sub_Name=['sub_' num2str(subjects(subjectIndex))];
    
    
    filE=dir([pwd '/EVA4_' sub_num '_VAS_*.txt']);
    for i=1:length(filE)
        filename=filE(i).name;
        delimiter = '\t';
        startRow = 2;
        formatSpec = '%f%f%f%f%f%f%s%[^\n\r]';
        fileID = fopen(filename,'r');
        dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
        fclose(fileID);
        sub_tableVrcg = table(dataArray{1:4}, 'VariableNames', {'Image_num','Effort_level','VAS_recognition','VAS_res_time'});
        clearvars filename delimiter startRow formatSpec fileID dataArray ans;
        
        sub_tableVrcg=sortrows(sub_tableVrcg);
        sub_tableVrcg{(sub_tableVrcg{:,3}==11),3} =NaN;%correct for "no response"
        subsPE.(['vas_' num2str(i)])=(sub_tableVrcg{:,3});
        
    end
    
    % bidIndex to 1:27
    import_roseta
    bidindex=[];
    for reoutcome=1:height(subT)
        bidindex(reoutcome)= find(roseta{:,order+4}==subT{reoutcome,'bidnum'}) ;
    end
    
    subT=[subT array2table(bidindex','VariableNames',{'bidindex'}) ];
    subT=sortrows(subT,'bidindex');
    subT=[subT array2table([nanmean([subsPE.vas_1 subsPE.vas_2],2) (subsPE.vas_3) roseta{:,'Effort'}],'VariableNames',{'PE1','PE2','RE'})];
        
    
    subT=[ subT  array2table(ones(27,1)*subjects(subjectIndex),'VariableNames',{'sub'})];
    
    
    for BRnum=1:2
    filename = dir(['/Users/canadav/Google Drive/Tom_LAB/Experiments/Snacks_Effort_preferences/EVA4/Output/EVA4_' sub_num '_binary_ranking_' num2str(BRnum) '_*' '.txt']);
    filename=filename.name;
    delimiter = '\t';
    startRow = 2;
    formatSpec = '%s%s%s%s%s%s%s%s%s%s%[^\n\r]';
    fileID = fopen(filename,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
    fclose(fileID);
    raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
    for col=1:length(dataArray)-1
        raw(1:length(dataArray{col}),col) = dataArray{col};
    end
    numericData = NaN(size(dataArray{1},1),size(dataArray,2));
    for col=[1,2,3,6,7,9,10]
        % Converts strings in the input cell array to numbers. Replaced non-numeric
        % strings with NaN.
        rawData = dataArray{col};
        for row=1:size(rawData, 1);
            % Create a regular expression to detect and remove non-numeric prefixes and
            % suffixes.
            regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
            try
                result = regexp(rawData{row}, regexstr, 'names');
                numbers = result.numbers;
                
                % Detected commas in non-thousand locations.
                invalidThousandsSeparator = false;
                if any(numbers==',');
                    thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                    if isempty(regexp(thousandsRegExp, ',', 'once'));
                        numbers = NaN;
                        invalidThousandsSeparator = true;
                    end
                end
                % Convert numeric strings to numbers.
                if ~invalidThousandsSeparator;
                    numbers = textscan(strrep(numbers, ',', ''), '%f');
                    numericData(row, col) = numbers{1};
                    raw{row, col} = numbers{1};
                end
            catch me
            end
        end
    end
    rawNumericColumns = raw(:, [1,2,3,6,7,9,10]);
    rawCellColumns = raw(:, [4,5,8]);
    
    BRdata = table;
    BRdata.subjectID = cell2mat(rawNumericColumns(:, 1));
    BRdata.runtrial = cell2mat(rawNumericColumns(:, 2));
    BRdata.onsettime = cell2mat(rawNumericColumns(:, 3));
    BRdata.ImageLeft = rawCellColumns(:, 1);
    BRdata.ImageRight = rawCellColumns(:, 2);
    BRdata.StimNumLeft = cell2mat(rawNumericColumns(:, 4));
    BRdata.StimNumRight = cell2mat(rawNumericColumns(:, 5));
    BRdata.Response = rawCellColumns(:, 3);
    BRdata.Outcome = cell2mat(rawNumericColumns(:, 6));
    BRdata.RT = cell2mat(rawNumericColumns(:, 7));
    clearvars filename delimiter startRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns;
    
    % count how many times an item was chosen
    choices= zeros(27,1);
    for current_Choice=1:height(BRdata)
        if BRdata{current_Choice,'Response'}{1,1}=='u'
            choices(BRdata{current_Choice,'StimNumLeft'})= choices(BRdata{current_Choice,'StimNumLeft'})+1;
        elseif     BRdata{current_Choice,'Response'}{1,1}=='i'
            choices(BRdata{current_Choice,'StimNumRight'})= choices(BRdata{current_Choice,'StimNumRight'})+1;
            
        end
    end
    BR.(BRs{BRnum}) =choices;
    end %BRnum=1:2
    
    % add to subT
    subT=sortrows(subT,'bidindex');
    subT=[subT array2table([BR.BR1 BR.BR2 ],'VariableNames',{'countChooseBR1','countChooseBR2'})]  ;
    
    %     % revers rank so 1 is highest
    %     subT{:,'BR1_rank'}= abs(subT{:,'BR1_rank'}-28);
    %     subT{:,'BR2_rank'}= abs(subT{:,'BR2_rank'}-28);
    
    %%
    finalT=[finalT; subT];
    
    
    
end
finalT=[finalT array2table(ones(height(finalT),1)*4,'VariableNames',{'sample'})];
finalT=[finalT(:,'sample') finalT(:,'sub') finalT(:,'bid') finalT(:,'RE') finalT(:,'PE1') finalT(:,'BR1_rank') finalT(:,'BR1_coli') finalT(:,'countChooseBR1') finalT(:,'PE2') finalT(:,'BR2_rank') finalT(:,'BR2_coli') finalT(:,'countChooseBR2')];
writetable(finalT,[pwd '/EVA4_' date '_PEandBR_itemLevel.csv'])
