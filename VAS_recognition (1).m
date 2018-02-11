
% VAS_recognition



%% Import data from text file.
% Script for importing data from the following text file:
%
%    /Users/papanadipapanadi/Documents/PE_data/PE_???.txt
%
% !!!!!!!!!!!!!!!  first you have delete the "_practice_VAS_16-Dec-2015_17h51m " part from
%each file
%sub_name_str=num2str(sub_name);
% Initialize variables.
filE=dir([pwd '/EVA3_' sub_name 'VAS_recognition*.txt']);
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
sub_tableVrcg = table(dataArray{1:4}, 'VariableNames', {'Image_num','Effort_level','VAS_recognition','VAS_res_time'});

% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

sub_tableVrcg=sortrows(sub_tableVrcg);
%all_subData.(['PE_' sub_name_str]).full_table=sub_table;
%%VAS_recognition
VAS_Recognition =table(...
    table2array	(	sub_tableVrcg	(	1.00	:	3.00	,	3))...
    ,table2array	(	sub_tableVrcg	(	4.00	:	6.00	,	3))...
    ,table2array	(	sub_tableVrcg	(	7.00	:	9.00	,	3))...
    ,table2array	(	sub_tableVrcg	(	10.00	:	12.00	,	3))...
    ,table2array	(	sub_tableVrcg	(	13.00	:	15.00	,	3))...
    ,table2array	(	sub_tableVrcg	(	16.00	:	18.00	,	3))...
    ,table2array	(	sub_tableVrcg	(	19.00	:	21.00	,	3))...
    ,table2array	(	sub_tableVrcg	(	22.00	:	24.00	,	3))...
    ,table2array	(	sub_tableVrcg	(	25.00	:	27.00	,	3)),	...
    'VariableNames',{'mvc_10_h' 'mvc_10_m' 'mvc_10_l' 'mvc_50_h' 'mvc_50_m' 'mvc_50_l' 'mvc_90_h' 'mvc_90_m' 'mvc_90_l'  });


writetable(VAS_Recognition,[singleSUB_result_folder '/' sub_name '_Effort_recog.csv'])

Hi=[nanmean(VAS_Recognition{:,1}) nanmean(VAS_Recognition{:,4}) nanmean(VAS_Recognition{:,7})];
Mi=[nanmean(VAS_Recognition{:,2}) nanmean(VAS_Recognition{:,5}) nanmean(VAS_Recognition{:,8})];
Li=[nanmean(VAS_Recognition{:,3}) nanmean(VAS_Recognition{:,6}) nanmean(VAS_Recognition{:,9})];

HiSE=[nanstd(VAS_Recognition{:,1})/sqrt(3) nanstd(VAS_Recognition{:,4})/sqrt(3) nanstd(VAS_Recognition{:,7})/sqrt(3)];
MiSE=[nanstd(VAS_Recognition{:,2})/sqrt(3) nanstd(VAS_Recognition{:,5})/sqrt(3) nanstd(VAS_Recognition{:,8})/sqrt(3)];
LiSE=[nanstd(VAS_Recognition{:,3})/sqrt(3) nanstd(VAS_Recognition{:,6})/sqrt(3) nanstd(VAS_Recognition{:,9})/sqrt(3)];
 
effort_levels=[1,5,9];

 
% Plot
figfig=figure;
errorbar(effort_levels,Hi,HiSE,'b')
hold on
errorbar(effort_levels,Mi,MiSE,'g')
hold on
errorbar(effort_levels,Li,LiSE,'r')

title([ sub_name ' VAS Recognition'])
xlabel('Effort level (%MVC)') % x-axis label
ylabel('VAS Recognition (VAS)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
axis([0,10,0,10])
plot([0 10],[0 10],'--')
ax = gca;  %% get handle to current axes
ax.XTick = [1 5 9];
ax.XTickLabel = {'10','50','90'};
ax.YTick =  [1 5 9];
ax.YTickLabel = {'10','50','90'};
savefig([singleSUB_result_folder '/' sub_name ' VAS Recognition'])
saveas(figfig,[singleSUB_result_folder '/' sub_name ' VAS Recognition.jpg'])


