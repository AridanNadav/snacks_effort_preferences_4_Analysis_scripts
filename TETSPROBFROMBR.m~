subject_data=[0];

for reoutcome=1:length(subject_BR2data)
    
    reoutcome
    %%%% left case
    if ismember(subject_BR2data(reoutcome,6),LV_90)%%%%%%%%%%%%%%%%%%%%%%LV_90
        if ismember(subject_BR2data(reoutcome,7),MV_50)
            subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);% item left
            subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);%item right
            subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);% response 1=left
            subject_data(length(subject_data(:,1)),4)=1; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),5)=1;
            end
            
            
        elseif  ismember(subject_BR2data(reoutcome,7),MV_10)
            
            subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),4)=2; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),5)=1;
            end
            
        elseif  ismember(subject_BR2data(reoutcome,7),HV_50)
            
            subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),4)=3; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),5)=1;
            end
            
        elseif  ismember(subject_BR2data(reoutcome,7),HV_10)
            
            subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),4)=4; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),5)=1;
            end
            
            
        end
        
        
    elseif ismember(subject_BR2data(reoutcome,6),LV_50)%%%%%%%%%%%%%%%%%%%% LV_50
        if ismember(subject_BR2data(reoutcome,7),MV_10)
            subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);% item left
            subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);%item right
            subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);% response 1=left
            subject_data(length(subject_data(:,1)),4)=5; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),5)=1;
            end
            
            
        elseif  ismember(subject_BR2data(reoutcome,7),HV_10)
            
            subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),4)=6; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),5)=1;
            end
        end
    elseif ismember(subject_BR2data(reoutcome,6),MV_90)   %%%%%%%%%%%%%%%%% MV_90
        if ismember(subject_BR2data(reoutcome,7),HV_10)
            subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);% item left
            subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);%item right
            subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);% response 1=left
            subject_data(length(subject_data(:,1)),4)=7; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),5)=1;
            end
            
            
        elseif  ismember(subject_BR2data(reoutcome,7),HV_50)
            
            subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),4)=8; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),5)=1;
            end
        end
        
    elseif ismember(subject_BR2data(reoutcome,6),MV_50)%%%%%%%%%%%%%%%%%%%% MV_50
        if ismember(subject_BR2data(reoutcome,7),HV_10)
            subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);% item left
            subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);%item right
            subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);% response 1=left
            subject_data(length(subject_data(:,1)),4)=9; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),5)=1;
            end
            
            %  :( chose less effortfull
        elseif  ismember(subject_BR2data(reoutcome,7),LV_90)
            
            subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);
            subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);
            subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);
            subject_data(length(subject_data(:,1)),4)=1; % pair type
            if subject_BR2data(reoutcome,8)% choose left
                subject_data(length(subject_data(:,1)),5)=0;
            elseif subject_BR2data(reoutcome,8)==0
                subject_data(length(subject_data(:,1)),5)=1;
                
            end
            
            
        elseif ismember(subject_BR2data(reoutcome,6),MV_10)%%%%%%%%%%%%%%%%%%%% MV_10
            if   ismember(subject_BR2data(reoutcome,7),LV_90)
                
                subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);
                subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);
                subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);
                subject_data(length(subject_data(:,1)),4)=2; % pair type
                if subject_BR2data(reoutcome,8)% choose left
                    subject_data(length(subject_data(:,1)),5)=0;
                elseif subject_BR2data(reoutcome,8)==0
                    subject_data(length(subject_data(:,1)),5)=1;
                    
                end
            elseif   ismember(subject_BR2data(reoutcome,7),LV_50)
                
                subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);
                subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);
                subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);
                subject_data(length(subject_data(:,1)),4)=6; % pair type
                if subject_BR2data(reoutcome,8)% choose left
                    subject_data(length(subject_data(:,1)),5)=0;
                elseif subject_BR2data(reoutcome,8)==0
                    subject_data(length(subject_data(:,1)),5)=1;
                    
                end
            end
            
            
        elseif ismember(subject_BR2data(reoutcome,6),HV_50)%%%%%%%%%%%%%%%%%%%% HV_50
            if   ismember(subject_BR2data(reoutcome,7),LV_90)
                subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);
                subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);
                subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);
                subject_data(length(subject_data(:,1)),4)=3; % pair type
                if subject_BR2data(reoutcome,8)% choose left
                    subject_data(length(subject_data(:,1)),5)=0;
                elseif subject_BR2data(reoutcome,8)==0
                    subject_data(length(subject_data(:,1)),5)=1;
                    
                end
                
            elseif   ismember(subject_BR2data(reoutcome,7),MV_90)
                
                subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);
                subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);
                subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);
                subject_data(length(subject_data(:,1)),4)=8; % pair type
                if subject_BR2data(reoutcome,8)% choose left
                    subject_data(length(subject_data(:,1)),5)=0;
                elseif subject_BR2data(reoutcome,8)==0
                    subject_data(length(subject_data(:,1)),5)=1;
                    
                end
            end
            
        elseif ismember(subject_BR2data(reoutcome,6),HV_10)%%%%%%%%%%%%%%%%%%%% HV_10
            if   ismember(subject_BR2data(reoutcome,7),LV_90)
                subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);
                subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);
                subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);
                subject_data(length(subject_data(:,1)),4)=4; % pair type
                if subject_BR2data(reoutcome,8)% choose left
                    subject_data(length(subject_data(:,1)),5)=0;
                elseif subject_BR2data(reoutcome,8)==0
                    subject_data(length(subject_data(:,1)),5)=1;
                    
                end
                
            elseif   ismember(subject_BR2data(reoutcome,7),MV_90)
                
                subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);
                subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);
                subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);
                subject_data(length(subject_data(:,1)),4)=7; % pair type
                if subject_BR2data(reoutcome,8)% choose left
                    subject_data(length(subject_data(:,1)),5)=0;
                elseif subject_BR2data(reoutcome,8)==0
                    subject_data(length(subject_data(:,1)),5)=1;
                    
                end
            elseif   ismember(subject_BR2data(reoutcome,7),LV_50)
                
                subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);
                subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);
                subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);
                subject_data(length(subject_data(:,1)),4)=6; % pair type
                if subject_BR2data(reoutcome,8)% choose left
                    subject_data(length(subject_data(:,1)),5)=0;
                elseif subject_BR2data(reoutcome,8)==0
                    subject_data(length(subject_data(:,1)),5)=1;
                    
                end
            elseif   ismember(subject_BR2data(reoutcome,7),MV_50)
                
                subject_data(length(subject_data(:,1))+1,1)=subject_BR2data(reoutcome,6);
                subject_data(length(subject_data(:,1)),2)=subject_BR2data(reoutcome,7);
                subject_data(length(subject_data(:,1)),3)=subject_BR2data(reoutcome,8);
                subject_data(length(subject_data(:,1)),4)=9; % pair type
                if subject_BR2data(reoutcome,8)% choose left
                    subject_data(length(subject_data(:,1)),5)=0;
                elseif subject_BR2data(reoutcome,8)==0
                    subject_data(length(subject_data(:,1)),5)=1;
                    
                end
                
                
            end
            
            
        end
        
    end
end
 
subject_data(1,:)=[]; %%DELET FIRST ROW OF 000

