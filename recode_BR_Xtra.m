%% recode_BR_Xtra
% extract cross value probe from BR2
% comparisons of interest:
%--------------
%  M50 vs L90 1
%  M10 vs L90 2
%  H50 vs L90 3
%  H10 vs L90 4
%--------------
%  M10 vs L50 5
%  H10 vs L50 6
%---------------
%  H10 vs M90 7
%  H50 vs M90 8
%---------------
%  H10 vs M50 9



%% get data to mat
matlogs=dir([pwd '/EVA4_' sub_name '*.mat' ]) ;
load(matlogs(1).name,'order')
logs=dir([pwd '/EVA4_' sub_name '_binary_ranking*.txt' ]) ;
current_BR=2;
fid=fopen([pwd '/' logs(current_BR).name]);
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


%%%
subject_data=zeros(81,5);
roW=1;


for reoutcome=1:length(subject_BR2data)
    %%%% left case
    if ismember(subject_BR2data(reoutcome,6),LV_90)%%%%%%%%%%%%%%%%%%%%%%LV_90
        if ismember(subject_BR2data(reoutcome,7),MV_50)
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);% item left
            subject_data(roW,2)=subject_BR2data(reoutcome,7);%item right
            subject_data(roW,3)=subject_BR2data(reoutcome,8);% response 1=left
            roW=roW+1; subject_data(roW-1,4)=1; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(roW-1,5)=1;
            end
            
            
        elseif  ismember(subject_BR2data(reoutcome,7),MV_10)
            
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);
            subject_data(roW,2)=subject_BR2data(reoutcome,7);
            subject_data(roW,3)=subject_BR2data(reoutcome,8);
            roW=roW+1; subject_data(roW-1,4)=2; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(roW-1,5)=1;
            end
            
        elseif  ismember(subject_BR2data(reoutcome,7),HV_50)
            
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);
            subject_data(roW,2)=subject_BR2data(reoutcome,7);
            subject_data(roW,3)=subject_BR2data(reoutcome,8);
            roW=roW+1; subject_data(roW-1,4)=3; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(roW-1,5)=1;
            end
            
        elseif  ismember(subject_BR2data(reoutcome,7),HV_10)
            
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);
            subject_data(roW,2)=subject_BR2data(reoutcome,7);
            subject_data(roW,3)=subject_BR2data(reoutcome,8);
            roW=roW+1; subject_data(roW-1,4)=4; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(roW-1,5)=1;
            end
            
            
        end
        
        
    elseif ismember(subject_BR2data(reoutcome,6),LV_50)%%%%%%%%%%%%%%%%%%%% LV_50
        if ismember(subject_BR2data(reoutcome,7),MV_10)
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);% item left
            subject_data(roW,2)=subject_BR2data(reoutcome,7);%item right
            subject_data(roW,3)=subject_BR2data(reoutcome,8);% response 1=left
            roW=roW+1; subject_data(roW-1,4)=5; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(roW-1,5)=1;
            end
            
            
        elseif  ismember(subject_BR2data(reoutcome,7),HV_10)
            
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);
            subject_data(roW,2)=subject_BR2data(reoutcome,7);
            subject_data(roW,3)=subject_BR2data(reoutcome,8);
            roW=roW+1; subject_data(roW-1,4)=6; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(roW-1,5)=1;
            end
        end
    elseif ismember(subject_BR2data(reoutcome,6),MV_90)   %%%%%%%%%%%%%%%%% MV_90
        if ismember(subject_BR2data(reoutcome,7),HV_10)
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);% item left
            subject_data(roW,2)=subject_BR2data(reoutcome,7);%item right
            subject_data(roW,3)=subject_BR2data(reoutcome,8);% response 1=left
            roW=roW+1; subject_data(roW-1,4)=7; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(roW-1,5)=1;
            end
            
            
        elseif  ismember(subject_BR2data(reoutcome,7),HV_50)
            
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);
            subject_data(roW,2)=subject_BR2data(reoutcome,7);
            subject_data(roW,3)=subject_BR2data(reoutcome,8);
            roW=roW+1; subject_data(roW-1,4)=8; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(roW-1,5)=1;
            end
        end
        
    elseif ismember(subject_BR2data(reoutcome,6),MV_50)%%%%%%%%%%%%%%%%%%%% MV_50
        if ismember(subject_BR2data(reoutcome,7),HV_10)
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);% item left
            subject_data(roW,2)=subject_BR2data(reoutcome,7);%item right
            subject_data(roW,3)=subject_BR2data(reoutcome,8);% response 1=left
            roW=roW+1; subject_data(roW-1,4)=9; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(roW-1,5)=1;
            end
            
        elseif   ismember(subject_BR2data(reoutcome,7),LV_90)
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);% item left
            subject_data(roW,2)=subject_BR2data(reoutcome,7);%item right
            subject_data(roW,3)=subject_BR2data(reoutcome,8);% response 1=left
            roW=roW+1; subject_data(roW-1,4)=9; % pair type
            if subject_BR2data(reoutcome,8)==0% choose left
                subject_data(roW-1,5)=1;
            end
            
            
            
            %%%%%% Right  case
        end
    elseif ismember(subject_BR2data(reoutcome,7),LV_90)%%%%%%%%%%%%%%%%%%%%%%LV_90
        if ismember(subject_BR2data(reoutcome,6),MV_50)
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);% item left
            subject_data(roW,2)=subject_BR2data(reoutcome,7);%item right
            subject_data(roW,3)=subject_BR2data(reoutcome,8);% response 1=left
            roW=roW+1; subject_data(roW-1,4)=1; % pair type
            if subject_BR2data(reoutcome,8)==0% choose right
                subject_data(roW-1,5)=1;
            end
            
            
        elseif  ismember(subject_BR2data(reoutcome,6),MV_10)
            
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);
            subject_data(roW,2)=subject_BR2data(reoutcome,7);
            subject_data(roW,3)=subject_BR2data(reoutcome,8);
            roW=roW+1; subject_data(roW-1,4)=2; % pair type
            if subject_BR2data(reoutcome,8)==0% choose right
                subject_data(roW-1,5)=1;
            end
            
        elseif  ismember(subject_BR2data(reoutcome,6),HV_50)
            
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);
            subject_data(roW,2)=subject_BR2data(reoutcome,7);
            subject_data(roW,3)=subject_BR2data(reoutcome,8);
            roW=roW+1; subject_data(roW-1,4)=3; % pair type
            if subject_BR2data(reoutcome,8)==0% choose right
                subject_data(roW-1,5)=1;
            end
            
        elseif  ismember(subject_BR2data(reoutcome,6),HV_10)
            
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);
            subject_data(roW,2)=subject_BR2data(reoutcome,7);
            subject_data(roW,3)=subject_BR2data(reoutcome,8);
            roW=roW+1; subject_data(roW-1,4)=4; % pair type
            if subject_BR2data(reoutcome,8)==0% choose right
                subject_data(roW-1,5)=1;
            end
            
            
        end
        
        
    elseif ismember(subject_BR2data(reoutcome,7),LV_50)%%%%%%%%%%%%%%%%%%%% LV_50
        if ismember(subject_BR2data(reoutcome,6),MV_10)
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);% item left
            subject_data(roW,2)=subject_BR2data(reoutcome,7);%item right
            subject_data(roW,3)=subject_BR2data(reoutcome,8);% response 1=left
            roW=roW+1; subject_data(roW-1,4)=5; % pair type
            if subject_BR2data(reoutcome,8)==0% choose right
                subject_data(roW-1,5)=1;
            end
            
            
        elseif  ismember(subject_BR2data(reoutcome,6),HV_10)
            
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);
            subject_data(roW,2)=subject_BR2data(reoutcome,7);
            subject_data(roW,3)=subject_BR2data(reoutcome,8);
            roW=roW+1; subject_data(roW-1,4)=6; % pair type
            if subject_BR2data(reoutcome,8)==0% choose right
                subject_data(roW-1,5)=1;
            end
        end
    elseif ismember(subject_BR2data(reoutcome,7),MV_90)   %%%%%%%%%%%%%%%%% MV_90
        if ismember(subject_BR2data(reoutcome,6),HV_10)
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);% item left
            subject_data(roW,2)=subject_BR2data(reoutcome,7);%item right
            subject_data(roW,3)=subject_BR2data(reoutcome,8);% response 1=left
            roW=roW+1; subject_data(roW-1,4)=7; % pair type
            if subject_BR2data(reoutcome,8)==0% choose right
                subject_data(roW-1,5)=1;
            end
            
            
        elseif  ismember(subject_BR2data(reoutcome,6),HV_50)
            
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);
            subject_data(roW,2)=subject_BR2data(reoutcome,7);
            subject_data(roW,3)=subject_BR2data(reoutcome,8);
            roW=roW+1; subject_data(roW-1,4)=8; % pair type
            if subject_BR2data(reoutcome,8)==0% choose right
                subject_data(roW-1,5)=1;
            end
        end
        
    elseif ismember(subject_BR2data(reoutcome,7),MV_50)%%%%%%%%%%%%%%%%%%%% MV_50
        if ismember(subject_BR2data(reoutcome,6),HV_10)
            subject_data(roW ,1)=subject_BR2data(reoutcome,6);% item left
            subject_data(roW,2)=subject_BR2data(reoutcome,7);%item right
            subject_data(roW,3)=subject_BR2data(reoutcome,8);% response 1=left
            roW=roW+1; subject_data(roW-1,4)=9; % pair type
            if subject_BR2data(reoutcome,8)==0% choose right
                subject_data(roW-1,5)=1;
            end
            
        end
        
    end
    
end




PairType=subject_data(:,4);
Outcome=subject_data(:,5);
Rank_left=subject_data(:,1);
Rank_right=subject_data(:,2);






% Organize data in a summary table
probe_results(1,1)=subjects(subjectIndex);

probe_results(1,2)=order;


probe_results(1,3)=sum(PairType==1&Outcome==1)/sum(PairType==1&Outcome~=999);  %    %Low_90_vs_m_50     %1
probe_results(1,4)=sum(PairType==2&Outcome==1)/sum(PairType==2&Outcome~=999);  %     %Low_90_vs_m_10     %2
probe_results(1,5)=sum(PairType==3&Outcome==1)/sum(PairType==3&Outcome~=999);  %     %Low_90_vs_High_50     %3
probe_results(1,6)=sum(PairType==4&Outcome==1)/sum(PairType==4&Outcome~=999); %     %Low_90_vs_h10 %4
probe_results(1,7)=sum(PairType==5&Outcome==1)/sum(PairType==5&Outcome~=999); %     %Low_50_vs_Medium_10 %5
probe_results(1,8)=sum(PairType==6&Outcome==1)/sum(PairType==6&Outcome~=999); %     %Low_50_vs_h_10 %6
probe_results(1,9)=sum(PairType==7&Outcome==1)/sum(PairType==7&Outcome~=999); %     %MEd_90_vs_h10       %7
probe_results(1,10)=sum(PairType==8&Outcome==1)/sum(PairType==8&Outcome~=999); %     %MEd_90_vs_h50      %8
probe_results(1,11)=sum(PairType==9&Outcome==1)/sum(PairType==9&Outcome~=999); %     %MEd_50_vs_h_10       %9


%! end

ProbeX_results_table = cell(1+size(probe_results,1),size(probe_results,2));
Titles = {'Subject', 'Order', '  M50 vs L90  ' ,' M10 vs L90  ' ,' H50 vs L90  ' ,' H10 vs L90  ',  ' M10 vs L50  ', ' H10 vs L50 ',  ' H10 vs M90  ' ,' H50 vs M90  '  ,' H10 vs M50 '};
ProbeX_results_table(1,:) = Titles;
ProbeX_results_table(2:end,:) = num2cell(probe_results);

save([singleSUB_result_folder '/' sub_name '_ProbeX_results_table.mat'],'ProbeX_results_table')





figfig=figure;
bar(probe_results(3:end))
hold on
plot([0 10],[0.5 0.5],'--r')


title(['X value ProbeX for subject:  ' sub_name] )
xlabel('comparison (%MVCs)') % x-axis label
ylabel('Percent Choice') % y-axis label
set(gca,'XTickLabel',{'  M50 vs L90  ' ,' M10 vs L90  ' ,' H50 vs L90  ' ,' H10 vs L90  ',  ' M10 vs L50  ', ' H10 vs L50 ',  ' H10 vs M90  ' ,' H50 vs M90  '  ,' H10 vs M50 ','' })

 savefig([singleSUB_result_folder '/' sub_name '_probeX' ])
 saveas(figfig,[singleSUB_result_folder '/' sub_name '_probeX.jpg'])
% 
% 



