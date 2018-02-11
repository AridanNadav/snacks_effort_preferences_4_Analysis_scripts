%% grip_practice_and_VAS


%% Import data from text file.
% Script for importing data from the following text file:
%
%    /Users/papanadipapanadi/Documents/PE_data/PE_???.txt
%
% !!!!!!!!!!!!!!!  first you have delete the "_practice_VAS_16-Dec-2015_17h51m " part from
%each file
%sub_name_str=num2str(sub_name);
% Initialize variables.
filE=dir([pwd '/EVA3_' sub_name '_practice_VAS*.txt']);
filename=filE.name;
delimiter = '\t';
startRow = 2;

% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column6: double (%f)
%   column7: text (%s)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%f%s%[^\n\r]';

% Open the text file.
fileID = fopen(filename,'r');

% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

% Create output variable
sub_tableGpV = table(dataArray{1:end-1}, 'VariableNames', {'Image_num','Effort_level','Effort_rate','VAS_res_time','Goal','time2Goal','V_vector'});

% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

sub_tableGpV=sortrows(sub_tableGpV);
    %all_subData.(['PE_' sub_name_str]).full_table=sub_table;
    %%Effort_rate
   sub.Effort_rate =table(...
         table2array	(	sub_tableGpV	(	1.00	:	30	,	3))...	
        ,table2array	(	sub_tableGpV	(	31.00	:	60.00	,	3))...	
        ,table2array	(	sub_tableGpV	(	61.00	:	90.00	,	3))...	
        ,table2array	(	sub_tableGpV	(	91.00	:	120.00	,	3))...	
        ,table2array	(	sub_tableGpV	(	121.00	:	150.00	,	3))...	
        ,table2array	(	sub_tableGpV	(	151.00	:	180.00	,	3))...	
        ,table2array	(	sub_tableGpV	(	181.00	:	210.00	,	3))...	
        ,table2array	(	sub_tableGpV	(	211.00	:	240.00	,	3))...	
        ,table2array	(	sub_tableGpV	(	241.00	:	270.00	,	3)),	...
        'VariableNames',{'mvc_10_h' 'mvc_10_m' 'mvc_10_l' 'mvc_50_h' 'mvc_50_m' 'mvc_50_l' 'mvc_90_h' 'mvc_90_m' 'mvc_90_l'  });
    
    
    %%VAS_res_time
    
    sub.VAS_res_time =table(...
         table2array	(	sub_tableGpV	(	1.00	:	30	,	4))...	
        ,table2array	(	sub_tableGpV	(	31.00	:	60.00	,	4))...	
        ,table2array	(	sub_tableGpV	(	61.00	:	90.00	,	4))...	
        ,table2array	(	sub_tableGpV	(	91.00	:	120.00	,	4))...	
        ,table2array	(	sub_tableGpV	(	121.00	:	150.00	,	4))...	
        ,table2array	(	sub_tableGpV	(	151.00	:	180.00	,	4))...	
        ,table2array	(	sub_tableGpV	(	181.00	:	210.00	,	4))...	
        ,table2array	(	sub_tableGpV	(	211.00	:	240.00	,	4))...	
        ,table2array	(	sub_tableGpV	(	241.00	:	270.00	,	4)),	...
        'VariableNames',{'mvc_10_h' 'mvc_10_m' 'mvc_10_l' 'mvc_50_h' 'mvc_50_m' 'mvc_50_l' 'mvc_90_h' 'mvc_90_m' 'mvc_90_l'  });
    
    
    
    %%Goal
    
    sub.Goal =table(...
        table2array	(	sub_tableGpV	(	1.00	:	30	,	5))...	
        ,table2array	(	sub_tableGpV	(	31.00	:	60.00	,	5))...	
        ,table2array	(	sub_tableGpV	(	61.00	:	90.00	,	5))...	
        ,table2array	(	sub_tableGpV	(	91.00	:	120.00	,	5))...	
        ,table2array	(	sub_tableGpV	(	121.00	:	150.00	,	5))...	
        ,table2array	(	sub_tableGpV	(	151.00	:	180.00	,	5))...	
        ,table2array	(	sub_tableGpV	(	181.00	:	210.00	,	5))...	
        ,table2array	(	sub_tableGpV	(	211.00	:	240.00	,	5))...	
        ,table2array	(	sub_tableGpV	(	241.00	:	270.00	,	5)),	...
        'VariableNames',{'mvc_10_h' 'mvc_10_m' 'mvc_10_l' 'mvc_50_h' 'mvc_50_m' 'mvc_50_l' 'mvc_90_h' 'mvc_90_m' 'mvc_90_l'  });
    
    
    %%time2Goal
     sub.time2Goal =table(...
       table2array	(	sub_tableGpV	(	1.00	:	30	,	6))...	
        ,table2array	(	sub_tableGpV	(	31.00	:	60.00	,	6))...	
        ,table2array	(	sub_tableGpV	(	61.00	:	90.00	,	6))...	
        ,table2array	(	sub_tableGpV	(	91.00	:	120.00	,	6))...	
        ,table2array	(	sub_tableGpV	(	121.00	:	150.00	,	6))...	
        ,table2array	(	sub_tableGpV	(	151.00	:	180.00	,	6))...	
        ,table2array	(	sub_tableGpV	(	181.00	:	210.00	,	6))...	
        ,table2array	(	sub_tableGpV	(	211.00	:	240.00	,	6))...	
        ,table2array	(	sub_tableGpV	(	241.00	:	270.00	,	6)),	...
        'VariableNames',{'mvc_10_h' 'mvc_10_m' 'mvc_10_l' 'mvc_50_h' 'mvc_50_m' 'mvc_50_l' 'mvc_90_h' 'mvc_90_m' 'mvc_90_l'  });
    
    
    
    
    %% time2Goal 0 to NaN
    [row,coll]=size( sub.time2Goal);
    for collm=1:coll
        for roww=1:row
            
         if sub.time2Goal{roww,collm}   ==0
            sub.time2Goal{roww,collm}=NaN ;
          
         end
        end
     end
    

%%    write csv tables



  writetable(sub.Effort_rate,[singleSUB_result_folder '/' sub_name '_Effort_rate.csv'])
  writetable(sub.VAS_res_time,[singleSUB_result_folder '/' sub_name '_VAS_res_time.csv'])
  writetable(sub.Goal,[singleSUB_result_folder '/' sub_name '_Goal.csv'])
  writetable(sub.time2Goal,[singleSUB_result_folder '/' sub_name '_time2Goal.csv'])
%}

% % % %% all_subs_mean
% % % mvc_25_h_Effort_rate=mean(sub.Effort_rate{:,1});
% % % mvc_25_l_Effort_rate =mean(sub.Effort_rate{:,2});
% % % mvc_50_h_Effort_rate=mean(sub.Effort_rate{:,3});
% % % mvc_50_l_Effort_rate=mean(sub.Effort_rate{:,4});
% % % mvc_75_h_Effort_rate=mean(sub.Effort_rate{:,5});
% % % mvc_75_l_Effort_rate=mean(sub.Effort_rate{:,6});
% % % 
% % % 
% % % mvc_25_h_VAS_res_time= mean(sub.VAS_res_time{:,1});
% % % mvc_25_l_VAS_res_time = mean(sub.VAS_res_time{:,2});
% % % mvc_50_h_VAS_res_time= mean(sub.VAS_res_time{:,3});
% % % mvc_50_l_VAS_res_time= mean(sub.VAS_res_time{:,4});
% % % mvc_75_h_VAS_res_time= mean(sub.VAS_res_time{:,5});
% % % mvc_75_l_VAS_res_time= mean(sub.VAS_res_time{:,6});
% % % 
% % % 
% % % 
% % % mvc_25_h_Goal = sum(sub.Goal{:,1});
% % % mvc_25_l_Goal = sum(sub.Goal{:,2});
% % % mvc_50_h_Goal= sum(sub.Goal{:,3});
% % % mvc_50_l_Goal= sum(sub.Goal{:,4});
% % % mvc_75_h_Goal= sum(sub.Goal{:,5});
% % % mvc_75_l_Goal= sum(sub.Goal{:,6});
% % % 
% % % 
% % % 
% % % mvc_25_h_time2Goal = nanmean(sub.time2Goal{:,1});
% % % mvc_25_l_time2Goal  = nanmean(sub.time2Goal{:,2});
% % % mvc_50_h_time2Goal = nanmean(sub.time2Goal{:,3});
% % % mvc_50_l_time2Goal = nanmean(sub.time2Goal{:,4});
% % % mvc_75_h_time2Goal = nanmean(sub.time2Goal{:,5});
% % % mvc_75_l_time2Goal = nanmean(sub.time2Goal{:,6});
% % % 
% % % 
% % % %% all_subs_se
% % % mvc_se_25_h_Effort_rate=std(sub.Effort_rate{:,1})/sqrt(50);
% % % mvc_se_25_l_Effort_rate =std(sub.Effort_rate{:,2})/sqrt(50);
% % % mvc_se_50_h_Effort_rate=std(sub.Effort_rate{:,3})/sqrt(50);
% % % mvc_se_50_l_Effort_rate=std(sub.Effort_rate{:,4})/sqrt(50);
% % % mvc_se_75_h_Effort_rate=std(sub.Effort_rate{:,5})/sqrt(50);
% % % mvc_se_75_l_Effort_rate=std(sub.Effort_rate{:,6})/sqrt(50);
% % % 
% % % 
% % % mvc_se_25_h_VAS_res_time= std(sub.VAS_res_time{:,1})/sqrt(50);
% % % mvc_se_25_l_VAS_res_time = std(sub.VAS_res_time{:,2})/sqrt(50);
% % % mvc_se_50_h_VAS_res_time= std(sub.VAS_res_time{:,3})/sqrt(50);
% % % mvc_se_50_l_VAS_res_time= std(sub.VAS_res_time{:,4})/sqrt(50);
% % % mvc_se_75_h_VAS_res_time= std(sub.VAS_res_time{:,5})/sqrt(50);
% % % mvc_se_75_l_VAS_res_time= std(sub.VAS_res_time{:,6})/sqrt(50);
% % % 
% % % 
% % % 
% % % mvc_se_25_h_Goal = sum(sub.Goal{:,1})/sqrt(50);
% % % mvc_se_25_l_Goal = sum(sub.Goal{:,2})/sqrt(50);
% % % mvc_se_50_h_Goal= sum(sub.Goal{:,3})/sqrt(50);
% % % mvc_se_50_l_Goal= sum(sub.Goal{:,4})/sqrt(50);
% % % mvc_se_75_h_Goal= sum(sub.Goal{:,5})/sqrt(50);
% % % mvc_se_75_l_Goal= sum(sub.Goal{:,6})/sqrt(50);
% % % 
% % % 
% % % 
% % % mvc_se_25_h_time2Goal = nanstd(sub.time2Goal{:,1})/sqrt(50);
% % % mvc_se_25_l_time2Goal  = nanstd(sub.time2Goal{:,2})/sqrt(50);
% % % mvc_se_50_h_time2Goal = nanstd(sub.time2Goal{:,3})/sqrt(50);
% % % mvc_se_50_l_time2Goal = nanstd(sub.time2Goal{:,4})/sqrt(50);
% % % mvc_se_75_h_time2Goal = nanstd(sub.time2Goal{:,5})/sqrt(50);
% % % mvc_se_75_l_time2Goal = nanstd(sub.time2Goal{:,6})/sqrt(50);
% % % 
% % % 
% % % %% vectors for plot 
% % % 
% % % h_Effort_rate =[mvc_25_h_Effort_rate mvc_50_h_Effort_rate mvc_75_h_Effort_rate]*10;
% % % l_Effort_rate =[mvc_25_l_Effort_rate mvc_50_l_Effort_rate mvc_75_l_Effort_rate]*10;
% % % h_vas_res_time =[mvc_25_h_VAS_res_time mvc_50_h_VAS_res_time mvc_75_h_VAS_res_time];
% % % l_vas_res_time =[mvc_25_l_VAS_res_time mvc_50_l_VAS_res_time mvc_75_l_VAS_res_time];
% % % h_Goal =[mvc_25_h_Goal mvc_50_h_Goal mvc_75_h_Goal]*2;
% % % l_Goal =[mvc_25_l_Goal mvc_50_l_Goal mvc_75_l_Goal]*2;
% % % h_time2Goal =[mvc_25_h_time2Goal mvc_50_h_time2Goal mvc_75_h_time2Goal];
% % % l_time2Goal =[mvc_25_l_time2Goal mvc_50_l_time2Goal mvc_75_l_time2Goal];
% % % 
% % % h_Effort_rate_se =[mvc_se_25_h_Effort_rate mvc_se_50_h_Effort_rate mvc_se_75_h_Effort_rate]*10;
% % % l_Effort_rate_se =[mvc_se_25_l_Effort_rate mvc_se_50_l_Effort_rate mvc_se_75_l_Effort_rate]*10;
% % % h_vas_res_time_se =[mvc_se_25_h_VAS_res_time mvc_se_50_h_VAS_res_time mvc_se_75_h_VAS_res_time];
% % % l_vas_res_time_se =[mvc_se_25_l_VAS_res_time mvc_se_50_l_VAS_res_time mvc_se_75_l_VAS_res_time];
% % % h_Goal_se =[mvc_se_25_h_Goal mvc_se_50_h_Goal mvc_se_75_h_Goal]*2;
% % % l_Goal_se =[mvc_se_25_l_Goal mvc_se_50_l_Goal mvc_se_75_l_Goal]*2;
% % % h_time2Goal_se =[mvc_se_25_h_time2Goal mvc_se_50_h_time2Goal mvc_se_75_h_time2Goal];
% % % l_time2Goal_se =[mvc_se_25_l_time2Goal mvc_se_50_l_time2Goal mvc_se_75_l_time2Goal];
