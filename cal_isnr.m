clear;
clc;

load('DataCube.mat','DataCube');
DataCube_clear=DataCube;
clear('DataCube');

load('DataCube_Gaussian_0.01.mat','DataCube');
DataCube_noised=DataCube;
clear('DataCube');

load('DataCubeOut-C++88860.mat','DataCubeOut');


isnr_val=isnr(DataCube_clear,DataCube_noised,DataCubeOut);
fprintf('ISNR:\t%.2f\n',isnr_val);
