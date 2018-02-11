% BR_D
sub_name=num2str(sub_name);
ranks=(1:27);
ranks=ranks';
%% get _stopGoList_trainingstim
filE=dir([pwd '/EVA3_' sub_name '_stopGoList_trainingstim*.txt']);
filename=filE.name;
delimiter = '\t';
startRow = 1;
formatSpec = '%s%f%f%f%f';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter );
fclose(fileID);
sub_tableBR.trainingstim = table(dataArray{1:3}, 'VariableNames', {'Image','type','bid'});
sub_tableBR.trainingstim=sortrows(sub_tableBR.trainingstim);

clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%% get _ItemRankingResults1

filE=dir([pwd '/EVA3_' sub_name '_ItemRankingResults*.txt']);
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

sub_tableBR.integrate=table(sub_tableBR.trainingstim{:,1},sub_tableBR.trainingstim{:,2},sub_tableBR.trainingstim{:,3}, sub_tableBR.BR2{:,2}- sub_tableBR.BR1{:,2},sub_tableBR.BR2{:,3}- sub_tableBR.BR1{:,3}, 'VariableNames', {'Image','type','bid','Drank','Dcoli_Weight'});
sub_tableBR.integrate=sortrows(sub_tableBR.integrate,[2 3]);

save([singleSUB_result_folder '/' sub_name '_BR_D_table.mat'],'sub_tableBR')

%% BRd
BRd =table(...
    	(	sub_tableBR.integrate	{	1.00	:	3.00	,	4})...
    ,	(	sub_tableBR.integrate	{	4.00	:	6.00	,	4})...
    ,	(	sub_tableBR.integrate	{	7.00	:	9.00	,	4})...
    ,	(	sub_tableBR.integrate	{	10.00	:	12.00	,	4})...
    ,	(	sub_tableBR.integrate	{	13.00	:	15.00	,	4})...
    ,	(	sub_tableBR.integrate	{	16.00	:	18.00	,	4})...
    ,	(	sub_tableBR.integrate	{	19.00	:	21.00	,	4})...
    ,	(	sub_tableBR.integrate	{	22.00	:	24.00	,	4})...
    ,	(	sub_tableBR.integrate	{	25.00	:	27.00	,	4}),	...
    'VariableNames',{'H_10','M_10','L_10','H_50','M_50','L_50','H_90','M_90','L_90' });

writetable(BRd,[singleSUB_result_folder '/' sub_name '_BRd.csv'])


Mh9050=mean(BRd{:,1});
Mh9010=mean(BRd{:,2});
Mh5010=mean(BRd{:,3});
m9050=mean(BRd{:,4});
Mm9010=mean(BRd{:,5});
Mm5010=mean(BRd{:,6});
Ml9050=mean(BRd{:,7});
Ml9010=mean(BRd{:,8});
Ml5010=mean(BRd{:,9});

Eh9050=std(BRd{:,1})/sqrt(3);
Eh9010=std(BRd{:,2})/sqrt(3);
Eh5010=std(BRd{:,3})/sqrt(3);
Em9050=std(BRd{:,4})/sqrt(3);
Em9010=std(BRd{:,5})/sqrt(3);
Em5010=std(BRd{:,6})/sqrt(3);
El9050=std(BRd{:,7})/sqrt(3);
El9010=std(BRd{:,8})/sqrt(3);
El5010=std(BRd{:,9})/sqrt(3);


figfig=figure;

bar([Mh9050 Mh9010 Mh5010 m9050 Mm9010 Mm5010 Ml9050 Ml9010 Ml5010])
hold on
errorbar([Mh9050 Mh9010 Mh5010 m9050 Mm9010 Mm5010 Ml9050 Ml9010 Ml5010],[Eh9050 Eh9010 Eh5010 Em9050 Em9010 Em5010 El9050 El9010 El5010],'.r')


title([sub_name 'Difference in rank'])
xlabel('Effort level (%MVC)') % x-axis label
ylabel('Difference in rank') % y-axis label
set(gca,'XTickLabel',{'H 10','M 10','L 10','H 50','M 50','L 50','H 90','M 90','L 90','' })


savefig([singleSUB_result_folder '/' sub_name 'Difference in rank' ])
saveas(figfig,[singleSUB_result_folder '/' sub_name 'Difference in rank.jpg'])


%% colli
colli =table(...
    	(	sub_tableBR.integrate	{	1.00	:	3.00	,	5})...
    ,	(	sub_tableBR.integrate	{	4.00	:	6.00	,	5})...
    ,	(	sub_tableBR.integrate	{	7.00	:	9.00	,	5})...
    ,	(	sub_tableBR.integrate	{	10.00	:	12.00	,	5})...
    ,	(	sub_tableBR.integrate	{	13.00	:	15.00	,	5})...
    ,	(	sub_tableBR.integrate	{	16.00	:	18.00	,	5})...
    ,	(	sub_tableBR.integrate	{	19.00	:	21.00	,	5})...
    ,	(	sub_tableBR.integrate	{	22.00	:	24.00	,	5})...
    ,	(	sub_tableBR.integrate	{	25.00	:	27.00	,	5}),	...
    'VariableNames',{'High_90_vs_High_50', 'High_90_vs_High_10',...
    'High_50_vs_High_10', 'Medium_90_vs_Medium_50', 'Medium_90_vs_Medium_10',...
 'Medium_50_vs_Medium_10', 'Low_90_vs_Low_50', 'Low_90_vs_Low_10', 'Low_50_vs_Low_10' });

writetable(colli,[singleSUB_result_folder '/' sub_name '_colli.csv'])

Mh9050=mean(colli{:,1});
Mh9010=mean(colli{:,2});
Mh5010=mean(colli{:,3});
m9050=mean(colli{:,4});
Mm9010=mean(colli{:,5});
Mm5010=mean(colli{:,6});
Ml9050=mean(colli{:,7});
Ml9010=mean(colli{:,8});
Ml5010=mean(colli{:,9});

Eh9050=std(colli{:,1})/sqrt(3);
Eh9010=std(colli{:,2})/sqrt(3);
Eh5010=std(colli{:,3})/sqrt(3);
Em9050=std(colli{:,4})/sqrt(3);
Em9010=std(colli{:,5})/sqrt(3);
Em5010=std(colli{:,6})/sqrt(3);
El9050=std(colli{:,7})/sqrt(3);
El9010=std(colli{:,8})/sqrt(3);
El5010=std(colli{:,9})/sqrt(3);

figfig=figure;

bar([Mh9050 Mh9010 Mh5010 m9050 Mm9010 Mm5010 Ml9050 Ml9010 Ml5010])
hold on
errorbar([Mh9050 Mh9010 Mh5010 m9050 Mm9010 Mm5010 Ml9050 Ml9010 Ml5010],[Eh9050 Eh9010 Eh5010 Em9050 Em9010 Em5010 El9050 El9010 El5010],'.r')


title([sub_name 'Difference in colli weight'])
xlabel('Effort level (%MVC)') % x-axis label
ylabel('Difference in colli weight') % y-axis label
set(gca,'XTickLabel',{'H 10','M 10','L 10','H 50','M 50','L 50','H 90','M 90','L 90','' })


savefig([singleSUB_result_folder '/' sub_name 'Difference in colli' ])
saveas(figfig,[singleSUB_result_folder '/' sub_name 'Difference in colli.jpg'])


