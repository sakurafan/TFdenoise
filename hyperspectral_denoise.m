clear;
clc;

load DataCube_Gaussian_0.01.mat;

[m,n,p]=size(DataCube);

% DataCube=reshape(mapstd(reshape(DataCube,[m*n,p])')',[m,n,p]);

% DataCube=DataCube(1:50,1:50,1:50);

subcube_size=[5,5,5];
% subcube_size=[15,15,220];
overlap_pixel=1;

mm=ceil((m-subcube_size(1))/overlap_pixel)+1;
nn=ceil((n-subcube_size(2))/overlap_pixel)+1;
pp=ceil((p-subcube_size(3))/overlap_pixel)+1;

classNum=round(sqrt(mm*nn*pp));
% classNum=50;
% classNum=1;
Denoiselevel=[1,1,1,4];

% DataCubeOut=datacube_denoise(DataCube,subcube_size,overlap_pixel,k,@sparse_denoise,opts);
DataCubeOut=datacube_denoise(DataCube,subcube_size,overlap_pixel,classNum,@TensorDenoise,subcube_size,Denoiselevel);

save('Big2.5.mat','DataCubeOut');




