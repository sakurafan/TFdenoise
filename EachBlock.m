clear;
clc;

load DataCube_Gaussian_0.01.mat


[m,n,p]=size(DataCube);

% DataCube=reshape(mapstd(reshape(DataCube,[m*n,p])')',[m,n,p]);

% DataCube=DataCube(1:50,1:50,1:50);

subcube_size=[10,10,10];
%  subcube_size=[5,5,5];
overlap_pixel=1;

mm=ceil((m-subcube_size(1))/overlap_pixel)+1;
nn=ceil((n-subcube_size(2))/overlap_pixel)+1;
pp=ceil((p-subcube_size(3))/overlap_pixel)+1;

Denoiselevel=[5,5,5];
maxiters=100;
TotalNum=mm*nn*pp;
DataCubeOut=zeros(size(DataCube));
tStart=tic;
for i=1:mm
    for j=1:nn
        for k=1:pp
             [x,y,z]=get_subcube_index(DataCube,subcube_size,overlap_pixel,i,j,k);
             Block=DataCube(x,y,z);
             Block=tensor(Block);
             Fac=tucker_als(Block,Denoiselevel,'maxiters', maxiters);
             core=Fac.core;

             Final=ttm(core,{Fac.U{1},Fac.U{2},Fac.U{3}});
             FinalData=Final.data;
             DataCubeOut(x,y,z)=DataCubeOut(x,y,z)+FinalData;
             
             
        end
        fprintf('»•‘ÎÕÍ≥…%d,%d\n',i,j);
         toc(tStart);
    end
end

DataCubeOut=DataCubeOut./get_covering_subcube_count(DataCube,subcube_size,overlap_pixel);
save('DataCubeOutEach-10-5.mat','DataCubeOut');


