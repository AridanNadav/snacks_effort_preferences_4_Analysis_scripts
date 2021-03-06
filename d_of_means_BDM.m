% d_of_means_BDM 

effort_10_h1=[];
effort_10_l1=[];
effort_50_h1=[];
effort_50_l1=[];
effort_90_h1=[];
effort_90_l1=[];

effort_10_m1=[];
effort_10_l1=[];
effort_50_m1=[];
effort_50_l1=[];
effort_90_m1=[];
effort_90_l1=[];

effort_10_h2=[];
effort_10_l2=[];
effort_50_h2=[];
effort_50_l2=[];
effort_90_h2=[];
effort_90_l2=[];

effort_10_h_D=[];
effort_10_m_D=[];
effort_10_l_D=[];
effort_50_h_D=[];
effort_50_m_D=[];
effort_50_l_D=[];
effort_90_h_D=[];
effort_90_m_D=[];
effort_90_l_D=[];




% get order

% load(['EVA3_' sub_name '_exp_parameters.mat'],'order')

% LOADallstim

filename = [pwd '/EVA4_' sub_name '_stopGoList_allstim_order' num2str(order) '.txt'];
delimiter = '\t';
formatSpec = '%s%f%f%f%f%[^\n\r]';
fileID = fopen(filename);
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
sub_tableBDM = table(dataArray{1:end-1}, 'VariableNames', {'name','condition','rank','bid','present_order'});
clearvars filename delimiter formatSpec fileID dataArray ans;

% extract values separately for 1st and 2nd BDMs

sub_tableBDM=sortrows(sub_tableBDM);
sub_array.allstim=sub_tableBDM;
sub_array.inegrate(:,1)= sub_array.BDM1{:,3};
sub_array.inegrate(:,2)= sub_array.BDM2{:,3};
sub_array.inegrate(:,3)= sub_array.allstim{:,2};
sub_array.inegrate(:,4)= sub_array.allstim{:,3};
sub_array.inegrate(:,5)= sub_array.inegrate(:,1)- sub_array.inegrate(:,2); % !!!!

%% d of means 1st-2nd

effort_10_h_n=0;
effort_10_m_n=0;
effort_10_l_n=0;
effort_50_h_n=0;
effort_50_m_n=0;
effort_50_l_n=0;
effort_90_h_n=0;
effort_90_m_n=0;
effort_90_l_n=0;

hVEC=(4:12);
mVEC=(26:34);
lVEC=(49:57);


for snack= 1:60
    if   sub_array.inegrate(snack,3)==1 && ismember(sub_array.inegrate(snack,4),hVEC)
        effort_10_h_n=effort_10_h_n+1;
        effort_10_h1(effort_10_h_n)=sub_array.inegrate(snack,1);
        effort_10_h2(effort_10_h_n)=sub_array.inegrate(snack,2);
        
    elseif  sub_array.inegrate(snack,3)==1 && ismember(sub_array.inegrate(snack,4),mVEC)
        effort_10_m_n=effort_10_m_n+1;
        effort_10_m1(effort_10_m_n)=sub_array.inegrate(snack,1);
        effort_10_m2(effort_10_m_n)=sub_array.inegrate(snack,2);
        
    elseif  sub_array.inegrate(snack,3)==1 && ismember(sub_array.inegrate(snack,4),lVEC)
        effort_10_l_n=effort_10_l_n+1;
        effort_10_l1(effort_10_l_n)=sub_array.inegrate(snack,1);
        effort_10_l2(effort_10_l_n)=sub_array.inegrate(snack,2);
        
    elseif  sub_array.inegrate(snack,3)==2 && ismember(sub_array.inegrate(snack,4),hVEC)
        effort_50_h_n=effort_50_h_n+1;
        effort_50_h1(effort_50_h_n)=sub_array.inegrate(snack,1);
        effort_50_h2(effort_50_h_n)=sub_array.inegrate(snack,2);
        
    elseif  sub_array.inegrate(snack,3)==2 && ismember(sub_array.inegrate(snack,4),mVEC)
        effort_50_m_n=effort_50_m_n+1;
        effort_50_m1(effort_50_m_n)=sub_array.inegrate(snack,1);
        effort_50_m2(effort_50_m_n)=sub_array.inegrate(snack,2);
        
        
    elseif  sub_array.inegrate(snack,3)==2 && ismember(sub_array.inegrate(snack,4),lVEC)
        effort_50_l_n=effort_50_l_n+1;
        effort_50_l1(effort_50_l_n)=sub_array.inegrate(snack,1);
        effort_50_l2(effort_50_l_n)=sub_array.inegrate(snack,2);
        
        
    elseif  sub_array.inegrate(snack,3)==3 && ismember(sub_array.inegrate(snack,4),hVEC)
        effort_90_h_n=effort_90_h_n+1;
        effort_90_h1(effort_90_h_n)=sub_array.inegrate(snack,1);
        effort_90_h2(effort_90_h_n)=sub_array.inegrate(snack,2);
        
    elseif  sub_array.inegrate(snack,3)==3 && ismember(sub_array.inegrate(snack,4),mVEC)
        effort_90_m_n=effort_90_m_n+1;
        effort_90_m1(effort_90_m_n)=sub_array.inegrate(snack,1);
        effort_90_m2(effort_90_m_n)=sub_array.inegrate(snack,2);
        
    elseif  sub_array.inegrate(snack,3)==3 && ismember(sub_array.inegrate(snack,4),lVEC)
        effort_90_l_n=effort_90_l_n+1;
        effort_90_l1(effort_90_l_n)=sub_array.inegrate(snack,1);
        effort_90_l2(effort_90_l_n)=sub_array.inegrate(snack,2);
    end
end



meffort_10_h1=mean(effort_10_h1);
meffort_10_l1=mean(effort_10_l1);
meffort_50_h1=mean(effort_50_h1);
meffort_50_l1=mean(effort_50_l1);
meffort_90_h1=mean(effort_90_h1);
meffort_90_l1=mean(effort_90_l1);

meffort_50_m1=mean(effort_50_m1);
meffort_10_m1=mean(effort_10_m1);
meffort_90_m1=mean(effort_90_m1);
meffort_50_m2=mean(effort_50_m2);
meffort_10_m2=mean(effort_10_m2);
meffort_90_m2=mean(effort_90_m2);


meffort_10_h2=mean(effort_10_h2);
meffort_10_l2=mean(effort_10_l2);
meffort_50_h2=mean(effort_50_h2);
meffort_50_l2=mean(effort_50_l2);
meffort_90_h2=mean(effort_90_h2);
meffort_90_l2=mean(effort_90_l2);


SEeffort_10_h1=std(effort_10_h1)/sqrt(3);
SEeffort_10_l1=std(effort_10_l1)/sqrt(3);
SEeffort_50_h1=std(effort_50_h1)/sqrt(3);
SEeffort_50_l1=std(effort_50_l1)/sqrt(3);
SEeffort_90_h1=std(effort_90_h1)/sqrt(3);
SEeffort_90_l1=std(effort_90_l1)/sqrt(3);

SEeffort_50_m1=std(effort_50_m1)/sqrt(3);
SEeffort_10_m1=std(effort_10_m1)/sqrt(3);
SEeffort_90_m1=std(effort_90_m1)/sqrt(3);
SEeffort_50_m2=std(effort_50_m2)/sqrt(3);
SEeffort_10_m2=std(effort_10_m2)/sqrt(3);
SEeffort_90_m2=std(effort_90_m2)/sqrt(3);

SEeffort_10_h2=std(effort_10_h2)/sqrt(3);
SEeffort_10_l2=std(effort_10_l2)/sqrt(3);
SEeffort_50_h2=std(effort_50_h2)/sqrt(3);
SEeffort_50_l2=std(effort_50_l2)/sqrt(3);
SEeffort_90_h2=std(effort_90_h2)/sqrt(3);
SEeffort_90_l2=std(effort_90_l2)/sqrt(3);


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
title('1st & 2nd bid for High, mid and Low value items across different effort levels ')
xlabel('Bid 1st & 2nd') % x-axis label
ylabel(' Bid (NIS)') % y-axis label
legend('90_H','50_H','10_H','90_M','50_M','10_M','90_L','50_L','10_L','Location','northwest')
savefig(bdm1AND2,[singleSUB_result_folder '/' sub_name '_BDM12_DofMeans'])
saveas(bdm1AND2,[singleSUB_result_folder '/' sub_name '_d_bdm12.jpg'])






%% D
meffort_10_h_D=meffort_10_h2-meffort_10_h1;
meffort_10_l_D=meffort_10_l2-meffort_10_l1;
meffort_50_h_D=meffort_50_h2-meffort_50_h1;
meffort_50_l_D=meffort_50_l2-meffort_50_l1;
meffort_90_h_D=meffort_90_h2-meffort_90_h1;
meffort_90_l_D=meffort_90_l2-meffort_90_l1;
meffort_10_m_D=meffort_10_m2-meffort_10_m1;
meffort_90_m_D=meffort_90_m2-meffort_90_m1;
meffort_50_m_D=meffort_50_m2-meffort_50_m1;

SEeffort_10_m_D=SEeffort_10_m2-SEeffort_10_m1;
SEeffort_90_m_D=SEeffort_90_m2-SEeffort_90_m1;
SEeffort_50_m_D=SEeffort_50_m2-SEeffort_50_m1;
SEeffort_10_h_D=SEeffort_10_h2-SEeffort_10_h1;
SEeffort_10_l_D=SEeffort_10_l2-SEeffort_10_l1;
SEeffort_50_h_D=SEeffort_50_h2-SEeffort_50_h1;
SEeffort_50_l_D=SEeffort_50_l2-SEeffort_50_l1;
SEeffort_90_h_D=SEeffort_90_h2-SEeffort_90_h1;
SEeffort_90_l_D=SEeffort_90_l2-SEeffort_90_l1;



h_d_bdm=[meffort_10_h_D meffort_50_h_D meffort_90_h_D];
h_d_bdm_se1=[SEeffort_10_h_D SEeffort_50_h_D SEeffort_90_h_D];
m_d_bdm=[meffort_10_m_D meffort_50_m_D meffort_90_m_D];
m_d_bdm_se1=[SEeffort_10_m_D SEeffort_50_m_D SEeffort_90_m_D];
l_d_bdm=[meffort_10_l_D meffort_50_l_D meffort_90_l_D];
l_d_bdm_se1=[SEeffort_10_l_D SEeffort_50_l_D SEeffort_90_l_D];

effort_levels=[10,50,90];

d_bdm1=figure;
errorbar(effort_levels,h_d_bdm,h_d_bdm_se1,'b')
hold on
errorbar(effort_levels,m_d_bdm,m_d_bdm_se1,'g')
hold on
errorbar(effort_levels,l_d_bdm,l_d_bdm_se1,'r')

title('Difference of means in bid for High, mid and Low value items across different effort levels')
xlabel('Effort level (%MVC)') % x-axis label
ylabel('Difference in bid (NIS)') % y-axis label
legend('High value items',' medium value items',' Low value items','Location','northwest')
plot([0 100],[0 0],'--')
ax = gca;  %% get handle to current axes
ax.XTick = [10 50 90];
savefig([singleSUB_result_folder '/' sub_name '_BDM_DofMeans'])
saveas(d_bdm1,[singleSUB_result_folder '/' sub_name '_d_bdm.jpg'])



