% pairtype2val_comp



for i=1:height(allsubTable)
    pairtype= allsubTable{i,'PairType'};
    switch pairtype
        case	1
            value(i)=1;
            compar(i)=1;
        case	2
            value(i)=1;
            compar(i)=2;
            
        case	3
            value(i)=1;
            compar(i)=3;
            
        case	4
            value(i)=2;
            compar(i)=1;
            
        case	5
            value(i)=2;
            compar(i)=2;
            
        case	6
            value(i)=2;
            compar(i)=3;
            
        case	7
            value(i)=3;
            compar(i)=1;
            
        case	8
            value(i)=3;
            compar(i)=2;
            
        case	9
            value(i)=3;
            compar(i)=3;
    end
end
valcomp=array2table ([value' compar' ], 'VariableNames',{'value','compar'});
