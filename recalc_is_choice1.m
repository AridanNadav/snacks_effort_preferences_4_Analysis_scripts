%recalc_is_choice1
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

% 
% for reoutcome=1:length(subject_data(:,15))
%     
%     if     subject_data(reoutcome,14)==1 &&  (ismember(subject_data(reoutcome,10),HV_90)==1 && subject_data(reoutcome,13)==1)||(ismember(subject_data(reoutcome,10),HV_90)==0 && subject_data(reoutcome,13)==0)
%         subject_data(reoutcome,15)=1;
%     elseif subject_data(reoutcome,14)==2 &&  (ismember(subject_data(reoutcome,10),HV_90)==1 && subject_data(reoutcome,13)==1)||(ismember(subject_data(reoutcome,10),HV_90)==0 && subject_data(reoutcome,13)==0)
%         subject_data(reoutcome,15)=1;
%     elseif subject_data(reoutcome,14)==3 &&  (ismember(subject_data(reoutcome,10),HV_50)==1 && subject_data(reoutcome,13)==1)||(ismember(subject_data(reoutcome,10),HV_50)==0 && subject_data(reoutcome,13)==0)
%         subject_data(reoutcome,15)=1;
%     elseif subject_data(reoutcome,14)==4 &&  (ismember(subject_data(reoutcome,10),MV_90)==1 && subject_data(reoutcome,13)==1)||(ismember(subject_data(reoutcome,10),MV_90)==0 && subject_data(reoutcome,13)==0)
%         subject_data(reoutcome,15)=1;
%     elseif subject_data(reoutcome,14)==5 &&  (ismember(subject_data(reoutcome,10),MV_90)==1 && subject_data(reoutcome,13)==1)||(ismember(subject_data(reoutcome,10),MV_90)==0 && subject_data(reoutcome,13)==0)
%         subject_data(reoutcome,15)=1;
%     elseif subject_data(reoutcome,14)==6 &&  (ismember(subject_data(reoutcome,10),MV_50)==1 && subject_data(reoutcome,13)==1)||(ismember(subject_data(reoutcome,10),MV_50)==0 && subject_data(reoutcome,13)==0)
%         subject_data(reoutcome,15)=1;
%     elseif subject_data(reoutcome,14)==7 &&  (ismember(subject_data(reoutcome,10),LV_90)==1 && subject_data(reoutcome,13)==1)|| (ismember(subject_data(reoutcome,10),LV_90)==0 && subject_data(reoutcome,13)==0)
%         subject_data(reoutcome,15)=1;
%     elseif subject_data(reoutcome,14)==8 &&  (ismember(subject_data(reoutcome,10),LV_90)==1 && subject_data(reoutcome,13)==1)||(ismember(subject_data(reoutcome,10),LV_90)==0 && subject_data(reoutcome,13)==0)
%         subject_data(reoutcome,15)=1;
%     elseif subject_data(reoutcome,14)==9 &&  (ismember(subject_data(reoutcome,10),LV_50)==1 && subject_data(reoutcome,13)==1)||(ismember(subject_data(reoutcome,10),LV_50)==0 && subject_data(reoutcome,13)==0)
%         subject_data(reoutcome,15)=1;
%     else
%         subject_data(reoutcome,15)=0;
%         
%         
%     end
% end

for reoutcome=1:length(subject_data(:,15))
    switch subject_data(reoutcome,14)
        
        case 1
            if (ismember(subject_data(reoutcome,10),HV_90)==1 && subject_data(reoutcome,13)==1)
                subject_data(reoutcome,15)=1;
            elseif (ismember(subject_data(reoutcome,10),HV_90)==0 && subject_data(reoutcome,13)==0)
                subject_data(reoutcome,15)=1;
                
            else
                subject_data(reoutcome,15)=0;
            end
            
        case  2
            if  (ismember(subject_data(reoutcome,10),HV_90)==1 && subject_data(reoutcome,13)==1)
                subject_data(reoutcome,15)=1;
                
            elseif (ismember(subject_data(reoutcome,10),HV_90)==0 && subject_data(reoutcome,13)==0)
                subject_data(reoutcome,15)=1;
                
            else
                subject_data(reoutcome,15)=0;
            end
            
            
        case  3
            if  (ismember(subject_data(reoutcome,10),HV_50)==1 && subject_data(reoutcome,13)==1)
                subject_data(reoutcome,15)=1;
                
            elseif (ismember(subject_data(reoutcome,10),HV_50)==0 && subject_data(reoutcome,13)==0)
                subject_data(reoutcome,15)=1;
                
            else
                subject_data(reoutcome,15)=0;
            end
            
        case  4
            if  (ismember(subject_data(reoutcome,10),MV_90)==1 && subject_data(reoutcome,13)==1)
                subject_data(reoutcome,15)=1;
                
            elseif (ismember(subject_data(reoutcome,10),MV_90)==0 && subject_data(reoutcome,13)==0)
                subject_data(reoutcome,15)=1;
                
            else
                subject_data(reoutcome,15)=0;
            end
            
        case  5
            if  (ismember(subject_data(reoutcome,10),MV_90)==1 && subject_data(reoutcome,13)==1)
                subject_data(reoutcome,15)=1;
                
            elseif (ismember(subject_data(reoutcome,10),MV_90)==0 && subject_data(reoutcome,13)==0)
                subject_data(reoutcome,15)=1;
                
            else
                subject_data(reoutcome,15)=0;
            end
            
        case  6
            if  (ismember(subject_data(reoutcome,10),MV_50)==1 && subject_data(reoutcome,13)==1)
                subject_data(reoutcome,15)=1;
                
            elseif (ismember(subject_data(reoutcome,10),MV_50)==0 && subject_data(reoutcome,13)==0)
                subject_data(reoutcome,15)=1;
                
            else 
                subject_data(reoutcome,15)=0;
            end
            
        case  7
            if  (ismember(subject_data(reoutcome,10),LV_90)==1 && subject_data(reoutcome,13)==1)
                subject_data(reoutcome,15)=1;
                
            elseif  (ismember(subject_data(reoutcome,10),LV_90)==0 && subject_data(reoutcome,13)==0)
                subject_data(reoutcome,15)=1;
                
            else
                subject_data(reoutcome,15)=0;
            end
            
        case  8
            if  (ismember(subject_data(reoutcome,10),LV_90)==1 && subject_data(reoutcome,13)==1)
                subject_data(reoutcome,15)=1;
                
            elseif (ismember(subject_data(reoutcome,10),LV_90)==0 && subject_data(reoutcome,13)==0)
                subject_data(reoutcome,15)=1;
                
            else
                subject_data(reoutcome,15)=0;
            end
            
        case  9
            if  (ismember(subject_data(reoutcome,10),LV_50)==1 && subject_data(reoutcome,13)==1)
                subject_data(reoutcome,15)=1;
                
            elseif (ismember(subject_data(reoutcome,10),LV_50)==0 && subject_data(reoutcome,13)==0)
                subject_data(reoutcome,15)=1;
                
            else
                subject_data(reoutcome,15)=0;
            end
            
    end
end

%% bidIndex to 1:27
import_roseta
for reoutcome=1:length(subject_data)
    
subject_data(reoutcome,19)=    find(roseta{:,order+4}==subject_data(reoutcome,10));
subject_data(reoutcome,20)=     find(roseta{:,order+4}==subject_data(reoutcome,11));
    
    
    
end