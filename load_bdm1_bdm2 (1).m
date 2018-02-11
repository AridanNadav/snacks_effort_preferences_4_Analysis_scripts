% load_bdm1_bdm2
for bdm=1:2
    BDM=num2str(bdm);
%     filename = [pwd '/EVA3_' sub_name '_BDM' BDM '.txt'];
    filename = [pwd '/EVA4_' sub_name '_BDM' BDM '.txt'];

    delimiter = '\t';
    startRow = 2;
    formatSpec = '%f%s%f%f%[^\n\r]';
    fileID = fopen(filename,'r');
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines' ,startRow-1, 'ReturnOnError', false);
    fclose(fileID);
    sub_tableLdBDM = table(dataArray{1:end-1}, 'VariableNames', {'Trial','StimName','Bid','RT'});
    clearvars filename delimiter startRow formatSpec fileID dataArray ans;
    sub_tableLdBDM=sortrows(sub_tableLdBDM,2);
    sub_array.(['BDM' BDM])=sub_tableLdBDM;
end


