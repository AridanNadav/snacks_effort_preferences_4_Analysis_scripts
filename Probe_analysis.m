
% ~~~ Script for analyzing probe results, modified for EVA experiment ~~~
% ~~~~~~~~~~~~~~~ Nadav Aridan,  june 2016  ~~~~~~~~~~~~~~
%
% In order to run the script, you must locate and run the script from within
% "Analysis" folder. The script uses external function, called
% "Probe_recode" which join all probe output file into one matrix. Please
% make sure that function is also present in the analysis folder.
%
%analysis_path=pwd; % Analysis folder location
%outpath=['./../Output/']; % Output folder location
% % 
% % all_subjs_data{length(subjects)}={};
% % probe_results=zeros(length(subjects),18);
% % probe_results(:,1)=subjects;

% !for subjInd=1:length(subjects)
    %% probe 1
    %subject_data=Probe_recode(sub_name);
    Probe_recode_mac
    recalc_is_choice1
        %% probe 2 (from binary ranking 2)

    %recode_probe_from_BR2
    
    %allsubT=[ allsubT ; subject_data ];
    
    % The Probe_recode function will join all present output file for each subject into a single matrix, these are the matrix columns:
    % 1-subjectID       2-scanner	 3-order        4-block         5-run       6-trial	 7-onsettime    8-ImageLeft	 9-ImageRight	10-bidIndexLeft
    % 11-bidIndexRight	12-IsleftGo	 13-Response    14-PairType     15-Outcome  16-RT	 17-bidLeft     18-bidRight
    
     %all_subjs_data{subjInd}=data; %All subjects' data
    % unified probe  
  %%%% allsubTable=array2table(allsubT,'VariableNames',{ 'subjectID','scanner','order','block','run','trial','onsettime','ImageLeft','ImageRight','bidIndexLeft','bidIndexRight','IsleftGo','Response','PairType','Outcome','RT','bidLeft','bidRight'})
%    
%     
%     order=subject_data(1,3);
%     
% 
%     PairType=subject_data(:,14);
%     Outcome=subject_data(:,15);
%     Rank_left=subject_data(:,10);
%     Rank_right=subject_data(:,11);
%     
%    
%    
% 
%     
%     
% % Organize data in a summary table
%     probe_results(1,1)=subjects(subjectIndex);
% 
%     probe_results(1,2)=order;
%     
%     
%     probe_results(1,3)=sum(PairType==1&Outcome==1)/sum(PairType==1&Outcome~=999);  %    %High_90_vs_High_50     %1 
%     probe_results(1,4)=sum(PairType==2&Outcome==1)/sum(PairType==2&Outcome~=999);  %     %High_90_vs_High_10     %2
%     probe_results(1,5)=sum(PairType==3&Outcome==1)/sum(PairType==3&Outcome~=999);  %     %High_50_vs_High_10     %3
%     probe_results(1,6)=sum(PairType==4&Outcome==1)/sum(PairType==4&Outcome~=999); %     %Medium_90_vs_Medium_50 %4
%     probe_results(1,7)=sum(PairType==5&Outcome==1)/sum(PairType==5&Outcome~=999); %     %Medium_90_vs_Medium_10 %5
%     probe_results(1,8)=sum(PairType==6&Outcome==1)/sum(PairType==6&Outcome~=999); %     %Medium_50_vs_Medium_10 %6
%     probe_results(1,9)=sum(PairType==7&Outcome==1)/sum(PairType==7&Outcome~=999); %     %Low_90_vs_Low_50       %7
%     probe_results(1,10)=sum(PairType==8&Outcome==1)/sum(PairType==8&Outcome~=999); %     %Low_90_vs_Low_10       %8
%     probe_results(1,11)=sum(PairType==9&Outcome==1)/sum(PairType==9&Outcome~=999); %     %Low_50_vs_Low_10       %9
% 
% 
% %! end
% 
% Probe_results_table = cell(1+size(probe_results,1),size(probe_results,2));
% Titles = {'Subject', 'Order', 'High_90_vs_High_50', 'High_90_vs_High_10',...
%     'High_50_vs_High_10', 'Medium_90_vs_Medium_50', 'Medium_90_vs_Medium_10',...
%     'Medium_50_vs_Medium_10', 'Low_90_vs_Low_50', 'Low_90_vs_Low_10', 'Low_50_vs_Low_10'};
% Probe_results_table(1,:) = Titles;
% Probe_results_table(2:end,:) = num2cell(probe_results);
% 
% save([singleSUB_result_folder '/' sub_name '_Probe_results_table.mat'],'Probe_results_table')
% 
% 
% 
% 
% 
% figfig=figure;
% bar(probe_results(3:end))
% hold on
% plot([0 10],[0.5 0.5],'--r')
% 
% 
% title('Probe')
% xlabel('comparison (%MVCs)') % x-axis label
% ylabel('Percent Choice') % y-axis label
% set(gca,'XTickLabel',{'H:90 vs 50' ,'H:90 vs 10','H:50 vs 10','M:90 vs 50' ,'M:90 vs 10','M:50 vs 10','L:90 vs 50' ,'L:90 vs 10','L:50 vs 10','' })
% 
% savefig([singleSUB_result_folder '/' sub_name '_probe' ])
% saveas(figfig,[singleSUB_result_folder '/' sub_name '_probe.jpg'])