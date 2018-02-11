filename = '/Users/papanadipapanadi/Google_Drive/Tom_LAB/Experiments/EVA3/Output/EVA3PE3.csv';
delimiter = ',';
startRow = 2;
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
EVA3PE3 = table(dataArray{1:end-1}, 'VariableNames', {'subjectID','itemL','itemR','Response_is_L','value','compar','Outcome_RealEffort','PE1_left','PE1_right','PE2_left','PE2_right','D_PE_HL_byRE_vas1','D_PE_HL_byRE_vas2','D_LminR_PE1','D_LminR_PE2'});
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

EVA3PE3{:,'D_LminR_PE1'}=round(EVA3PE3{:,'D_LminR_PE1'});

PEs={'During training','End of experiment'};
VALs={'High','Medium','Low'};
for PE=1:2
    for VAL=1:3;
        T1=[];
        for i= -9:9
            T1(1,i+10)=i;
            T1(2,i+10)=nanmean(EVA3PE3{(EVA3PE3{:,['D_LminR_PE' num2str(PE)]}==i & EVA3PE3{:,'value'}==VAL),'Response_is_L'});
            T1(3,i+10)=sum(EVA3PE3{:,['D_LminR_PE' num2str(PE)]}==i & EVA3PE3{:,'value'}==VAL)   ;
        end
        
        sum(T1(3,:))
        fig=figure;
        hold on
        Area=area(T1(1,:),T1(3,:)/max(T1(3,:)));
        legend(['mode = ' num2str(max(T1(3,:)))])
        Area.FaceColor=[0.7 0.7 0.7];
        Area.EdgeColor='none';
        alpha(.5)
        scat=scatter(T1(1,:),T1(2,:));
        set(scat,'LineWidth',5)
        xlabel('delat PE') % x-axis label
        ylabel('% Item choice') % y-axis label
        ylim([0 1])
        h=lsline;
        h.Color=[0 0 0];
        set(h,'LineWidth',3)
        set(gca,'fontsize',14)
        cor=corrcoef(T1(1,:),T1(2,:));
        title([  'Sample 3 -' PEs{PE} '- Value: ' VALs{VAL} '- r = ' num2str(cor(2)) ]);
        savefig(['Sample 3 -' PEs{PE} '- Value ' VALs{VAL} '.fig'])
        close (fig)
        
        
        
        
        
    end
end





%%
filename = '/Users/papanadipapanadi/Google_Drive/Tom_LAB/Experiments/EVA4/Output/EVA4PE3.csv';
delimiter = ',';
startRow = 2;
formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN,'HeaderLines' ,startRow-1, 'ReturnOnError', false);
fclose(fileID);
EVA4PE3 = table(dataArray{1:end-1}, 'VariableNames', {'subjectID','itemL','itemR','Response_is_L','value','compar','Outcome_RealEffort','PE1_left','PE1_right','PE2_left','PE2_right','PE3_left','PE3_right','D_LminR_PE1','D_LminR_PE2','D_LminR_PE3'});
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

PEs={'Mid training','End of training ','End of experiment'};
VALs={'High','Medium','Low'};
for PE=1:3
    for VAL=1:3;
        T1=[];
        
        for i= -3:3
            
            T1(1,i+4)=i;
            T1(2,i+4)=nanmean(EVA4PE3{(EVA4PE3{:,['D_LminR_PE' num2str(PE)]}==i & EVA4PE3{:,'value'}==VAL),'Response_is_L'});
            T1(3,i+4)=sum(EVA4PE3{:,['D_LminR_PE' num2str(PE)]}==i & EVA4PE3{:,'value'}==VAL)   ;
        end
        sum(T1(3,:))
        
        fig=figure;
        hold on
        Area=area(T1(1,:),T1(3,:)/max(T1(3,:)));
        Area.FaceColor=[0.7 0.7 0.7];
        Area.EdgeColor='none';
                legend(['mode = ' num2str(max(T1(3,:)))])

        alpha(.5)
        scat=scatter(T1(1,:),T1(2,:));
        set(scat,'LineWidth',5)
        xlabel('delat PE') % x-axis label
        ylabel('% Item choice') % y-axis label
        ylim([0 1])
        h=lsline;
        h.Color=[0 0 0];
        set(h,'LineWidth',3)
        set(gca,'fontsize',14)
        cor=corrcoef(T1(1,:),T1(2,:));
        title([  'Sample 4 -' PEs{PE} '- Value: ' VALs{VAL} '- r = ' num2str(cor(2)) ]);
        savefig(['Sample 4 -' PEs{PE} '- Value: ' VALs{VAL} '.fig'])
        close (fig)
        
        
    end
end


