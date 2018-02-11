%% recode_probe_from_BR2


%% get data to mat
logs=dir([pwd '/EVA3_' sub_name '_binary_ranking*.txt' ]) ;
fid=fopen([pwd '/' logs(2).name]);
Data=textscan(fid, '%s%f%f%s%s%f%f%s%f%f' , 'HeaderLines', 1);     %read in probe output file into P ;

% Convert all string variables into numbers
Data{1}(:)={ALLsubjects(subjectIndex)}; %subject's code


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
%         Data{10}=cell2mat(Data{10});
%     Data{11}=cell2mat(Data{11});

Data{8}=cell2mat(Data{8});

fclose(fid);

subject_BR2data=cell2mat(Data);

%% recode from Practice_Images_num to bid rank

import_roseta

for BR2=1:length(subject_BR2data)
    
    subject_BR2data(BR2,6) =  roseta{subject_BR2data(BR2,6),order+4} ;
    subject_BR2data(BR2,7) =  roseta{subject_BR2data(BR2,7),order+4} ;
    
end



%% code pairType

%
if order==1
    %   comparisons of interest - High
    % - - - - - - - - - - - - - - -
    HV_90 = [4 9 11];
    HV_50 = [5 7 12];
    HV_10 = [6 8 10];
    
    %   comparisons of interest - Medium
    % - - - - - - - - - - - - - - -
    MV_90 = [28 30 32];
    MV_50 = [26 31 33];
    MV_10 = [27 29 34];
    
    %   comparisons of interest - Low
    % - - - - - - - - - - - - - - -
    LV_90 = [50 52 57];
    LV_50 = [51 53 55];
    LV_10 = [49 54 56];
    
    
elseif order==2
    
    %   comparisons of interest - High
    % - - - - - - - - - - - - - - -
    HV_90 = [5 7 12];
    HV_50 = [6 8 10];
    HV_10 = [4 9 11];
    
    %   comparisons of interest - Medium
    % - - - - - - - - - - - - - - -
    MV_90 = [26 31 33];
    MV_50 = [27 29 34];
    MV_10 = [28 30 32];
    
    %   comparisons of interest - Low
    % - - - - - - - - - - - - - - -
    LV_90 = [51 53 55];
    LV_50 = [49 54 56];
    LV_10 = [50 52 57];
    
elseif order==3
    
    %   comparisons of interest - High
    % - - - - - - - - - - - - - - -
    HV_90 = [6 8 10];
    HV_50 = [4 9 11];
    HV_10 = [5 7 12];
    
    %   comparisons of interest - Medium
    % - - - - - - - - - - - - - - -
    MV_90 = [27 29 34];
    MV_50 = [28 30 32];
    MV_10 = [26 31 33];
    
    %   comparisons of interest - Low
    % - - - - - - - - - - - - - - -
    LV_90 = [49 54 56];
    LV_50 = [50 52 57];
    LV_10 = [51 53 55];
    
end



for reoutcome=1:length(subject_BR2data)
    
    if  ismember(subject_BR2data(reoutcome,6),HV_90)%%%%%%%%%%%%%%%%%%%%%%90
        if ismember(subject_BR2data(reoutcome,7),HV_50)
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=1; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=1;
            end
            
            
        elseif  ismember(subject_BR2data(reoutcome,7),HV_10)
            
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=2; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=1;
            end
            
        end
    elseif ismember(subject_BR2data(reoutcome,6),HV_50)%%%%%%%%%%%%%% 50
        
        if ismember(subject_BR2data(reoutcome,7),HV_90)
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=1; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=0;
            elseif subject_BR2data(reoutcome,8)==0
                subject_data(length(subject_data(:,1)),15)=1;
            end
        elseif  ismember(subject_BR2data(reoutcome,7),HV_10)
            
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=3; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=1;
                
            end
        end
    elseif ismember(subject_BR2data(reoutcome,6),HV_10)%%%%%%%%%%%%%%%10
        
        if ismember(subject_BR2data(reoutcome,7),HV_90)
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=2; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=0;
            elseif subject_BR2data(reoutcome,8)==0
                subject_data(length(subject_data(:,1)),15)=1;
            end
           
        elseif  ismember(subject_BR2data(reoutcome,7),HV_50)
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=3; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=0;
            elseif subject_BR2data(reoutcome,8)==0
                subject_data(length(subject_data(:,1)),15)=1;
            end
        end
        
    elseif  ismember(subject_BR2data(reoutcome,6),MV_90)%%%%%%%%%%%%%
        if ismember(subject_BR2data(reoutcome,7),MV_50)
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=4; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=1;
                
            end
        elseif  ismember(subject_BR2data(reoutcome,7),MV_10)
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=5; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=1;
            end
            
            
        end
    elseif ismember(subject_BR2data(reoutcome,6),MV_50)%%%%%%%%%%%%%%%%%%%%
        
        if ismember(subject_BR2data(reoutcome,7),MV_90)
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=4; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=0;
            elseif subject_BR2data(reoutcome,8)==0
                subject_data(length(subject_data(:,1)),15)=1;
            end
        elseif  ismember(subject_BR2data(reoutcome,7),MV_10)
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=6; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=1;
            end
            
        end
    elseif ismember(subject_BR2data(reoutcome,6),MV_10)%%%%%%%%%%%%%%%%%%
        
        if ismember(subject_BR2data(reoutcome,7),MV_90)
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=5; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=0;
            elseif subject_BR2data(reoutcome,8)==0
                subject_data(length(subject_data(:,1)),15)=1;
            end
        elseif  ismember(subject_BR2data(reoutcome,7),MV_50)
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=6; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=0;
            elseif subject_BR2data(reoutcome,8)==0
                subject_data(length(subject_data(:,1)),15)=1;
            end
        end
        
    elseif  ismember(subject_BR2data(reoutcome,6),LV_90)%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if ismember(subject_BR2data(reoutcome,7),LV_50)
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=7; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=1;
            end
        elseif  ismember(subject_BR2data(reoutcome,7),LV_10)
            
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=8; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=1;
            end
            
        end
    elseif ismember(subject_BR2data(reoutcome,6),LV_50)%%%%%%%%%%%%%%%%%%%%%%%
        
        if ismember(subject_BR2data(reoutcome,7),LV_90)
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=7; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=0;
            elseif subject_BR2data(reoutcome,8)==0
                subject_data(length(subject_data(:,1)),15)=1;
            end
        elseif  ismember(subject_BR2data(reoutcome,7),LV_10)
            
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=9; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=1;
            end
        end
    elseif ismember(subject_BR2data(reoutcome,6),LV_10)%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        if ismember(subject_BR2data(reoutcome,7),LV_90)
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=8; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=0;
            elseif subject_BR2data(reoutcome,8)==0
                subject_data(length(subject_data(:,1)),15)=1;
            end
        elseif  ismember(subject_BR2data(reoutcome,7),LV_50)
            subject_data(length(subject_data(:,1))+1,10)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),11)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),13)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),14)=9; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),15)=0;
            elseif subject_BR2data(reoutcome,8)==0
                subject_data(length(subject_data(:,1)),15)=1;
            end
        end
    end
end
















