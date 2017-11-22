clear;
clc;

load('DataCube.mat','DataCube');
DataCube_clear=DataCube;
clear('DataCube');

load('DataCube_Gaussian_0.01.mat','DataCube');
DataCube_noised=DataCube;
clear('DataCube');

load('DataCubeOut.mat','DataCubeOut');

mse_val=mse(DataCube_clear,DataCubeOut);
fprintf('MSE:\t%.8f\n',mse_val);
