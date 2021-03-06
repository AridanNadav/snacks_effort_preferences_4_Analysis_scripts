% BDM1_histogram 
current_fig=figure;
        BDM1_data = sub_array.BDM1{:,'Bid'};
        hist(BDM1_data,20);
        title(['BDM: Subject # ' sub_name]);
        xlabel('Bid');
        ylabel('Frequency');
    
        savefig([singleSUB_result_folder '/' sub_name '_BDM1_histogram'])
        saveas(current_fig,[singleSUB_result_folder '/' sub_name '_BDM1_histogram.jpg'])
    
        low=0;
        for snack=1:60 
            if BDM1_data(snack)<1;
             low=low+1;
            end
        end
    
        if low > 40
        fprintf(2,'There are %d low items, this is more than 40, concider excluding subject %s \n',low,sub_name);
        else
       fprintf('There are %d low items, this is less than 40, no need to exclude subject %s \n',low,sub_name);
        end
 
        
        
