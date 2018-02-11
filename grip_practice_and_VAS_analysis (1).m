%% grip_practice_and_VAS


%% Import data from text file.
% Script for importing data from the following text file:
%
%
%sub_name_str=num2str(sub_name);
% Initialize variables.
filE=dir([pwd '/EVA4_' sub_name '_training_run*.txt']);
for i=1:length(filE)
filename=filE(i).name;
delimiter = '\t';
startRow = 2;

% formatSpec = '%f%f%f%f%f%f%s%[^\n\r]';

% Open the text file.

% fileID = fopen(filename,'r');
% dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);

dataArray = readtable(filename,'Delimiter',delimiter);

if i==1
sub_tableGpVs= dataArray;
else
sub_tableGpVs   =[sub_tableGpVs;dataArray] ;
end
% Close the text file.
% fclose(fileID);
end
%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

% Create output variable
% sub_tableGpVs = table(dataArray{1:end}, 'VariableNames', {'Image_num','Effort_level','Goal','time2Goal','V_vector',});


% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID  ans;

sub_tableGpVs=sortrows(sub_tableGpVs);
%all_subData.(['PE_' sub_name_str]).full_table=sub_table;
% %% Effort_rate
% Effort_rate =table(...
%     table2array	(	sub_tableGpVs	(	1.00	:	30	,	3))...
%     ,table2array	(	sub_tableGpVs	(	31.00	:	60.00	,	3))...
%     ,table2array	(	sub_tableGpVs	(	61.00	:	90.00	,	3))...
%     ,table2array	(	sub_tableGpVs	(	91.00	:	120.00	,	3))...
%     ,table2array	(	sub_tableGpVs	(	121.00	:	150.00	,	3))...
%     ,table2array	(	sub_tableGpVs	(	151.00	:	180.00	,	3))...
%     ,table2array	(	sub_tableGpVs	(	181.00	:	210.00	,	3))...
%     ,table2array	(	sub_tableGpVs	(	211.00	:	240.00	,	3))...
%     ,table2array	(	sub_tableGpVs	(	241.00	:	270.00	,	3)),	...
%     'VariableNames',{'mvc_10_h' 'mvc_10_m' 'mvc_10_l' 'mvc_50_h' 'mvc_50_m' 'mvc_50_l' 'mvc_90_h' 'mvc_90_m' 'mvc_90_l'  });
% 
% 
% writetable(Effort_rate,[singleSUB_result_folder '/' sub_name '_Effort_rate.csv'])
% 
% % plot
% Hi=[nanmean(Effort_rate{:,1}) nanmean(Effort_rate{:,4}) nanmean(Effort_rate{:,7})];
% Mi=[nanmean(Effort_rate{:,2}) nanmean(Effort_rate{:,5}) nanmean(Effort_rate{:,8})];
% Li=[nanmean(Effort_rate{:,3}) nanmean(Effort_rate{:,6}) nanmean(Effort_rate{:,9})];
% 
% HiSE=[nanstd(Effort_rate{:,1})/sqrt(3) nanstd(Effort_rate{:,4})/sqrt(3) nanstd(Effort_rate{:,7})/sqrt(3)];
% MiSE=[nanstd(Effort_rate{:,2})/sqrt(3) nanstd(Effort_rate{:,5})/sqrt(3) nanstd(Effort_rate{:,8})/sqrt(3)];
% LiSE=[nanstd(Effort_rate{:,3})/sqrt(3) nanstd(Effort_rate{:,6})/sqrt(3) nanstd(Effort_rate{:,9})/sqrt(3)];
% 
% 
% effort_levelsPE=[1,5,9];
% 
% 
% figfig=figure;
% errorbar(effort_levelsPE,Hi,HiSE,'b')
% hold on
% errorbar(effort_levelsPE,Mi,MiSE,'g')
% hold on
% errorbar(effort_levelsPE,Li,LiSE,'r')
% 
% title([ sub_name ' Percived effort'])
% xlabel('Effort level (%MVC)') % x-axis label
% ylabel('Percived effort (VAS)') % y-axis label
% legend('High value items',' medium value items',' Low value items','Location','northwest')
% axis([0,10,0,10])
% plot([0 10],[0 10],'--')
% ax = gca;  %% get handle to current axes
% ax.XTick = [1 5 9];
% ax.XTickLabel = {'10','50','90'};
% ax.YTick =  [1 5 9];
% ax.YTickLabel = {'10','50','90'};
% savefig([singleSUB_result_folder '/' sub_name ' Percived effort'])
% saveas(figfig,[singleSUB_result_folder '/' sub_name ' Percived effort.jpg'])


% %% VAS_res_time
% 
% VAS_rt =table(...
%     table2array	(	sub_tableGpVs	(	1.00	:	30	,	4))...
%     ,table2array	(	sub_tableGpVs	(	31.00	:	60.00	,	4))...
%     ,table2array	(	sub_tableGpVs	(	61.00	:	90.00	,	4))...
%     ,table2array	(	sub_tableGpVs	(	91.00	:	120.00	,	4))...
%     ,table2array	(	sub_tableGpVs	(	121.00	:	150.00	,	4))...
%     ,table2array	(	sub_tableGpVs	(	151.00	:	180.00	,	4))...
%     ,table2array	(	sub_tableGpVs	(	181.00	:	210.00	,	4))...
%     ,table2array	(	sub_tableGpVs	(	211.00	:	240.00	,	4))...
%     ,table2array	(	sub_tableGpVs	(	241.00	:	270.00	,	4)),	...
%     'VariableNames',{'mvc_10_h' 'mvc_10_m' 'mvc_10_l' 'mvc_50_h' 'mvc_50_m' 'mvc_50_l' 'mvc_90_h' 'mvc_90_m' 'mvc_90_l'  });
% 
% 
% writetable(VAS_rt,[singleSUB_result_folder '/' sub_name '_VAS_rt.csv'])
% 
% % plot
% Hi=[nanmean(VAS_rt{:,1}) nanmean(VAS_rt{:,4}) nanmean(VAS_rt{:,7})];
% Mi=[nanmean(VAS_rt{:,2}) nanmean(VAS_rt{:,5}) nanmean(VAS_rt{:,8})];
% Li=[nanmean(VAS_rt{:,3}) nanmean(VAS_rt{:,6}) nanmean(VAS_rt{:,9})];
% 
% HiSE=[nanstd(VAS_rt{:,1})/sqrt(3) nanstd(VAS_rt{:,4})/sqrt(3) nanstd(VAS_rt{:,7})/sqrt(3)];
% MiSE=[nanstd(VAS_rt{:,2})/sqrt(3) nanstd(VAS_rt{:,5})/sqrt(3) nanstd(VAS_rt{:,8})/sqrt(3)];
% LiSE=[nanstd(VAS_rt{:,3})/sqrt(3) nanstd(VAS_rt{:,6})/sqrt(3) nanstd(VAS_rt{:,9})/sqrt(3)];
% 
% effort_levels=[10,50,90];
% 
% figfig=figure;
% errorbar(effort_levels,Hi,HiSE,'b')
% hold on
% errorbar(effort_levels,Mi,MiSE,'g')
% hold on
% errorbar(effort_levels,Li,LiSE,'r')
% 
% title([ sub_name ' VAS rt'])
% xlabel('Effort level (%MVC)') % x-axis label
% ylabel('VAS rt (VAS)') % y-axis label
% legend('High value items',' medium value items',' Low value items','Location','northwest')
% ax = gca;  %% get handle to current axes
% ax.XTick = [10 50 90];
% savefig([singleSUB_result_folder '/' sub_name ' VAS rt'])
% saveas(figfig,[singleSUB_result_folder '/' sub_name ' VAS rt.jpg'])


%% Goal

% Goal =table(...
% table2array(sub_tableGpVs(1	:36	,3))...
% ,table2array(sub_tableGpVs(37	:72	,3))...
% ,table2array(sub_tableGpVs(73	:108	,3))...
% ,table2array(sub_tableGpVs(109	:144	,3))...
% ,table2array(sub_tableGpVs(145	:180	,3))...
% ,table2array(sub_tableGpVs(181	:216	,3))...
% ,table2array(sub_tableGpVs(217	:252	,3))...
% ,table2array(sub_tableGpVs(253	:288	,3))...
% ,table2array(sub_tableGpVs(289	:324	,3)), ...
%     'VariableNames',{'mvc_10_h' 'mvc_10_m' 'mvc_10_l' 'mvc_50_h' 'mvc_50_m' 'mvc_50_l' 'mvc_90_h' 'mvc_90_m' 'mvc_90_l'  });

Goal =table(...
sub_tableGpVs.Goal(1	:36	)...
,sub_tableGpVs.Goal(37	:72	)...
,sub_tableGpVs.Goal(73	:108	)...
,sub_tableGpVs.Goal(109	:144	)...
,sub_tableGpVs.Goal(145	:180	)...
,sub_tableGpVs.Goal(181	:216	)...
,sub_tableGpVs.Goal(217	:252	)...
,sub_tableGpVs.Goal(253	:288	)...
,sub_tableGpVs.Goal(289	:324	), ...
    'VariableNames',{'mvc_10_h' 'mvc_10_m' 'mvc_10_l' 'mvc_50_h' 'mvc_50_m' 'mvc_50_l' 'mvc_90_h' 'mvc_90_m' 'mvc_90_l'  });



writetable(Goal,[singleSUB_result_folder '/' sub_name '_Goal.csv'])

% plot
Hi=[sum(Goal{:,1})/.36 sum(Goal{:,4})/.36 sum(Goal{:,7})/.36];
Mi=[sum(Goal{:,2})/.36 sum(Goal{:,5})/.36 sum(Goal{:,8})/.36];
Li=[sum(Goal{:,3})/.36 sum(Goal{:,6})/.36 sum(Goal{:,9})/.36];



effort_levels=[10,50,90];

figfig=figure;
errorbar(effort_levels,Hi,[0 0 0],'b')
hold on
errorbar(effort_levels,Mi,[0 0 0],'g')
hold on
errorbar(effort_levels,Li,[0 0 0],'r')

title([ sub_name ' Percent goal reached'])
xlabel('Effort level (%MVC)') % x-axis label
ylabel('Percent goal reached') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];
axis([0,100,0,110])
ax.YTickLabel = {'0','10','20','30','40','50','60','70','80','90','100',' '};

savefig([singleSUB_result_folder '/' sub_name ' Percent goal reached'])
saveas(figfig,[singleSUB_result_folder '/' sub_name ' Percent goal reached.jpg'])



%% time2Goal
time2Goal =table(...
sub_tableGpVs.time2Goal(1	:36	)...
,sub_tableGpVs.time2Goal(37	:72	)...
,sub_tableGpVs.time2Goal(73	:108	)...
,sub_tableGpVs.time2Goal(109	:144	)...
,sub_tableGpVs.time2Goal(145	:180	)...
,sub_tableGpVs.time2Goal(181	:216	)...
,sub_tableGpVs.time2Goal(217	:252	)...
,sub_tableGpVs.time2Goal(253	:288	)...
,sub_tableGpVs.time2Goal(289	:324	), ...
    'VariableNames',{'mvc_10_h' 'mvc_10_m' 'mvc_10_l' 'mvc_50_h' 'mvc_50_m' 'mvc_50_l' 'mvc_90_h' 'mvc_90_m' 'mvc_90_l'  });

% time2Goal 0 to NaN
[row,coll]=size( time2Goal);
for collm=1:coll
    for roww=1:row
        
        if time2Goal{roww,collm}   ==0
            time2Goal{roww,collm}=NaN ;
            
        end
    end
end

writetable(time2Goal,[singleSUB_result_folder '/' sub_name '_time2Goal.csv'])

% plot
Hi=[nanmean(time2Goal{:,1}) nanmean(time2Goal{:,4}) nanmean(time2Goal{:,7})];
Mi=[nanmean(time2Goal{:,2}) nanmean(time2Goal{:,5}) nanmean(time2Goal{:,8})];
Li=[nanmean(time2Goal{:,3}) nanmean(time2Goal{:,6}) nanmean(time2Goal{:,9})];

HiSE=[nanstd(time2Goal{:,1})/sqrt(3) nanstd(time2Goal{:,4})/sqrt(3) nanstd(time2Goal{:,7})/sqrt(3)];
MiSE=[nanstd(time2Goal{:,2})/sqrt(3) nanstd(time2Goal{:,5})/sqrt(3) nanstd(time2Goal{:,8})/sqrt(3)];
LiSE=[nanstd(time2Goal{:,3})/sqrt(3) nanstd(time2Goal{:,6})/sqrt(3) nanstd(time2Goal{:,9})/sqrt(3)];

effort_levels=[10,50,90];

figfig=figure;
errorbar(effort_levels,Hi,HiSE,'b')
hold on
errorbar(effort_levels,Mi,MiSE,'g')
hold on
errorbar(effort_levels,Li,LiSE,'r')

title([ sub_name ' Time2Goal'])
xlabel('Effort level (%MVC)') % x-axis label
ylabel('Time2Goal (sec)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];
savefig([singleSUB_result_folder '/' sub_name ' Time2Goal'])
saveas(figfig,[singleSUB_result_folder '/' sub_name ' Time2Goal.jpg'])







%% _calib_parameters
load(['EVA4_' sub_name '_calib_parameters.mat'])
% dynomometer data
dynoVec =table(...
sub_tableGpVs.V_vector(1	:36	)...
,sub_tableGpVs.V_vector(37	:72	)...
,sub_tableGpVs.V_vector(73	:108	)...
,sub_tableGpVs.V_vector(109	:144	)...
,sub_tableGpVs.V_vector(145	:180	)...
,sub_tableGpVs.V_vector(181	:216	)...
,sub_tableGpVs.V_vector(217	:252	)...
,sub_tableGpVs.V_vector(253	:288	)...
,sub_tableGpVs.V_vector(289	:324	), ...
    'VariableNames',{'mvc_10_h' 'mvc_10_m' 'mvc_10_l' 'mvc_50_h' 'mvc_50_m' 'mvc_50_l' 'mvc_90_h' 'mvc_90_m' 'mvc_90_l'  });

writetable(dynoVec,[singleSUB_result_folder '/' sub_name '_dynoVec.csv'])

[row,coll]=size( dynoVec);
Hivec10	=zeros(row,40);
Mivec10	=zeros(row,40);
Livec10	=zeros(row,40);
Hivec50	=zeros(row,40);
Mivec50	=zeros(row,40);
Livec50	=zeros(row,40);
Hivec90	=zeros(row,40);
Mivec90	=zeros(row,40);
Livec90	=zeros(row,40);


% get data into matrix
for roww=1:row
    
    Hivec10	(roww,(1:length(str2num(cell2mat(dynoVec{roww,1})))))=str2num(cell2mat(dynoVec{roww,1}) )- MinCal;
    Mivec10(roww,(1:length(str2num(cell2mat(dynoVec{roww,2})))))=str2num(cell2mat(dynoVec{roww,2}) )- MinCal;
    Livec10(roww,(1:length(str2num(cell2mat(dynoVec{roww,3})))))=str2num(cell2mat(dynoVec{roww,3}) )- MinCal;
    Hivec50(roww,(1:length(str2num(cell2mat(dynoVec{roww,4})))))=str2num(cell2mat(dynoVec{roww,4}) )- MinCal;
    Mivec50(roww,(1:length(str2num(cell2mat(dynoVec{roww,5})))))=str2num(cell2mat(dynoVec{roww,5}) )- MinCal;
    Livec50(roww,(1:length(str2num(cell2mat(dynoVec{roww,6})))))=str2num(cell2mat(dynoVec{roww,6}) )- MinCal;
    Hivec90(roww,(1:length(str2num(cell2mat(dynoVec{roww,7})))))=str2num(cell2mat(dynoVec{roww,7}) )- MinCal;
    Mivec90(roww,(1:length(str2num(cell2mat(dynoVec{roww,8})))))=str2num(cell2mat(dynoVec{roww,8}) )- MinCal;
    Livec90(roww,(1:length(str2num(cell2mat(dynoVec{roww,9})))))=str2num(cell2mat(dynoVec{roww,9}) )- MinCal;
end

%% area under curve
for roww=1:row
    
    AUCHivec10	(roww)=trapz(str2num(cell2mat(dynoVec{roww,1}) )- MinCal);
    AUCMivec10(roww)=trapz(str2num(cell2mat(dynoVec{roww,2}) )- MinCal);
    AUCLivec10(roww)=trapz(str2num(cell2mat(dynoVec{roww,3}) )- MinCal);
    AUCHivec50(roww)=trapz(str2num(cell2mat(dynoVec{roww,4}) )- MinCal);
    AUCMivec50(roww)=trapz(str2num(cell2mat(dynoVec{roww,5}) )- MinCal);
    AUCLivec50(roww)=trapz(str2num(cell2mat(dynoVec{roww,6}) )- MinCal);
    AUCHivec90(roww)=trapz(str2num(cell2mat(dynoVec{roww,7}) )- MinCal);
    AUCMivec90(roww)=trapz(str2num(cell2mat(dynoVec{roww,8}) )- MinCal);
    AUCLivec90(roww)=trapz(str2num(cell2mat(dynoVec{roww,9}) )- MinCal);
end
% mean  % area under curve
mAUCHivec10	=	mean(	AUCHivec10	);
mAUCMivec10	=	mean(	AUCMivec10	);
mAUCLivec10	=	mean(	AUCLivec10	);
mAUCHivec50	=	mean(	AUCHivec50	);
mAUCMivec50	=	mean(	AUCMivec50	);
mAUCLivec50	=	mean(	AUCLivec50	);
mAUCHivec90	=	mean(	AUCHivec90	);
mAUCMivec90	=	mean(	AUCMivec90	);
mAUCLivec90	=	mean(	AUCLivec90	);
% plot % mean  % area under curve

Hi=[mAUCHivec10 mAUCHivec50 mAUCHivec90];
Mi=[mAUCMivec10 mAUCMivec50 mAUCMivec90];
Li=[mAUCLivec10 mAUCLivec50 mAUCLivec90];


effort_levels=[10,50,90];

figfig=figure;
errorbar(effort_levels,Hi,[0 0 0],'b')
hold on
errorbar(effort_levels,Mi,[0 0 0],'g')
hold on
errorbar(effort_levels,Li,[0 0 0],'r')


title([ sub_name ' Mean area under curve '])
xlabel('Effort level (%MVC)') % x-axis label
ylabel('Mean area under curve  (au)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];
savefig([singleSUB_result_folder '/' sub_name ' Mean area under curve '])
saveas(figfig,[singleSUB_result_folder '/' sub_name ' Mean area under curve .jpg'])

%%
% max point
for roww=1:row
    
    MXptHivec10	(roww)=max(str2num(cell2mat(dynoVec{roww,1}) )- MinCal);
    MXptMivec10(roww)=max(str2num(cell2mat(dynoVec{roww,2}) )- MinCal);
    MXptLivec10(roww)=max(str2num(cell2mat(dynoVec{roww,3}) )- MinCal);
    MXptHivec50(roww)=max(str2num(cell2mat(dynoVec{roww,4}) )- MinCal);
    MXptMivec50(roww)=max(str2num(cell2mat(dynoVec{roww,5}) )- MinCal);
    MXptLivec50(roww)=max(str2num(cell2mat(dynoVec{roww,6}) )- MinCal);
    MXptHivec90(roww)=max(str2num(cell2mat(dynoVec{roww,7}) )- MinCal);
    MXptMivec90(roww)=max(str2num(cell2mat(dynoVec{roww,8}) )- MinCal);
    MXptLivec90(roww)=max(str2num(cell2mat(dynoVec{roww,9}) )- MinCal);
end


mMXptHivec10	=	mean(	MXptHivec10	);
mMXptMivec10	=	mean(	MXptMivec10	);
mMXptLivec10	=	mean(	MXptLivec10	);
mMXptHivec50	=	mean(	MXptHivec50	);
mMXptMivec50	=	mean(	MXptMivec50	);
mMXptLivec50	=	mean(	MXptLivec50	);
mMXptHivec90	=	mean(	MXptHivec90	);
mMXptMivec90	=	mean(	MXptMivec90	);
mMXptLivec90	=	mean(	MXptLivec90	);
% plot % mean  % area under curve

Hi=[mMXptHivec10 mMXptHivec50 mMXptHivec90];
Mi=[mMXptMivec10 mMXptMivec50 mMXptMivec90];
Li=[mMXptLivec10 mMXptLivec50 mMXptLivec90];


effort_levels=[10,50,90];

figfig=figure;
errorbar(effort_levels,Hi,[0 0 0],'b')
hold on
errorbar(effort_levels,Mi,[0 0 0],'g')
hold on
errorbar(effort_levels,Li,[0 0 0],'r')

title([ sub_name ' Mean Maximum pt '])
xlabel('Effort level required (%MVC)') % x-axis label
ylabel('Actual subject force applyed (%MVC)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
ax = gca;  %% get handle to current axes
axis([0,100,0 max([mMXptHivec90 mMXptMivec90 mMXptLivec90])])
ax.XTick = [10 50 90];
ax.YTick = [(0:(SelfPower/10):SelfPower),(11*SelfPower/10:SelfPower/10 : max([mMXptHivec90 mMXptMivec90 mMXptLivec90]))];
viki= [(0:(SelfPower/10):SelfPower),(11*SelfPower/10:SelfPower/10 : max([mMXptHivec90 mMXptMivec90 mMXptLivec90]))]/(SelfPower/100);
viki=strread(num2str(viki),'%s');
ax.YTickLabel = viki;
savefig([singleSUB_result_folder '/' sub_name ' Mean Maximum pt '])
saveas(figfig,[singleSUB_result_folder '/' sub_name ' Mean Maximum pt .jpg'])

 %% mean pressure over time


mHivec10	=mean(	Hivec10	);
mMivec10	=mean(	Mivec10	);
mLivec10	=mean(	Livec10	);
mHivec50	=mean(	Hivec50	);
mMivec50	=mean(	Mivec50	);
mLivec50	=mean(	Livec50	);
mHivec90	=mean(	Hivec90	);
mMivec90	=mean(	Mivec90	);
mLivec90	=mean(	Livec90	);

figfig=figure;
hold on
plot(	mHivec10	,':b')
plot(	mMivec10    ,':g')
plot(	mLivec10	,':r')
plot(	mHivec50	,'--b')
plot(	mMivec50	,'--g')
plot(	mLivec50	,'--r')
plot(	mHivec90	,'-b')
plot(	mMivec90	,'-g')
plot(	mLivec90    ,'-r')


legend('H 10% MVC ' , ' M 10% MVC ' , ' L 10% MVC ' , ' H 50% MVC ' , ' M 50% MVC ' , ' L 50% MVC ' , ' H 90% MVC ' , ' M 90% MVC ' , ' L 90% MVC ' ,'Location','northwest')


ax = gca;  %% get handle to current axes
ax.XTick =(0:10:40);
ax.XTickLabel = {'0'   ,'375'   ,'750' , '1125', '1500'};
ax.YTick = [(0:(SelfPower/10):SelfPower),(11*SelfPower/10:SelfPower/10 : max([mLivec90 mMivec90 mHivec90]))];
viki= [(0:(SelfPower/10):SelfPower),(11*SelfPower/10:SelfPower/10 : max([mLivec90 mMivec90 mHivec90]))]/(SelfPower/100);
viki=strread(num2str(viki),'%s');
ax.YTickLabel = viki;


title('mean pressure over time at 3 value levels * 3 effort levels')
xlabel('time(ms)') % x-axis label
ylabel('%MVC') % y-axis label

savefig([singleSUB_result_folder '/' sub_name ' mean pressure over time'])
saveas(figfig,[singleSUB_result_folder '/' sub_name ' mean pressure over time.jpg'])

%% RT
for roww=1:row
    rtVEC	=	find	(	Hivec10	(	roww,:	)	>	SelfPower*0.05);
    if ~isempty(rtVEC)
        RTtHivec10	(roww)=37.5*(rtVEC(1)-1);
    else
        RTtHivec10(roww)= 0;
    end
    rtVEC	=	find	(	Mivec10	(	roww,:	)	>	SelfPower*0.05);
    if ~isempty(rtVEC)
        RTtMivec10	(roww)=37.5*(rtVEC(1)-1);
    else
        RTtMivec10(roww)= 0;
    end
    rtVEC	=	find	(	Livec10	(	roww,:	)	>	SelfPower*0.05);
    if ~isempty(rtVEC)
        RTtLivec10	(roww)=37.5*(rtVEC(1)-1);
    else
        RTtLivec10(roww)= 0;
    end
    rtVEC	=	find	(	Hivec50	(	roww,:	)	>	SelfPower*0.05);
    if ~isempty(rtVEC)
        RTtHivec50	(roww)=37.5*(rtVEC(1)-1);
    else
        RTtHivec50(roww)= 0;
    end
    rtVEC	=	find	(	Mivec50	(	roww,:	)	>	SelfPower*0.05);
    if ~isempty(rtVEC)
        RTtMivec50	(roww)=37.5*(rtVEC(1)-1);
    else
        RTtMivec50(roww)= 0;
    end
    rtVEC	=	find	(	Livec50	(	roww,:	)	>	SelfPower*0.05);
    if ~isempty(rtVEC)
        RTtLivec50	(roww)=37.5*(rtVEC(1)-1);
    else
        RTtLivec50(roww)= 0;
    end
    rtVEC	=	find	(	Hivec90	(	roww,:	)	>	SelfPower*0.05);
    if ~isempty(rtVEC)
        RTtHivec90	(roww)=37.5*(rtVEC(1)-1);
    else
        RTtHivec90(roww)= 0;
    end
    rtVEC	=	find	(	Mivec90	(	roww,:	)	>	SelfPower*0.05);
    if ~isempty(rtVEC)
        RTtMivec90	(roww)=37.5*(rtVEC(1)-1);
    else
        RTtMivec90(roww)= 0;
    end
    rtVEC	=	find	(	Livec90	(	roww,:	)	>	SelfPower*0.05);
    if ~isempty(rtVEC)
        RTtLivec90	(roww)=37.5*(rtVEC(1)-1);
    else
        RTtLivec90(roww)= 0;
    end
    
end


RTtHivec10(RTtHivec10==0)=nan;
RTtMivec10(RTtMivec10==0)=nan;
RTtLivec10(RTtLivec10==0)=nan;
RTtHivec50(RTtHivec50==0)=nan;
RTtMivec50(RTtMivec50==0)=nan;
RTtLivec50(RTtLivec50==0)=nan;
RTtHivec90(RTtHivec90==0)=nan;
RTtMivec90(RTtMivec90==0)=nan;
RTtLivec90(RTtLivec90==0)=nan;


mRTtHivec10=nanmean(RTtHivec10);
mRTtMivec10=nanmean(RTtMivec10);
mRTtLivec10=nanmean(RTtLivec10);
mRTtHivec50=nanmean(RTtHivec50);
mRTtMivec50=nanmean(RTtMivec50);
mRTtLivec50=nanmean(RTtLivec50);
mRTtHivec90=nanmean(RTtHivec90);
mRTtMivec90=nanmean(RTtMivec90);
mRTtLivec90=nanmean(RTtLivec90);


Hi=[mRTtHivec10 mRTtHivec50 mRTtHivec90];
Mi=[mRTtMivec10 mRTtMivec50 mRTtMivec90];
Li=[mRTtLivec10 mRTtLivec50 mRTtLivec90];


effort_levels=[10,50,90];

figfig=figure;
errorbar(effort_levels,Hi,[0 0 0],'b')
hold on
errorbar(effort_levels,Mi,[0 0 0],'g')
hold on
errorbar(effort_levels,Li,[0 0 0],'r')

title([ sub_name ' RT dyno '])
xlabel('Effort level required (%MVC)') % x-axis label
ylabel('RT (%ms)') % y-axis label
legend('High value items',' medium value items',' Low value items','')

title([ sub_name ' RT dyno '])
xlabel('Effort level required (%MVC)') % x-axis label
ylabel('RT (%ms)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];

savefig([singleSUB_result_folder '/' sub_name ' RT dyno '])
saveas(figfig,[singleSUB_result_folder '/' sub_name ' RT dyno .jpg'])


%%     % d max point
for roww=1:row
    
    MXdtHivec10	(roww)=max(str2num(cell2mat(dynoVec{roww,1}) )- MinCal)-SelfPower*0.1;
    MXdtMivec10(roww)=max(str2num(cell2mat(dynoVec{roww,2}) )- MinCal)-SelfPower*0.1;
    MXdtLivec10(roww)=max(str2num(cell2mat(dynoVec{roww,3}) )- MinCal)-SelfPower*0.1;
    MXdtHivec50(roww)=max(str2num(cell2mat(dynoVec{roww,4}) )- MinCal)-SelfPower*0.5;
    MXdtMivec50(roww)=max(str2num(cell2mat(dynoVec{roww,5}) )- MinCal)-SelfPower*0.5;
    MXdtLivec50(roww)=max(str2num(cell2mat(dynoVec{roww,6}) )- MinCal)-SelfPower*0.5;
    MXdtHivec90(roww)=max(str2num(cell2mat(dynoVec{roww,7}) )- MinCal)-SelfPower*0.9;
    MXdtMivec90(roww)=max(str2num(cell2mat(dynoVec{roww,8}) )- MinCal)-SelfPower*0.9;
    MXdtLivec90(roww)=max(str2num(cell2mat(dynoVec{roww,9}) )- MinCal)-SelfPower*0.9;
end


mMXdtHivec10	=	mean(	MXdtHivec10	);
mMXdtMivec10	=	mean(	MXdtMivec10	);
mMXdtLivec10	=	mean(	MXdtLivec10	);
mMXdtHivec50	=	mean(	MXdtHivec50	);
mMXdtMivec50	=	mean(	MXdtMivec50	);
mMXdtLivec50	=	mean(	MXdtLivec50	);
mMXdtHivec90	=	mean(	MXdtHivec90	);
mMXdtMivec90	=	mean(	MXdtMivec90	);
mMXdtLivec90	=	mean(	MXdtLivec90	);
% dlot % mean  % area under curve

Hi=[mMXdtHivec10 mMXdtHivec50 mMXdtHivec90];
Mi=[mMXdtMivec10 mMXdtMivec50 mMXdtMivec90];
Li=[mMXdtLivec10 mMXdtLivec50 mMXdtLivec90];


effort_levels=[10,50,90];

figfig=figure;
errorbar(effort_levels,Hi,[0 0 0],'b')
hold on
errorbar(effort_levels,Mi,[0 0 0],'g')
hold on
errorbar(effort_levels,Li,[0 0 0],'r')

title([ sub_name ' d force minus required  '])
xlabel('Effort level required (%MVC)') % x-axis label
ylabel('d force minus required(%MVC)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
ax = gca;  %% get handle to current axes
axis([0,100,min([mMXdtHivec90 mMXdtMivec90 mMXdtLivec90]) max([mMXdtHivec10 mMXdtMivec10 mMXdtLivec10])])
ax.XTick = [10 50 90];
ax.YTick = [min([mMXdtHivec90 mMXdtMivec90 mMXdtLivec90]):(max([mMXdtHivec10 mMXdtMivec10 mMXdtLivec10])/10):(max([mMXdtHivec10 mMXdtMivec10 mMXdtLivec10]))];
viki=[min([mMXdtHivec90 mMXdtMivec90 mMXdtLivec90])/SelfPower*100:(max([mMXdtHivec10 mMXdtMivec10 mMXdtLivec10])/SelfPower*10):(max([mMXdtHivec10 mMXdtMivec10 mMXdtLivec10])/SelfPower*100)];
viki=strread(num2str(viki),'%s');
ax.YTickLabel = viki;
savefig([singleSUB_result_folder '/' sub_name ' d force minus required  '])
saveas(figfig,[singleSUB_result_folder '/' sub_name ' d force minus required  .jpg'])



%% % target speed
for roww=1:row
    
    [MXptHivec10(1,roww),MXptHivec10(2,roww)]=max(str2num(cell2mat(dynoVec{roww,1}) )- MinCal);
    [MXptMivec10(1,roww),MXptMivec10(2,roww)]=max(str2num(cell2mat(dynoVec{roww,2}) )- MinCal);
    [MXptLivec10(1,roww),MXptLivec10(2,roww)]=max(str2num(cell2mat(dynoVec{roww,3}) )- MinCal);
    [MXptHivec50(1,roww),MXptHivec50(2,roww)]=max(str2num(cell2mat(dynoVec{roww,4}) )- MinCal);
    [MXptMivec50(1,roww),MXptMivec50(2,roww)]=max(str2num(cell2mat(dynoVec{roww,5}) )- MinCal);
    [MXptLivec50(1,roww),MXptLivec50(2,roww)]=max(str2num(cell2mat(dynoVec{roww,6}) )- MinCal);
    [MXptHivec90(1,roww),MXptHivec90(2,roww)]=max(str2num(cell2mat(dynoVec{roww,7}) )- MinCal);
    [MXptMivec90(1,roww),MXptMivec90(2,roww)]=max(str2num(cell2mat(dynoVec{roww,8}) )- MinCal);
    [MXptLivec90(1,roww),MXptLivec90(2,roww)]=max(str2num(cell2mat(dynoVec{roww,9}) )- MinCal);
    
    MXptHivec10(3	,	roww)	=	    MXptHivec10(1	,	roww)	/	MXptHivec10(2	,	roww)	/	37.50;
    MXptMivec10(3	,	roww)	=	    MXptMivec10(1	,	roww)	/	MXptMivec10(2	,	roww)	/	37.50;
    MXptLivec10(3	,	roww)	=	    MXptLivec10(1	,	roww)	/	MXptLivec10(2	,	roww)	/	37.50;
    MXptHivec50(3	,	roww)	=	    MXptHivec50(1	,	roww)	/	MXptHivec50(2	,	roww)	/	37.50;
    MXptMivec50(3	,	roww)	=	    MXptMivec50(1	,	roww)	/	MXptMivec50(2	,	roww)	/	37.50;
    MXptLivec50(3	,	roww)	=	    MXptLivec50(1	,	roww)	/	MXptLivec50(2	,	roww)	/	37.50;
    MXptHivec90(3	,	roww)	=	    MXptHivec90(1	,	roww)	/	MXptHivec90(2	,	roww)	/	37.50;
    MXptMivec90(3	,	roww)	=	    MXptMivec90(1	,	roww)	/	MXptMivec90(2	,	roww)	/	37.50;
    MXptLivec90(3	,	roww)	=	    MXptLivec90(1	,	roww)	/	MXptLivec90(2	,	roww)	/	37.50;
    
    
end


mMX_THivec10	=	mean(	MXptHivec10	(3,:));
mMX_TMivec10	=	mean(	MXptMivec10	(3,:));
mMX_TLivec10	=	mean(	MXptLivec10	(3,:));
mMX_THivec50	=	mean(	MXptHivec50	(3,:));
mMX_TMivec50	=	mean(	MXptMivec50	(3,:));
mMX_TLivec50	=	mean(	MXptLivec50	(3,:));
mMX_THivec90	=	mean(	MXptHivec90	(3,:));
mMX_TMivec90	=	mean(	MXptMivec90	(3,:));
mMX_TLivec90	=	mean(	MXptLivec90	(3,:));
% plot % mean  % area under curve

Hi=[mMX_THivec10 mMX_THivec50 mMX_THivec90];
Mi=[mMX_TMivec10 mMX_TMivec50 mMX_TMivec90];
Li=[mMX_TLivec10 mMX_TLivec50 mMX_TLivec90];


effort_levels=[10,50,90];

figfig=figure;
errorbar(effort_levels,Hi,[0 0 0],'b')
hold on
errorbar(effort_levels,Mi,[0 0 0],'g')
hold on
errorbar(effort_levels,Li,[0 0 0],'r')

title([ sub_name ' target speed '])
xlabel('Effort level required (%MVC)') % x-axis label
ylabel('target speed (mV/ms)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];

savefig([singleSUB_result_folder '/' sub_name ' target speed '])
saveas(figfig,[singleSUB_result_folder '/' sub_name ' target speed .jpg'])


