%% probe_from_BR
logs=dir([pwd '/EVA3_' sub_name '_binary_ranking_2_*.txt' ]) ;
fid=fopen([pwd '/' logs.name]);
    Data=textscan(fid, '%s%f%f%s%s%f%f%s%f%f' , 'HeaderLines', 1);     %read in probe output file into P ;
    
    % Convert all string variables into numbers
    Data{1}(:)={ALLsubjects(subjectIndex)}; %subject's code
    
    
    % convert stimuli names into numbers
    image_ending=Data{4}{1}(find(Data{4}{1}=='.'):end);
    [~,stimuls_name_is_numeric] = str2num(Data{4}{1}(1:end-length(image_ending)));
    % if the stimuli have numeric name, remove the '.xxx' ending
    if stimuls_name_is_numeric
        for i=1:length(Data{1})
            Data{4}{i}=str2num(Data{4}{i}(1:end-length(image_ending))); % left stimulus
            Data{5}{i}=str2num(Data{5}{i}(1:end-length(image_ending))); % right stimulus
        end
        
        % if the stimuli do not have numeric names, replace the columns with 0's
    else
        Data{4}={zeros(length(Data{4}),1)}; % left stimulus
        Data{5}={zeros(length(Data{5}),1)}; % right stimulus
    end
    
    Data{8}(strcmp(Data{8},'u'))={1}; % response: 1 for left
    Data{8}(strcmp(Data{8},'i'))={0}; % response: 0 for right
    Data{8}(strcmp(Data{8},'x'))={999}; % response: 99 for no response
    
    Data{1}=cell2mat(Data{1});
    Data{4}=cell2mat(Data{4});
    Data{5}=cell2mat(Data{5});
%         Data{10}=cell2mat(Data{10});
%     Data{11}=cell2mat(Data{11});

    Data{8}=cell2mat(Data{8});
    
    fclose(fid);
    
    subject_BR2data=cell2mat(Data);
    
    
    
    
    