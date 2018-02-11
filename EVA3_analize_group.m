% EVA4_analize_group
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% All subjects group level
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% run from  singleSUB folder
% require results folder with subfolders: singleSUB,allSUBS
splitpath = strsplit(pwd,'/');
splitpath_minData=[splitpath(1:end-1)];
output_P=[ strjoin([splitpath(1:end-2)],'/') '/Output'];
sub_fold=strjoin(splitpath_minData,'/');
allSUBS_result_folder=[sub_fold '/allSUBS' ]; % disQ for ubject to exclude analysis
singleSUB_result_folder=[sub_fold '/singleSUB'];

%%%%%%%%%%%%%%%%%%%%%%%%  all subs %%%%%%%%%%%%%%%%%%%%%%%%%
% subjects to analys
ALLsubjects=[401:426]; % subject to include
subjects2EXclud= [423,426];% subject to exclude: *no data(302),*low bdm (309,318,321,324,327), didnt fast (320)
subjects=ALLsubjects(~ismember(ALLsubjects,subjects2EXclud));
forloop=length(subjects);
NN=num2str(forloop);


SelfPoweR=[];

for subjectIndex = 1:forloop
        sub_name=num2str(subjects(subjectIndex));

load([output_P '/EVA4_' sub_name '_calib_parameters.mat'])
SelfPoweR=[SelfPoweR SelfPower];
% sub level variabels
end
SelPoweR=mean(SelfPoweR);
%% BDM histogram

AllSubs.hist=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    bdm=num2str(1);
    
    
    filename = [output_P '/EVA4_' subName '_BDM' bdm '.txt'];
    delimiter = '\t';
    startRow = 2;
    
    formatSpec = '%f%s%f%f%[^\n\r]';
    
    % Open the text file.
    fileID = fopen(filename,'r');
    
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
    
    % Close the text file.
    fclose(fileID);
    
    sub_tableGP = table(dataArray{1:end-1}, 'VariableNames', {'Trial','StimName','Bid','RT'});
    
    %Clear temporary variables
    clearvars filename delimiter startRow formatSpec fileID dataArray ans;
    
    AllSubs.hist=[AllSubs.hist ; sub_tableGP{:,3}]
    
    
end

hist(  AllSubs.hist,20);
title(['BDM: All control Subjects (N=' NN ')'  ]);
xlabel('Bid');
ylabel('Frequency');

current_fig  = gcf %current figure handle
savefig([allSUBS_result_folder '/hist'  ])
saveas(current_fig,[allSUBS_result_folder '/hist.jpg'])


%% goal
AllSubs.goalHi=[];
AllSubs.goalMed=[];
AllSubs.goallow=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName ' Percent goal reached.fig']);
    h = gcf %current figure handle;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    ydata = get(dataObjs{2}, 'YData');
    
    AllSubs.goalHi=[AllSubs.goalHi ; ydata{3}];
    AllSubs.goalMed=[AllSubs.goalMed ; ydata{2}];
    AllSubs.goallow=[ AllSubs.goallow ; ydata{1}];
    
    
    
    
    close(h)
    
end

effort_levels=[10,50,90];


h_Goal=[ nanmean(AllSubs.goalHi(:,1)) nanmean(AllSubs.goalHi(:,2)) nanmean(AllSubs.goalHi(:,3)) ];
m_Goal=[ nanmean(AllSubs.goalMed(:,1)) nanmean(AllSubs.goalMed(:,2)) nanmean(AllSubs.goalMed(:,3)) ];
l_Goal=[ nanmean(AllSubs.goallow(:,1)) nanmean(AllSubs.goallow(:,2)) nanmean(AllSubs.goallow(:,3)) ];

h_Goal_se=[ nanstd(AllSubs.goalHi(:,1))/sqrt(length(subjects))  nanstd(AllSubs.goalHi(:,2))/sqrt(length(subjects))  nanstd(AllSubs.goalHi(:,3))/sqrt(length(subjects))  ];
m_Goal_se=[ nanstd(AllSubs.goalMed(:,1))/sqrt(length(subjects))  nanstd(AllSubs.goalMed(:,2))/sqrt(length(subjects))  nanstd(AllSubs.goalMed(:,3))/sqrt(length(subjects))  ];
l_Goal_se=[ nanstd(AllSubs.goallow(:,1))/sqrt(length(subjects))  nanstd(AllSubs.goallow(:,2))/sqrt(length(subjects))  nanstd(AllSubs.goallow(:,3))/sqrt(length(subjects))  ];

figfig=figure;
errorbar(effort_levels,h_Goal,h_Goal_se,'b')
hold on
errorbar(effort_levels,m_Goal,m_Goal_se,'g')
hold on
errorbar(effort_levels,l_Goal,l_Goal_se,'r')

title( [ ' Percent goal reached (N=' NN  ')' ])
xlabel('Effort level (%MVC)') % x-axis label
ylabel('Percent goal reached') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northeast')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];
axis([0,100,0,110])
ax.YTickLabel = {'0','10','20','30','40','50','60','70','80','90','100',' '};

savefig([allSUBS_result_folder '/'  ' Percent goal reached'])
saveas(figfig,[allSUBS_result_folder '/'  ' Percent goal reached.jpg'])


close(figfig)


%% goal time
AllSubs.goalTimeHi=[];
AllSubs.goalTimeMed=[];
AllSubs.goalTimelow=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName ' Time2Goal.fig']);
    h = gcf %current figure handle;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    ydata = get(dataObjs{2}, 'YData');
    
    AllSubs.goalTimeHi=[AllSubs.goalTimeHi ; ydata{3}];
    AllSubs.goalTimeMed=[AllSubs.goalTimeMed ; ydata{2}];
    AllSubs.goalTimelow=[ AllSubs.goalTimelow ; ydata{1}];
    
    
    
    
    close(h)
    
end

effort_levels=[10,50,90];


h_Goal=[ nanmean(AllSubs.goalTimeHi(:,1)) nanmean(AllSubs.goalTimeHi(:,2)) nanmean(AllSubs.goalTimeHi(:,3)) ];
m_Goal=[ nanmean(AllSubs.goalTimeMed(:,1)) nanmean(AllSubs.goalTimeMed(:,2)) nanmean(AllSubs.goalTimeMed(:,3)) ];
l_Goal=[ nanmean(AllSubs.goalTimelow(:,1)) nanmean(AllSubs.goalTimelow(:,2)) nanmean(AllSubs.goalTimelow(:,3)) ];

h_Goal_se=[ nanstd(AllSubs.goalTimeHi(:,1))/sqrt(length(subjects))  nanstd(AllSubs.goalTimeHi(:,2))/sqrt(length(subjects))  nanstd(AllSubs.goalTimeHi(:,3))/sqrt(length(subjects))  ];
m_Goal_se=[ nanstd(AllSubs.goalTimeMed(:,1))/sqrt(length(subjects))  nanstd(AllSubs.goalTimeMed(:,2))/sqrt(length(subjects))  nanstd(AllSubs.goalTimeMed(:,3))/sqrt(length(subjects))  ];
l_Goal_se=[ nanstd(AllSubs.goalTimelow(:,1))/sqrt(length(subjects))  nanstd(AllSubs.goalTimelow(:,2))/sqrt(length(subjects))  nanstd(AllSubs.goalTimelow(:,3))/sqrt(length(subjects))  ];

figfig=figure;
errorbar(effort_levels,h_Goal,h_Goal_se,'b')
hold on
errorbar(effort_levels,m_Goal,m_Goal_se,'g')
hold on
errorbar(effort_levels,l_Goal,l_Goal_se,'r')

title( [ ' Time to goal (N=' NN  ')' ])
xlabel('Effort level (%MVC)') % x-axis label
ylabel('Time to goal (sec)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];

savefig([allSUBS_result_folder '/'  'Time to goal (N=' NN  ')'])
saveas(figfig,[allSUBS_result_folder '/'  'Time to goal (N=' NN  ').jpg'])


close(figfig)




%% Vas
AllSubs.VASHi=[];
AllSubs.VASMed=[];
AllSubs.VASlow=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName ' Percived effort.fig']);
    h = gcf %current figure handle;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    ydata = get(dataObjs{2}, 'YData');
    
    AllSubs.VASHi=[AllSubs.VASHi ; ydata{4}];
    AllSubs.VASMed=[AllSubs.VASMed ; ydata{3}];
    AllSubs.VASlow=[ AllSubs.VASlow ; ydata{2}];
    
    
    
    
    close(h)
    
end

effort_levels=[10,50,90];


h_Goal=[ nanmean(AllSubs.VASHi(:,1)) nanmean(AllSubs.VASHi(:,2)) nanmean(AllSubs.VASHi(:,3)) ];
m_Goal=[ nanmean(AllSubs.VASMed(:,1)) nanmean(AllSubs.VASMed(:,2)) nanmean(AllSubs.VASMed(:,3)) ];
l_Goal=[ nanmean(AllSubs.VASlow(:,1)) nanmean(AllSubs.VASlow(:,2)) nanmean(AllSubs.VASlow(:,3)) ];

h_Goal_se=[ nanstd(AllSubs.VASHi(:,1))/sqrt(length(subjects))  nanstd(AllSubs.VASHi(:,2))/sqrt(length(subjects))  nanstd(AllSubs.VASHi(:,3))/sqrt(length(subjects))  ];
m_Goal_se=[ nanstd(AllSubs.VASMed(:,1))/sqrt(length(subjects))  nanstd(AllSubs.VASMed(:,2))/sqrt(length(subjects))  nanstd(AllSubs.VASMed(:,3))/sqrt(length(subjects))  ];
l_Goal_se=[ nanstd(AllSubs.VASlow(:,1))/sqrt(length(subjects))  nanstd(AllSubs.VASlow(:,2))/sqrt(length(subjects))  nanstd(AllSubs.VASlow(:,3))/sqrt(length(subjects))  ];

figfig=figure;
errorbar(effort_levels,h_Goal,h_Goal_se,'b')
hold on
errorbar(effort_levels,m_Goal,m_Goal_se,'g')
hold on
errorbar(effort_levels,l_Goal,l_Goal_se,'r')


title([' Perceived effort for High, Medium & Low value items across different effort levels (N=' NN  ')'])
xlabel('Effort level (%MVC)') % x-axis label
ylabel('Perceived effort (VAS)') % y-axis label
legend('High value items','Medium value items',' Low value items','Location','northwest')
axis([0,100,0,10])
plot([0 100],[0 10],'--')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];
ax.YTick =  [1 5 9];
ax.YTickLabel = {'10','50','90'};

savefig([allSUBS_result_folder '/'  'Perceived effort (N=' NN  ')'])
saveas(figfig,[allSUBS_result_folder '/'  'Perceived effort (N=' NN  ').jpg'])


close(figfig)

%% Vas time

AllSubs.VASTimeHi=[];
AllSubs.VASTimeMed=[];
AllSubs.VASTimelow=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName ' VAS rt.fig']);
    h = gcf %current figure handle;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    ydata = get(dataObjs{2}, 'YData');
    
    AllSubs.VASTimeHi=[AllSubs.VASTimeHi ; ydata{3}];
    AllSubs.VASTimeMed=[AllSubs.VASTimeMed ; ydata{2}];
    AllSubs.VASTimelow=[ AllSubs.VASTimelow ; ydata{1}];
    
    
    
    
    close(h)
    
end

effort_levels=[10,50,90];


h_Goal=[ nanmean(AllSubs.VASTimeHi(:,1)) nanmean(AllSubs.VASTimeHi(:,2)) nanmean(AllSubs.VASTimeHi(:,3)) ];
m_Goal=[ nanmean(AllSubs.VASTimeMed(:,1)) nanmean(AllSubs.VASTimeMed(:,2)) nanmean(AllSubs.VASTimeMed(:,3)) ];
l_Goal=[ nanmean(AllSubs.VASTimelow(:,1)) nanmean(AllSubs.VASTimelow(:,2)) nanmean(AllSubs.VASTimelow(:,3)) ];

h_Goal_se=[ nanstd(AllSubs.VASTimeHi(:,1))/sqrt(length(subjects))  nanstd(AllSubs.VASTimeHi(:,2))/sqrt(length(subjects))  nanstd(AllSubs.VASTimeHi(:,3))/sqrt(length(subjects))  ];
m_Goal_se=[ nanstd(AllSubs.VASTimeMed(:,1))/sqrt(length(subjects))  nanstd(AllSubs.VASTimeMed(:,2))/sqrt(length(subjects))  nanstd(AllSubs.VASTimeMed(:,3))/sqrt(length(subjects))  ];
l_Goal_se=[ nanstd(AllSubs.VASTimelow(:,1))/sqrt(length(subjects))  nanstd(AllSubs.VASTimelow(:,2))/sqrt(length(subjects))  nanstd(AllSubs.VASTimelow(:,3))/sqrt(length(subjects))  ];

figfig=figure;
errorbar(effort_levels,h_Goal,h_Goal_se,'b')
hold on
errorbar(effort_levels,m_Goal,m_Goal_se,'g')
hold on
errorbar(effort_levels,l_Goal,l_Goal_se,'r')

title( [ ' Time to VAS (N=' NN  ')' ])
xlabel('Effort level (%MVC)') % x-axis label
ylabel('Time to VAS (sec)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];

savefig([allSUBS_result_folder '/'  'VAS rt (N=' NN  ')'])
saveas(figfig,[allSUBS_result_folder '/'  'VAS rt (N=' NN  ').jpg'])


close(figfig)

%% area under curve

AllSubs.AUCHi=[];
AllSubs.AUCMed=[];
AllSubs.AUClow=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName ' Mean area under curve .fig']);
    h = gcf %current figure handle;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    ydata = get(dataObjs{2}, 'YData');
    
    AllSubs.AUCHi=[AllSubs.AUCHi ; ydata{3}];
    AllSubs.AUCMed=[AllSubs.AUCMed ; ydata{2}];
    AllSubs.AUClow=[ AllSubs.AUClow ; ydata{1}];
    
    
    
    
    close(h)
    
end

effort_levels=[10,50,90];


h_AUC=[ nanmean(AllSubs.AUCHi(:,1)) nanmean(AllSubs.AUCHi(:,2)) nanmean(AllSubs.AUCHi(:,3)) ];
m_AUC=[ nanmean(AllSubs.AUCMed(:,1)) nanmean(AllSubs.AUCMed(:,2)) nanmean(AllSubs.AUCMed(:,3)) ];
l_AUC=[ nanmean(AllSubs.AUClow(:,1)) nanmean(AllSubs.AUClow(:,2)) nanmean(AllSubs.AUClow(:,3)) ];

h_AUC_se=[ nanstd(AllSubs.AUCHi(:,1))/sqrt(length(subjects))  nanstd(AllSubs.AUCHi(:,2))/sqrt(length(subjects))  nanstd(AllSubs.AUCHi(:,3))/sqrt(length(subjects))  ];
m_AUC_se=[ nanstd(AllSubs.AUCMed(:,1))/sqrt(length(subjects))  nanstd(AllSubs.AUCMed(:,2))/sqrt(length(subjects))  nanstd(AllSubs.AUCMed(:,3))/sqrt(length(subjects))  ];
l_AUC_se=[ nanstd(AllSubs.AUClow(:,1))/sqrt(length(subjects))  nanstd(AllSubs.AUClow(:,2))/sqrt(length(subjects))  nanstd(AllSubs.AUClow(:,3))/sqrt(length(subjects))  ];

figfig=figure;
errorbar(effort_levels,h_AUC,h_AUC_se,'b')
hold on
errorbar(effort_levels,m_AUC,m_AUC_se,'g')
hold on
errorbar(effort_levels,l_AUC,l_AUC_se,'r')


title([  ' Mean area under curve (N=' NN  ')'])
xlabel('Effort level (%MVC)') % x-axis label
ylabel('Mean area under curve  (V*time)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];
savefig([allSUBS_result_folder '/'  ' Mean area under curve '])
saveas(figfig,[allSUBS_result_folder '/'  ' Mean area under curve .jpg'])
close(figfig)


%% max point

AllSubs.MaxHi=[];
AllSubs.MaxMed=[];
AllSubs.Maxlow=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName ' Mean Maximum pt .fig']);
    h = gcf %current figure handle;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    ydata = get(dataObjs{2}, 'YData');
    
    AllSubs.MaxHi=[AllSubs.MaxHi ; ydata{3}];
    AllSubs.MaxMed=[AllSubs.MaxMed ; ydata{2}];
    AllSubs.Maxlow=[ AllSubs.Maxlow ; ydata{1}];
    
    
    
    
    close(h)
    
end

effort_levels=[10,50,90];


h_Max=[ nanmean(AllSubs.MaxHi(:,1))/SelPoweR/0.01 nanmean(AllSubs.MaxHi(:,2))/SelPoweR/0.01 nanmean(AllSubs.MaxHi(:,3))/SelPoweR/0.01 ];
m_Max=[ nanmean(AllSubs.MaxMed(:,1))/SelPoweR/0.01 nanmean(AllSubs.MaxMed(:,2))/SelPoweR/0.01 nanmean(AllSubs.MaxMed(:,3))/SelPoweR/0.01 ];
l_Max=[ nanmean(AllSubs.Maxlow(:,1))/SelPoweR/0.01 nanmean(AllSubs.Maxlow(:,2))/SelPoweR/0.01 nanmean(AllSubs.Maxlow(:,3))/SelPoweR/0.01 ];

h_Max_se=[ nanstd(AllSubs.MaxHi(:,1))/SelPoweR/0.01/sqrt(length(subjects))  nanstd(AllSubs.MaxHi(:,2))/sqrt(length(subjects))  nanstd(AllSubs.MaxHi(:,3))/SelPoweR/0.01/sqrt(length(subjects))  ];
m_Max_se=[ nanstd(AllSubs.MaxMed(:,1))/SelPoweR/0.01/sqrt(length(subjects))  nanstd(AllSubs.MaxMed(:,2))/SelPoweR/0.01/sqrt(length(subjects))  nanstd(AllSubs.MaxMed(:,3))/SelPoweR/0.01/sqrt(length(subjects))  ];
l_Max_se=[ nanstd(AllSubs.Maxlow(:,1))/SelPoweR/0.01/sqrt(length(subjects))  nanstd(AllSubs.Maxlow(:,2))/SelPoweR/0.01/sqrt(length(subjects))  nanstd(AllSubs.Maxlow(:,3))/SelPoweR/0.01/sqrt(length(subjects))  ];



figfig=figure;
errorbar(effort_levels,h_Max,h_Max_se,'b')
hold on
errorbar(effort_levels,m_Max,m_Max_se,'g')
hold on
errorbar(effort_levels,l_Max,l_Max_se,'r')

title([  ' Mean Maximum pt (N=' NN  ')'])
xlabel('Effort level required (%MVC)') % x-axis label
ylabel('Actual subjects force applyed (% mean MVC)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];




savefig([allSUBS_result_folder '/'  '  Mean Maximum pt '])
saveas(figfig,[allSUBS_result_folder '/'  '  Mean Maximum pt .jpg'])
close(figfig)


%% mean pressure over time

AllSubs.Hivec10 =zeros(length(subjects),40);
AllSubs.Mivec10	=zeros(length(subjects),40);
AllSubs.Livec10	=zeros(length(subjects),40);
AllSubs.Hivec50	=zeros(length(subjects),40);
AllSubs.Mivec50	=zeros(length(subjects),40);
AllSubs.Livec50	=zeros(length(subjects),40);
AllSubs.Hivec90	=zeros(length(subjects),40);
AllSubs.Mivec90	=zeros(length(subjects),40);
AllSubs.Livec90	=zeros(length(subjects),40);

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName ' mean pressure over time.fig']);
    h = gcf %current figure handle;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    ydata = get(dataObjs{2}, 'YData');
    
    AllSubs.Hivec10(looP,1:length(ydata{9}))=ydata{9};
    AllSubs.Mivec10(looP,1:length(ydata{8}))=ydata{8};
    AllSubs.Livec10(looP,1:length(ydata{7}))=ydata{7};
    AllSubs.Hivec50(looP,1:length(ydata{6}))=ydata{6};
    AllSubs.Mivec50(looP,1:length(ydata{5}))=ydata{5};
    AllSubs.Livec50(looP,1:length(ydata{4}))=ydata{4};
    AllSubs.Hivec90(looP,1:length(ydata{3}))=ydata{3};
    AllSubs.Mivec90(looP,1:length(ydata{2}))=ydata{2};
    AllSubs.Livec90(looP,1:length(ydata{1}))=ydata{1};
    
    
    close(h)
    
end



mHivec10	=	mean(	AllSubs.Hivec10/SelPoweR/0.01	);
mMivec10	=	mean(	AllSubs.Mivec10/SelPoweR/0.01);
mLivec10	=	mean(	AllSubs.Livec10/SelPoweR/0.01	);
mHivec50	=	mean(	AllSubs.Hivec50/SelPoweR/0.01	);
mMivec50	=	mean(	AllSubs.Mivec50/SelPoweR/0.01	);
mLivec50	=	mean(	AllSubs.Livec50/SelPoweR/0.01	);
mHivec90	=	mean(	AllSubs.Hivec90/SelPoweR/0.01	);
mMivec90	=	mean(	AllSubs.Mivec90/SelPoweR/0.01	);
mLivec90	=	mean(	AllSubs.Livec90	/SelPoweR/0.01);



SEHivec10	=	std(	AllSubs.Hivec10/SelPoweR/0.01	)/sqrt(length(subjects)) ;
SEMivec10	=	std(	AllSubs.Mivec10/SelPoweR/0.01   )/sqrt(length(subjects)) ;
SELivec10	=	std(	AllSubs.Livec10/SelPoweR/0.01	)/sqrt(length(subjects)) ;
SEHivec50	=	std(	AllSubs.Hivec50/SelPoweR/0.01	)/sqrt(length(subjects)) ;
SEMivec50	=	std(	AllSubs.Mivec50/SelPoweR/0.01	)/sqrt(length(subjects)) ;
SELivec50	=	std(	AllSubs.Livec50/SelPoweR/0.01	)/sqrt(length(subjects)) ;
SEHivec90	=	std(	AllSubs.Hivec90/SelPoweR/0.01	)/sqrt(length(subjects)) ;
SEMivec90	=	std(	AllSubs.Mivec90/SelPoweR/0.01	)/sqrt(length(subjects)) ;
SELivec90	=	std(	AllSubs.Livec90	/SelPoweR/0.01  )/sqrt(length(subjects)) ;



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




errorbar(	(1:42),mHivec10,	SEHivec10	,':b')
errorbar(	(1:42),mMivec10,   	SEMivec10	 ,':g')
errorbar(	(1:42),mLivec10,	SELivec10	,':r')
errorbar(	(1:42),mHivec50,	SEHivec50	,'--b')
errorbar(	(1:42),mMivec50,	SEMivec50	,'--g')
errorbar(	(1:42),mLivec50,	SELivec50	,'--r')
errorbar(	(1:42),mHivec90,	SEHivec90	,'-b')
errorbar(	(1:42),mMivec90,	SEMivec90	,'-g')
errorbar(	(1:42),mLivec90,  	SELivec90	  ,'-r')


legend('H 10% MVC ' , ' M 10% MVC ' , ' L 10% MVC ' , ' H 50% MVC ' , ' M 50% MVC ' , ' L 50% MVC ' , ' H 90% MVC ' , ' M 90% MVC ' , ' L 90% MVC ' ,'Location','northwest')


ax = gca;  %% get handle to current axes
ax.XTick =(0:10:40);
ax.XTickLabel = {'0'   ,'375'   ,'750' , '1125', '1500'};

title(['mean pressure over time at 3 value levels * 3 effort levels (N=' NN  ')'])
xlabel('time(ms)') % x-axis label
ylabel('force applyed (% mean MVC)') % y-axis label

savefig([allSUBS_result_folder '/'  ' mean pressure over time '])
saveas(figfig,[allSUBS_result_folder '/'  '  mean pressure over time.jpg'])
close(figfig)

%% RT

AllSubs.RTHi=[];
AllSubs.RTMed=[];
AllSubs.RTlow=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName ' RT dyno .fig']);
    h = gcf %current figure handle;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    ydata = get(dataObjs{2}, 'YData');
    
    AllSubs.RTHi=[AllSubs.RTHi ; ydata{3}];
    AllSubs.RTMed=[AllSubs.RTMed ; ydata{2}];
    AllSubs.RTlow=[ AllSubs.RTlow ; ydata{1}];
    
    
    
    
    close(h)
    
end

effort_levels=[10,50,90];


h_RT=[ nanmean(AllSubs.RTHi(:,1)) nanmean(AllSubs.RTHi(:,2)) nanmean(AllSubs.RTHi(:,3)) ];
m_RT=[ nanmean(AllSubs.RTMed(:,1)) nanmean(AllSubs.RTMed(:,2)) nanmean(AllSubs.RTMed(:,3)) ];
l_RT=[ nanmean(AllSubs.RTlow(:,1)) nanmean(AllSubs.RTlow(:,2)) nanmean(AllSubs.RTlow(:,3)) ];

h_RT_se=[ nanstd(AllSubs.RTHi(:,1))/sqrt(length(subjects))  nanstd(AllSubs.RTHi(:,2))/sqrt(length(subjects))  nanstd(AllSubs.RTHi(:,3))/sqrt(length(subjects))  ];
m_RT_se=[ nanstd(AllSubs.RTMed(:,1))/sqrt(length(subjects))  nanstd(AllSubs.RTMed(:,2))/sqrt(length(subjects))  nanstd(AllSubs.RTMed(:,3))/sqrt(length(subjects))  ];
l_RT_se=[ nanstd(AllSubs.RTlow(:,1))/sqrt(length(subjects))  nanstd(AllSubs.RTlow(:,2))/sqrt(length(subjects))  nanstd(AllSubs.RTlow(:,3))/sqrt(length(subjects))  ];



figfig=figure;
errorbar(effort_levels,h_RT,h_RT_se,'b')
hold on
errorbar(effort_levels,m_RT,m_RT_se,'g')
hold on
errorbar(effort_levels,l_RT,l_RT_se,'r')



title([  ' RT dyno (N=' NN  ')'])
xlabel('Effort level required (%MVC)') % x-axis label
ylabel('RT (ms)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];

savefig([allSUBS_result_folder '/'  '  RT dyno pt '])
saveas(figfig,[allSUBS_result_folder '/'  '  RT dyno.jpg'])
close(figfig)
%% d max point


AllSubs.dMxPHi=[];
AllSubs.dMxPMed=[];
AllSubs.dMxPlow=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName ' d force minus required  .fig']);
    h = gcf %current figure handle;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    ydata = get(dataObjs{2}, 'YData');
    
    AllSubs.dMxPHi=[AllSubs.dMxPHi ; ydata{3}];
    AllSubs.dMxPMed=[AllSubs.dMxPMed ; ydata{2}];
    AllSubs.dMxPlow=[ AllSubs.dMxPlow ; ydata{1}];
    
    
    
    
    close(h)
    
end

effort_levels=[10,50,90];


h_dMxP=[ nanmean(AllSubs.dMxPHi(:,1))/SelPoweR/0.01 nanmean(AllSubs.dMxPHi(:,2))/SelPoweR/0.01 nanmean(AllSubs.dMxPHi(:,3))/SelPoweR/0.01 ];
m_dMxP=[ nanmean(AllSubs.dMxPMed(:,1))/SelPoweR/0.01 nanmean(AllSubs.dMxPMed(:,2))/SelPoweR/0.01 nanmean(AllSubs.dMxPMed(:,3))/SelPoweR/0.01 ];
l_dMxP=[ nanmean(AllSubs.dMxPlow(:,1))/SelPoweR/0.01 nanmean(AllSubs.dMxPlow(:,2))/SelPoweR/0.01 nanmean(AllSubs.dMxPlow(:,3))/SelPoweR/0.01 ];

h_dMxP_se=[ nanstd(AllSubs.dMxPHi(:,1))/SelPoweR/0.01/sqrt(length(subjects))  nanstd(AllSubs.dMxPHi(:,2))/SelPoweR/0.01/sqrt(length(subjects))  nanstd(AllSubs.dMxPHi(:,3))/SelPoweR/0.01/sqrt(length(subjects))  ];
m_dMxP_se=[ nanstd(AllSubs.dMxPMed(:,1))/SelPoweR/0.01/sqrt(length(subjects))  nanstd(AllSubs.dMxPMed(:,2))/SelPoweR/0.01/sqrt(length(subjects))  nanstd(AllSubs.dMxPMed(:,3))/SelPoweR/0.01/sqrt(length(subjects))  ];
l_dMxP_se=[ nanstd(AllSubs.dMxPlow(:,1))/SelPoweR/0.01/sqrt(length(subjects))  nanstd(AllSubs.dMxPlow(:,2))/SelPoweR/0.01/sqrt(length(subjects))  nanstd(AllSubs.dMxPlow(:,3))/SelPoweR/0.01/sqrt(length(subjects))  ];



figfig=figure;
errorbar(effort_levels,h_dMxP,h_dMxP_se,'b')
hold on
errorbar(effort_levels,m_dMxP,m_dMxP_se,'g')
hold on
errorbar(effort_levels,l_dMxP,l_dMxP_se,'r')


title([  ' d force minus required  (N=' NN  ')'])
xlabel('Effort level required (%MVC)') % x-axis label
ylabel('d force minus required(%MVC)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northeast')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];


savefig([allSUBS_result_folder '/'  '  dMxP dyno pt '])
saveas(figfig,[allSUBS_result_folder '/'  '  dMxP dyno.jpg'])
close(figfig)

%% % target speed
AllSubs.speedHi=[];
AllSubs.speedMed=[];
AllSubs.speedlow=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName ' target speed .fig']);
    h = gcf %current figure handle;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    ydata = get(dataObjs{2}, 'YData');
    
    AllSubs.speedHi=[AllSubs.speedHi ; ydata{3}];
    AllSubs.speedMed=[AllSubs.speedMed ; ydata{2}];
    AllSubs.speedlow=[ AllSubs.speedlow ; ydata{1}];
    
    
    
    
    close(h)
    
end

effort_levels=[10,50,90];


h_speed=[ nanmean(AllSubs.speedHi(:,1)) nanmean(AllSubs.speedHi(:,2)) nanmean(AllSubs.speedHi(:,3)) ];
m_speed=[ nanmean(AllSubs.speedMed(:,1)) nanmean(AllSubs.speedMed(:,2)) nanmean(AllSubs.speedMed(:,3)) ];
l_speed=[ nanmean(AllSubs.speedlow(:,1)) nanmean(AllSubs.speedlow(:,2)) nanmean(AllSubs.speedlow(:,3)) ];

h_speed_se=[ nanstd(AllSubs.speedHi(:,1))/sqrt(length(subjects))  nanstd(AllSubs.speedHi(:,2))/sqrt(length(subjects))  nanstd(AllSubs.speedHi(:,3))/sqrt(length(subjects))  ];
m_speed_se=[ nanstd(AllSubs.speedMed(:,1))/sqrt(length(subjects))  nanstd(AllSubs.speedMed(:,2))/sqrt(length(subjects))  nanstd(AllSubs.speedMed(:,3))/sqrt(length(subjects))  ];
l_speed_se=[ nanstd(AllSubs.speedlow(:,1))/sqrt(length(subjects))  nanstd(AllSubs.speedlow(:,2))/sqrt(length(subjects))  nanstd(AllSubs.speedlow(:,3))/sqrt(length(subjects))  ];



figfig=figure;
errorbar(effort_levels,h_speed,h_speed_se,'b')
hold on
errorbar(effort_levels,m_speed,m_speed_se,'g')
hold on
errorbar(effort_levels,l_speed,l_speed_se,'r')


title([  ' target speed (N=' NN  ')'])
xlabel('Effort level required (%MVC)') % x-axis label
ylabel('target speed (V/ms)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northeast')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];


savefig([allSUBS_result_folder '/'  '   target speed'])
saveas(figfig,[allSUBS_result_folder '/'  '   target speed.jpg'])
close(figfig)


%% d BDM


AllSubs.dBDMHi=[];
AllSubs.dBDMMed=[];
AllSubs.dBDMlow=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName '_BDM_DofMeans.fig']);
    h = gcf %current figure handle;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    ydata = get(dataObjs{2}, 'YData');
    
    AllSubs.dBDMHi=[AllSubs.dBDMHi ; ydata{4}];
    AllSubs.dBDMMed=[AllSubs.dBDMMed ; ydata{3}];
    AllSubs.dBDMlow=[ AllSubs.dBDMlow ; ydata{2}];
    
    
    
    
    close(h)
    
end

effort_levels=[10,50,90];


h_Goal=[ nanmean(AllSubs.dBDMHi(:,1)) nanmean(AllSubs.dBDMHi(:,2)) nanmean(AllSubs.dBDMHi(:,3)) ];
m_Goal=[ nanmean(AllSubs.dBDMMed(:,1)) nanmean(AllSubs.dBDMMed(:,2)) nanmean(AllSubs.dBDMMed(:,3)) ];
l_Goal=[ nanmean(AllSubs.dBDMlow(:,1)) nanmean(AllSubs.dBDMlow(:,2)) nanmean(AllSubs.dBDMlow(:,3)) ];

h_Goal_se=[ nanstd(AllSubs.dBDMHi(:,1))/sqrt(length(subjects))  nanstd(AllSubs.dBDMHi(:,2))/sqrt(length(subjects))  nanstd(AllSubs.dBDMHi(:,3))/sqrt(length(subjects))  ];
m_Goal_se=[ nanstd(AllSubs.dBDMMed(:,1))/sqrt(length(subjects))  nanstd(AllSubs.dBDMMed(:,2))/sqrt(length(subjects))  nanstd(AllSubs.dBDMMed(:,3))/sqrt(length(subjects))  ];
l_Goal_se=[ nanstd(AllSubs.dBDMlow(:,1))/sqrt(length(subjects))  nanstd(AllSubs.dBDMlow(:,2))/sqrt(length(subjects))  nanstd(AllSubs.dBDMlow(:,3))/sqrt(length(subjects))  ];

figfig=figure;
errorbar(effort_levels,h_Goal,h_Goal_se,'b')
hold on
errorbar(effort_levels,m_Goal,m_Goal_se,'g')
hold on
errorbar(effort_levels,l_Goal,l_Goal_se,'r')

title(['Difference of means in bid for High, mid and Low value items across different effort levels (N=' NN  ')'])
xlabel('Effort level (%MVC)') % x-axis label
ylabel('Difference in bid (NIS)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
plot([0 100],[0 0],'--')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];

savefig([allSUBS_result_folder '/'  'dBDM (N=' NN  ')'])
saveas(figfig,[allSUBS_result_folder '/'  'dBDM (N=' NN  ').jpg'])


close(figfig)



%% d BDM 1 2

AllSubs.effort1_l10=[];
AllSubs.effort1_l50=[];
AllSubs.effort1_l90=[];
AllSubs.effort1_m10=[];
AllSubs.effort1_m50=[];
AllSubs.effort1_m90=[];
AllSubs.effort1_h10=[];
AllSubs.effort1_h50=[];
AllSubs.effort1_h90=[];
AllSubs.effort2_l10=[];
AllSubs.effort2_l50=[];
AllSubs.effort2_l90=[];
AllSubs.effort2_m10=[];
AllSubs.effort2_m50=[];
AllSubs.effort2_m90=[];
AllSubs.effort2_h10=[];
AllSubs.effort2_h50=[];
AllSubs.effort2_h90=[];
for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName '_BDM12_DofMeans.fig']);
    h = gcf %current figure handle;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    ydata = get(dataObjs{2}, 'YData');
    
    AllSubs.effort1_l10=[AllSubs.effort1_l10;ydata{1}(1)];
    AllSubs.effort1_l50=[AllSubs.effort1_l50;ydata{2}(1)];
    AllSubs.effort1_l90=[AllSubs.effort1_l90;ydata{3}(1)];
    AllSubs.effort1_m10=[AllSubs.effort1_m10;ydata{4}(1)];
    AllSubs.effort1_m50=[AllSubs.effort1_m50;ydata{5}(1)];
    AllSubs.effort1_m90=[AllSubs.effort1_m90;ydata{6}(1)];
    AllSubs.effort1_h10=[AllSubs.effort1_h10;ydata{7}(1)];
    AllSubs.effort1_h50=[AllSubs.effort1_h50;ydata{8}(1)];
    AllSubs.effort1_h90=[AllSubs.effort1_h90;ydata{9}(1)];
    
    AllSubs.effort2_l10=[AllSubs.effort2_l10;ydata{1}(2)];
    AllSubs.effort2_l50=[AllSubs.effort2_l50;ydata{2}(2)];
    AllSubs.effort2_l90=[AllSubs.effort2_l90;ydata{3}(2)];
    AllSubs.effort2_m10=[AllSubs.effort2_m10;ydata{4}(2)];
    AllSubs.effort2_m50=[AllSubs.effort2_m50;ydata{5}(2)];
    AllSubs.effort2_m90=[AllSubs.effort2_m90;ydata{6}(2)];
    AllSubs.effort2_h10=[AllSubs.effort2_h10;ydata{7}(2)];
    AllSubs.effort2_h50=[AllSubs.effort2_h50;ydata{8}(2)];
    AllSubs.effort2_h90=[AllSubs.effort2_h90;ydata{9}(2)];
    
    close(h)
    
end

meffort_10_h1=mean(AllSubs.effort1_h10);
meffort_10_h2=mean(AllSubs.effort2_h10);
meffort_10_l1=mean(AllSubs.effort1_l10);
meffort_10_l2=mean(AllSubs.effort2_l10);
meffort_10_m1=mean(AllSubs.effort1_m10);
meffort_10_m2=mean(AllSubs.effort2_m10);
meffort_50_h1=mean(AllSubs.effort1_h50);
meffort_50_h2=mean(AllSubs.effort2_h50);
meffort_50_l1=mean(AllSubs.effort1_l50);
meffort_50_l2=mean(AllSubs.effort2_l50);
meffort_50_m1=mean(AllSubs.effort1_m50);
meffort_50_m2=mean(AllSubs.effort2_m50);
meffort_90_h1=mean(AllSubs.effort1_h90);
meffort_90_h2=mean(AllSubs.effort2_h90);
meffort_90_l1=mean(AllSubs.effort1_l90);
meffort_90_l2=mean(AllSubs.effort2_l90);
meffort_90_m1=mean(AllSubs.effort1_m90);
meffort_90_m2=mean(AllSubs.effort2_m90);
SEeffort_10_h1=std(AllSubs.effort1_h10)/sqrt(length(subjects));
SEeffort_10_h2=std(AllSubs.effort2_h10)/sqrt(length(subjects));
SEeffort_10_l1=std(AllSubs.effort1_l10)/sqrt(length(subjects));
SEeffort_10_l2=std(AllSubs.effort2_l10)/sqrt(length(subjects));
SEeffort_10_m1=std(AllSubs.effort1_m10)/sqrt(length(subjects));
SEeffort_10_m2=std(AllSubs.effort2_m10)/sqrt(length(subjects));
SEeffort_50_h1=std(AllSubs.effort1_h50)/sqrt(length(subjects));
SEeffort_50_h2=std(AllSubs.effort2_h50)/sqrt(length(subjects));
SEeffort_50_l1=std(AllSubs.effort1_l50)/sqrt(length(subjects));
SEeffort_50_l2=std(AllSubs.effort2_l50)/sqrt(length(subjects));
SEeffort_50_m1=std(AllSubs.effort1_m50)/sqrt(length(subjects));
SEeffort_50_m2=std(AllSubs.effort2_m50)/sqrt(length(subjects));
SEeffort_90_h1=std(AllSubs.effort1_h90)/sqrt(length(subjects));
SEeffort_90_h2=std(AllSubs.effort2_h90)/sqrt(length(subjects));
SEeffort_90_l1=std(AllSubs.effort1_l90)/sqrt(length(subjects));
SEeffort_90_l2=std(AllSubs.effort2_l90)/sqrt(length(subjects));
SEeffort_90_m1=std(AllSubs.effort1_m90)/sqrt(length(subjects));
SEeffort_90_m2=std(AllSubs.effort2_m90)/sqrt(length(subjects));


bdm1AND2=figure;
hold on

errorbar([meffort_90_h1 meffort_90_h2],[SEeffort_90_h1 SEeffort_90_h2],'-b');
errorbar([meffort_50_h1 meffort_50_h2],[SEeffort_50_h1 SEeffort_50_h2],'--b');
errorbar([meffort_10_h1 meffort_10_h2],[SEeffort_10_h1 SEeffort_10_h2],':b');
errorbar([meffort_90_m1 meffort_90_m2],[SEeffort_90_m1 SEeffort_90_m2],'-g');
errorbar([meffort_50_m1 meffort_50_m2],[SEeffort_50_m1 SEeffort_50_m2],'--g');
errorbar([meffort_10_m1 meffort_10_m2],[SEeffort_10_m1 SEeffort_10_m2],':g');
errorbar([meffort_90_l1 meffort_90_l2],[SEeffort_90_l1 SEeffort_90_l2],'-r');
errorbar([meffort_50_l1 meffort_50_l2],[SEeffort_50_l1 SEeffort_50_l2],'--r');
errorbar([meffort_10_l1 meffort_10_l2],[SEeffort_10_l1 SEeffort_10_l2],':r');
ax = gca;  %% get handle to current axes
ax.XTick = [1 2];
title(['1st & 2nd bid for High, mid and Low value items across different effort levels (N=' NN  ')'])
xlabel('Bid 1st & 2nd') % x-axis label
ylabel(' Bid (NIS)') % y-axis label
legend('90_H','50_H','10_H','90_M','50_M','10_M','90_L','50_L','10_L','Location','northwest')



savefig([allSUBS_result_folder '/'  'dBDM12 (N=' NN  ')'])
saveas(bdm1AND2,[allSUBS_result_folder '/'  'dBDM12 (N=' NN  ').jpg'])


close(bdm1AND2)



%% Vas Recog
AllSubs.VASreCOGHi=[];
AllSubs.VASreCOGMed=[];
AllSubs.VASreCOGlow=[];

for looP=23:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName ' VAS Recognition.fig']);
    h = gcf %current figure handle;
    axesObjs = get(h, 'Children');  %axes handles
    dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    ydata = get(dataObjs{2}, 'YData');
    
    AllSubs.VASreCOGHi=[AllSubs.VASreCOGHi ; ydata{4}];
    AllSubs.VASreCOGMed=[AllSubs.VASreCOGMed ; ydata{3}];
    AllSubs.VASreCOGlow=[ AllSubs.VASreCOGlow ; ydata{2}];
    
    
    
    
%     close(h)
    
end

effort_levels=[10,50,90];


h_Goal=[ nanmean(AllSubs.VASreCOGHi(:,1)) nanmean(AllSubs.VASreCOGHi(:,2)) nanmean(AllSubs.VASreCOGHi(:,3)) ];
m_Goal=[ nanmean(AllSubs.VASreCOGMed(:,1)) nanmean(AllSubs.VASreCOGMed(:,2)) nanmean(AllSubs.VASreCOGMed(:,3)) ];
l_Goal=[ nanmean(AllSubs.VASreCOGlow(:,1)) nanmean(AllSubs.VASreCOGlow(:,2)) nanmean(AllSubs.VASreCOGlow(:,3)) ];

h_Goal_se=[ nanstd(AllSubs.VASreCOGHi(:,1))/sqrt(length(subjects))  nanstd(AllSubs.VASreCOGHi(:,2))/sqrt(length(subjects))  nanstd(AllSubs.VASreCOGHi(:,3))/sqrt(length(subjects))  ];
m_Goal_se=[ nanstd(AllSubs.VASreCOGMed(:,1))/sqrt(length(subjects))  nanstd(AllSubs.VASreCOGMed(:,2))/sqrt(length(subjects))  nanstd(AllSubs.VASreCOGMed(:,3))/sqrt(length(subjects))  ];
l_Goal_se=[ nanstd(AllSubs.VASreCOGlow(:,1))/sqrt(length(subjects))  nanstd(AllSubs.VASreCOGlow(:,2))/sqrt(length(subjects))  nanstd(AllSubs.VASreCOGlow(:,3))/sqrt(length(subjects))  ];

figfig=figure;
errorbar(effort_levels,h_Goal,h_Goal_se,'b')
hold on
errorbar(effort_levels,m_Goal,m_Goal_se,'g')
hold on
errorbar(effort_levels,l_Goal,l_Goal_se,'r')


title(['  VAS Recognition (N=' NN  ')'])
xlabel('Effort level (%MVC)') % x-axis label
ylabel('Perceived effort (VAS)') % y-axis label
legend('High value items','Medium value items',' Low value items','Location','northwest')
axis([0,100,0,10])
plot([0 100],[0 10],'--')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];
ax.YTick =  [1 5 9];
ax.YTickLabel = {'10','50','90'};

savefig([allSUBS_result_folder '/'  'VASreCOG (N=' NN  ')'])
saveas(figfig,[allSUBS_result_folder '/'  'VASreCOG (N=' NN  ').jpg'])


close(figfig)


%% BRD
AllSubs.BRd=[];

for looP=23:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName 'Difference in rank.fig']);
    h = gcf %current figure handle;
    h = findobj(h,'Type','bar')
    % axesObjs = get(h, 'Children');  %axes handles
    % dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    % objTypes = get(dataObjs, 'Type');  %type of low-level graphics object
    
    ydata = get(h, 'YData');
    
    AllSubs.BRd=[AllSubs.BRd ; ydata];
    
    
    
    h = gcf
    
    close(h)
    
end


figfig=figure;

bar(mean(AllSubs.BRd))
hold on
errorbar(mean(AllSubs.BRd),(std(AllSubs.BRd)/sqrt((length(subjects)))),'.r')


title( ['Difference in BR weight(N=' NN  ')'])
xlabel('Effort level (%MVC)') % x-axis label
ylabel('Difference in colli weight') % y-axis label
set(gca,'XTickLabel',{'H 10','M 10','L 10','H 50','M 50','L 50','H 90','M 90','L 90','' })

savefig([allSUBS_result_folder '/'  'BRd (N=' NN  ')'])
saveas(figfig,[allSUBS_result_folder '/'  'BRd (N=' NN  ').jpg'])



%% probe
AllSubs.probe=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName '_probe.fig']);
    h = gcf %current figure handle;
    h = findobj(h,'Type','bar')
    % axesObjs = get(h, 'Children');  %axes handles
    % dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    % objTypes = get(dataObjs, 'Type');  %type of low-level graphics object
    
    ydata = get(h, 'YData');
    
    AllSubs.probe=[AllSubs.probe ; ydata];
    
    
    
    h = gcf %current figure handle;
    
    
    close(h)
    
end


% figfig=figure;
% % bar(1:3,reshape(mean(AllSubs.probe),[3,3])')
% % hold on
% means=reshape(mean(AllSubs.probe),[3,3]);
% bar(1:3:7,means(1,:),0.3,'r')
% hold on
% bar(2:3:8,means(2,:),0.3,'k')
% hold on
% bar(3:3:9,means(3,:),0.3,'b')
% hold on
% errorbar(mean(AllSubs.probe),(std(AllSubs.probe)/sqrt((length(subjects)))),'.c')
% hold on
% plot([0 10],[0.5 0.5],'--r')
% 
% 
% title(['Probe (N=' NN  ')'])
% xlabel('comparison (%MVCs)') % x-axis label
% ylabel('Percent Choice') % y-axis label
% ax = gca;  %% get handle to current axes
% 
% ax.XTick = (1:9);
% 
% set(gca,'XTickLabel',{'H:90 vs 50' ,'H:90 vs 10','H:50 vs 10','M:90 vs 50' ,'M:90 vs 10','M:50 vs 10','L:90 vs 50' ,'L:90 vs 10','L:50 vs 10','' })

figfig=figure;
% bar(1:3,reshape(mean(AllSubs.probe),[3,3])')
% hold on
means=reshape(mean(AllSubs.probe),[3,3]);
bar(1:3,means(:,1),0.3,'b')
hold on
bar(4:6,means(:,2),0.3,'g')
hold on
bar(7:9,means(:,3),0.3,'r')
hold on
errorbar(mean(AllSubs.probe),(std(AllSubs.probe)/sqrt((length(subjects)))),'.k')
hold on
plot([0 10],[0.5 0.5],'--r')


title(['Probe (N=' NN  ')'])
xlabel('Effort levels compared (%MVCs)') % x-axis label
ylabel('Percent Choice of harder item') % y-axis label
ax = gca;  %% get handle to current axes

ax.XTick = (1:9);

set(gca,'XTickLabel',{'90 vs 50' ,'90 vs 10','50 vs 10','90 vs 50' ,'90 vs 10','50 vs 10','90 vs 50' ,'90 vs 10','50 vs 10','' })
% set(gca,'XTickLabel',{'H:90 vs 50' ,'H:90 vs 10','H:50 vs 10','M:90 vs 50' ,'M:90 vs 10','M:50 vs 10','L:90 vs 50' ,'L:90 vs 10','L:50 vs 10','' })

savefig([allSUBS_result_folder '/'  'probe (N=' NN  ')'])
saveas(figfig,[allSUBS_result_folder '/'  'probe (N=' NN  ').jpg'])


%% probe br1
AllSubs.probe=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName '_probeBR1.fig']);
    h = gcf %current figure handle;
    h = findobj(h,'Type','bar')
    % axesObjs = get(h, 'Children');  %axes handles
    % dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    % objTypes = get(dataObjs, 'Type');  %type of low-level graphics object
    
    ydata = get(h, 'YData');
    
    AllSubs.probe=[AllSubs.probe ; ydata];
    
    
    
    h = gcf %current figure handle;
    
    
    close(h)
    
end


% figfig=figure;
% % bar(1:3,reshape(mean(AllSubs.probe),[3,3])')
% % hold on
% means=reshape(mean(AllSubs.probe),[3,3]);
% bar(1:3:7,means(1,:),0.3,'r')
% hold on
% bar(2:3:8,means(2,:),0.3,'k')
% hold on
% bar(3:3:9,means(3,:),0.3,'b')
% hold on
% errorbar(mean(AllSubs.probe),(std(AllSubs.probe)/sqrt((length(subjects)))),'.c')
% hold on
% plot([0 10],[0.5 0.5],'--r')
% 
% 
% title(['Probe (N=' NN  ')'])
% xlabel('comparison (%MVCs)') % x-axis label
% ylabel('Percent Choice') % y-axis label
% ax = gca;  %% get handle to current axes
% 
% ax.XTick = (1:9);
% 
% set(gca,'XTickLabel',{'H:90 vs 50' ,'H:90 vs 10','H:50 vs 10','M:90 vs 50' ,'M:90 vs 10','M:50 vs 10','L:90 vs 50' ,'L:90 vs 10','L:50 vs 10','' })

figfig=figure;
% bar(1:3,reshape(mean(AllSubs.probe),[3,3])')
% hold on
means=reshape(mean(AllSubs.probe),[3,3]);
bar(1:3,means(:,1),0.3,'b')
hold on
bar(4:6,means(:,2),0.3,'g')
hold on
bar(7:9,means(:,3),0.3,'r')
hold on
errorbar(mean(AllSubs.probe),(std(AllSubs.probe)/sqrt((length(subjects)))),'.k')
hold on
plot([0 10],[0.5 0.5],'--r')


title(['Probe br1 (N=' NN  ')'])
xlabel('comparison (%MVCs)') % x-axis label
ylabel('Percent Choice') % y-axis label
ax = gca;  %% get handle to current axes

ax.XTick = (1:9);

set(gca,'XTickLabel',{'H:90 vs 50' ,'H:90 vs 10','H:50 vs 10','M:90 vs 50' ,'M:90 vs 10','M:50 vs 10','L:90 vs 50' ,'L:90 vs 10','L:50 vs 10','' })

savefig([allSUBS_result_folder '/'  'probe br1 (N=' NN  ')'])
saveas(figfig,[allSUBS_result_folder '/'  'probe br1 (N=' NN  ').jpg'])
%% probe x
AllSubs.probe=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName '_probeX.fig']);
    h = gcf %current figure handle;
    h = findobj(h,'Type','bar')
    % axesObjs = get(h, 'Children');  %axes handles
    % dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    % objTypes = get(dataObjs, 'Type');  %type of low-level graphics object
    
    ydata = get(h, 'YData');
    
    AllSubs.probe=[AllSubs.probe ; ydata];
    
    
    
    h = gcf %current figure handle;
    
    
    close(h)
    
end


% figfig=figure;
% % bar(1:3,reshape(mean(AllSubs.probe),[3,3])')
% % hold on
% means=reshape(mean(AllSubs.probe),[3,3]);
% bar(1:3:7,means(1,:),0.3,'r')
% hold on
% bar(2:3:8,means(2,:),0.3,'k')
% hold on
% bar(3:3:9,means(3,:),0.3,'b')
% hold on
% errorbar(mean(AllSubs.probe),(std(AllSubs.probe)/sqrt((length(subjects)))),'.c')
% hold on
% plot([0 10],[0.5 0.5],'--r')
% 
% 
% title(['Probe (N=' NN  ')'])
% xlabel('comparison (%MVCs)') % x-axis label
% ylabel('Percent Choice') % y-axis label
% ax = gca;  %% get handle to current axes
% 
% ax.XTick = (1:9);
% 
% set(gca,'XTickLabel',{'H:90 vs 50' ,'H:90 vs 10','H:50 vs 10','M:90 vs 50' ,'M:90 vs 10','M:50 vs 10','L:90 vs 50' ,'L:90 vs 10','L:50 vs 10','' })

figfig=figure;
% bar(1:3,reshape(mean(AllSubs.probe),[3,3])')
% hold on
means=reshape(mean(AllSubs.probe),[3,3]);
bar(1:3,means(:,3),0.3,'b')
hold on
bar(4:6,[means(2,1),means(1,1),means(2,2)],0.3,'g')
hold on
bar(7:9,[means(1,2),means(3,1),means(3,2)],0.3,'r')
hold on


errorbar([means(:,3)',[means(2,1),means(1,1),means(2,2)],[means(1,2),means(3,1),means(3,2)]],(std([AllSubs.probe(:,7),AllSubs.probe(:,8),AllSubs.probe(:,9),AllSubs.probe(:,2),AllSubs.probe(:,1),AllSubs.probe(:,5),AllSubs.probe(:,4),AllSubs.probe(:,3),AllSubs.probe(:,6)])/sqrt((length(subjects)))),'.k')
hold on


title(['Probe (N=' NN  ')'])
xlabel('comparison (%MVCs)') % x-axis label
ylabel('Percent Choice') % y-axis label
ax = gca;  %% get handle to current axes

ax.XTick = (1:9);

set(gca,'XTickLabel',{ ' H10 vs M90  ' ,' H50 vs M90  '  ,' H10 vs M50 ',' M10 vs L90  ' , '  M50 vs L90  ' ,  ' M10 vs L50  ', ' H10 vs L90  ',' H50 vs L90  ' ,' H10 vs L50 ', '' })

savefig([allSUBS_result_folder '/'  'probeX (N=' NN  ')'])
saveas(figfig,[allSUBS_result_folder '/'  'probeX (N=' NN  ').jpg'])
%% probe x1
AllSubs.probe=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName '_probeX1.fig']);
    h = gcf %current figure handle;
    h = findobj(h,'Type','bar')
    % axesObjs = get(h, 'Children');  %axes handles
    % dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    % objTypes = get(dataObjs, 'Type');  %type of low-level graphics object
    
    ydata = get(h, 'YData');
    
    AllSubs.probe=[AllSubs.probe ; ydata];
    
    
    
    h = gcf %current figure handle;
    
    
    close(h)
    
end


% figfig=figure;
% % bar(1:3,reshape(mean(AllSubs.probe),[3,3])')
% % hold on
% means=reshape(mean(AllSubs.probe),[3,3]);
% bar(1:3:7,means(1,:),0.3,'r')
% hold on
% bar(2:3:8,means(2,:),0.3,'k')
% hold on
% bar(3:3:9,means(3,:),0.3,'b')
% hold on
% errorbar(mean(AllSubs.probe),(std(AllSubs.probe)/sqrt((length(subjects)))),'.c')
% hold on
% plot([0 10],[0.5 0.5],'--r')
% 
% 
% title(['Probe (N=' NN  ')'])
% xlabel('comparison (%MVCs)') % x-axis label
% ylabel('Percent Choice') % y-axis label
% ax = gca;  %% get handle to current axes
% 
% ax.XTick = (1:9);
% 
% set(gca,'XTickLabel',{'H:90 vs 50' ,'H:90 vs 10','H:50 vs 10','M:90 vs 50' ,'M:90 vs 10','M:50 vs 10','L:90 vs 50' ,'L:90 vs 10','L:50 vs 10','' })

figfig=figure;
% bar(1:3,reshape(mean(AllSubs.probe),[3,3])')
% hold on
means=reshape(mean(AllSubs.probe),[3,3]);
bar(1:3,means(:,3),0.3,'b')
hold on
bar(4:6,[means(2,1),means(1,1),means(2,2)],0.3,'g')
hold on
bar(7:9,[means(1,2),means(3,1),means(3,2)],0.3,'r')
hold on


errorbar([means(:,3)',[means(2,1),means(1,1),means(2,2)],[means(1,2),means(3,1),means(3,2)]],(std([AllSubs.probe(:,7),AllSubs.probe(:,8),AllSubs.probe(:,9),AllSubs.probe(:,2),AllSubs.probe(:,1),AllSubs.probe(:,5),AllSubs.probe(:,4),AllSubs.probe(:,3),AllSubs.probe(:,6)])/sqrt((length(subjects)))),'.k')
hold on


title(['Probe x1 (N=' NN  ')'])
xlabel('comparison (%MVCs)') % x-axis label
ylabel('Percent Choice') % y-axis label
ax = gca;  %% get handle to current axes

ax.XTick = (1:9);

set(gca,'XTickLabel',{ ' H10 vs M90  ' ,' H50 vs M90  '  ,' H10 vs M50 ',' M10 vs L90  ' , '  M50 vs L90  ' ,  ' M10 vs L50  ', ' H10 vs L90  ',' H50 vs L90  ' ,' H10 vs L50 ', '' })

savefig([allSUBS_result_folder '/'  'probeX1 (N=' NN  ')'])
saveas(figfig,[allSUBS_result_folder '/'  'probeX1 (N=' NN  ').jpg'])

%% d probe


AllSubs.probe=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName '_probe.fig']);
    h = gcf %current figure handle;
    h = findobj(h,'Type','bar')
    % axesObjs = get(h, 'Children');  %axes handles
    % dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    % objTypes = get(dataObjs, 'Type');  %type of low-level graphics object
    
    ydata = get(h, 'YData');
    
    AllSubs.probe=[AllSubs.probe ; ydata];
    
    
    
    h = gcf %current figure handle;
    
    
    close(h)
    
end

AllSubs.probeBR1 =[];
for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName '_probeBR1.fig']);
    h = gcf %current figure handle;
    h = findobj(h,'Type','bar')
    % axesObjs = get(h, 'Children');  %axes handles
    % dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    % objTypes = get(dataObjs, 'Type');  %type of low-level graphics object
    
    ydata = get(h, 'YData');
    
    AllSubs.probeBR1=[AllSubs.probeBR1 ; ydata];
    
    
    
    h = gcf %current figure handle;
    
    
    close(h)
    
end

dprobe=AllSubs.probe-AllSubs.probeBR1;

figfig=figure;
% bar(1:3,reshape(mean(AllSubs.probe),[3,3])')
% hold on
means=reshape(mean(dprobe),[3,3]);
bar(1:3,means(:,1),0.3,'b')
hold on
bar(4:6,means(:,2),0.3,'g')
hold on
bar(7:9,means(:,3),0.3,'r')
hold on
errorbar(mean(dprobe),(std(dprobe)/sqrt((length(subjects)))),'.k')
hold on
plot([0 10],[0.5 0.5],'--r')


title(['Probe br1 (N=' NN  ')'])
xlabel('comparison (%MVCs)') % x-axis label
ylabel('Percent Choice') % y-axis label
ax = gca;  %% get handle to current axes

ax.XTick = (1:9);

set(gca,'XTickLabel',{'H:90 vs 50' ,'H:90 vs 10','H:50 vs 10','M:90 vs 50' ,'M:90 vs 10','M:50 vs 10','L:90 vs 50' ,'L:90 vs 10','L:50 vs 10','' })

savefig([allSUBS_result_folder '/'  'dprobe (N=' NN  ')'])
saveas(figfig,[allSUBS_result_folder '/'  'dprobe (N=' NN  ').jpg'])


%% d probe x


AllSubs.probe=[];

for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName '_probeX.fig']);
    h = gcf %current figure handle;
    h = findobj(h,'Type','bar')
    % axesObjs = get(h, 'Children');  %axes handles
    % dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    % objTypes = get(dataObjs, 'Type');  %type of low-level graphics object
    
    ydata = get(h, 'YData');
    
    AllSubs.probe=[AllSubs.probe ; ydata];
    
    
    
    h = gcf %current figure handle;
    
    
    close(h)
    
end

AllSubs.probeBR1 =[];
for looP=1:length(subjects)
    subName=num2str(subjects(looP));
    
    open([singleSUB_result_folder '/' subName '_probeX1.fig']);
    h = gcf %current figure handle;
    h = findobj(h,'Type','bar')
    % axesObjs = get(h, 'Children');  %axes handles
    % dataObjs = get(axesObjs, 'Children'); %handles to low-level graphics objects in axes
    % objTypes = get(dataObjs, 'Type');  %type of low-level graphics object
    
    ydata = get(h, 'YData');
    
    AllSubs.probeBR1=[AllSubs.probeBR1 ; ydata];
    
    
    
    h = gcf %current figure handle;
    
    
    close(h)
    
end

dprobe=AllSubs.probe-AllSubs.probeBR1;

figfig=figure;
% bar(1:3,reshape(mean(AllSubs.probe),[3,3])')
% hold on
means=reshape(mean(dprobe),[3,3]);
bar(1:3,means(:,3),0.3,'b')
hold on
bar(4:6,[means(2,1),means(1,1),means(2,2)],0.3,'g')
hold on
bar(7:9,[means(1,2),means(3,1),means(3,2)],0.3,'r')
hold on


errorbar([means(:,3)',[means(2,1),means(1,1),means(2,2)],[means(1,2),means(3,1),means(3,2)]],(std([dprobe(:,7),dprobe(:,8),dprobe(:,9),dprobe(:,2),dprobe(:,1),dprobe(:,5),dprobe(:,4),dprobe(:,3),dprobe(:,6)])/sqrt((length(subjects)))),'.k')
hold on


title(['D Probe x (N=' NN  ')'])
xlabel('comparison (%MVCs)') % x-axis label
ylabel('Percent Choice') % y-axis label
ax = gca;  %% get handle to current axes

ax.XTick = (1:9);

set(gca,'XTickLabel',{ ' H10 vs M90  ' ,' H50 vs M90  '  ,' H10 vs M50 ',' M10 vs L90  ' , '  M50 vs L90  ' ,  ' M10 vs L50  ', ' H10 vs L90  ',' H50 vs L90  ' ,' H10 vs L50 ', '' })

savefig([allSUBS_result_folder '/'  'DprobeX (N=' NN  ')'])
saveas(figfig,[allSUBS_result_folder '/'  'DprobeX (N=' NN  ').jpg'])
%%
close all
save ([allSUBS_result_folder '/'  'DATA.mat'])


