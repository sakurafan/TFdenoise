function DenoisedBlock=TensorDenoise(TensorBlock,subcube_size,Denoiselevel)

    if (length(Denoiselevel)~=4 && length(Denoiselevel)~=1 )
        error('降秩参数有误！');
    end
    
    cubelength=subcube_size(1)*subcube_size(2)*subcube_size(3);
    num=size(TensorBlock,2);
    
    if(length(Denoiselevel)==1)
        temp=Denoiselevel;
        
        Denoiselevel=[ceil(subcube_size(1)/temp),ceil(subcube_size(2)/temp),ceil(subcube_size(3)/temp),ceil(num/temp)];
    else
        Denoiselevel=[ceil(subcube_size(1)/Denoiselevel(1)),ceil(subcube_size(2)/Denoiselevel(2)),ceil(subcube_size(3)/Denoiselevel(3)),ceil(num/Denoiselevel(4))];
    end
    
    
    %三阶张量
    maxiters=50;
    if(num==1)
%         Denoiselevel=[Denoiselevel(1),Denoiselevel(2),Denoiselevel(3)];
        Denoiselevel=[5,5,5];
        TensorBlock=reshape(TensorBlock,subcube_size);
        TensorBlock=tensor(TensorBlock);
        Fac=tucker_als(TensorBlock,Denoiselevel,'maxiters', maxiters);
       
        core=Fac.core;

        Final=ttm(core,{Fac.U{1},Fac.U{2},Fac.U{3}});

      
    else
        if(num<60)
            Denoiselevel=[5,5,5,ceil(num/2)];
        else
            Denoiselevel=[5,5,5,ceil(num/2)];
        end
        
        TensorBlock=reshape(TensorBlock,[subcube_size,num]);
        TensorBlock=tensor(TensorBlock);
        Fac=tucker_als(TensorBlock,Denoiselevel,'maxiters', maxiters);
       
        core=Fac.core;

        Final=ttm(core,{Fac.U{1},Fac.U{2},Fac.U{3},Fac.U{4}});
    end
        FinalData=Final.data;
        DenoisedBlock=reshape(FinalData,[cubelength,num]);
   
        



    


