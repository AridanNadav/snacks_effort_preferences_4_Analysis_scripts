% probeBR1_type2ValEffort

for type2ValEffort=1:length (ALLSubData)
    type=ALLSubData(type2ValEffort,2)  ;
    switch type
        case 1
            ALLSubData(type2ValEffort,4)=1;
            ALLSubData(type2ValEffort,5)=1;
        case 2
            ALLSubData(type2ValEffort,4)=1;
            ALLSubData(type2ValEffort,5)=2;
        case 3
            ALLSubData(type2ValEffort,4)=1;
            ALLSubData(type2ValEffort,5)=3;
        case 4
            ALLSubData(type2ValEffort,4)=2;
            ALLSubData(type2ValEffort,5)=1;
        case 5
            ALLSubData(type2ValEffort,4)=2;
            ALLSubData(type2ValEffort,5)=2;
        case  6
            ALLSubData(type2ValEffort,4)=2;
            ALLSubData(type2ValEffort,5)=3;
        case 7
            ALLSubData(type2ValEffort,4)=3;
            ALLSubData(type2ValEffort,5)=1;
        case  8
            ALLSubData(type2ValEffort,4)=3;
            ALLSubData(type2ValEffort,5)=2;
        case   9
            ALLSubData(type2ValEffort,4)=3;
            ALLSubData(type2ValEffort,5)=3;
    end
end