function DataCubeOut=datacube_denoise(DataCube,subcube_size,overlap_pixel,classNum,denoise_func,varargin)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if(exist('label151515.mat'))
%     load('clustering_label.mat','label');
%        load('labelC++999.mat','label');
% else
%     label=down_subcube_kmeans(DataCube,subcube_size,overlap_pixel,classNum);
%      label=subcube_kmeans(DataCube,subcube_size,overlap_pixel,classNum);
%     save('label151515.mat','label');
% end
%     [m,n,p]=size(DataCube);
%     LargeCubeSize=[m,n,p];
   
%     subcube_kmeansCWithout(DataCube,label,LargeCubeSize,subcube_size,overlap_pixel,classNum);
%           save('labelC++555test.mat','label');
%           load('labelC++555test.mat','label');
load clustering_label555.mat

fprintf('\n\n去噪开始\n');
tStart=tic;
% [m,n,p]=size(DataCube);
% mm=ceil((m-subcube_size(1))/overlap_pixel)+1;
% nn=ceil((n-subcube_size(2))/overlap_pixel)+1;
% pp=ceil((p-subcube_size(3))/overlap_pixel)+1;
% complete=0;
% label=zeros(mm,nn,pp);
% for i=1:mm
%     for j=1:nn
%         for k=1:pp
%             label(i,j,k)=ceil(rand()*classNum);
%         end
%     end
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DataCubeOut=zeros(size(DataCube));
% DataCubeOut=denoise_func(DataCube,varargin{:});
% 
for cluster_index=1:classNum
    [subcubes_in_cluster,xx,yy,zz]=get_subcubes_in_cluster(DataCube,subcube_size,overlap_pixel,label,cluster_index);
    if(isempty(subcubes_in_cluster))
        continue;
    end
    
     subcubes_out=denoise_func(subcubes_in_cluster,varargin{:});  % denoise_func 为对每类中立方体块去噪的函数句柄
     toc(tStart);
    for ii=1:size(subcubes_out,2)
         [x_rg,y_rg,z_rg]=get_subcube_index(DataCube,subcube_size,overlap_pixel,xx(ii),yy(ii),zz(ii));
         DataCubeOut(x_rg,y_rg,z_rg)=DataCubeOut(x_rg,y_rg,z_rg)+reshape(subcubes_out(:,ii),subcube_size);
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    complete=complete + size(subcubes_out,2);
    fprintf('去噪完成%.2f%%\n',complete/(mm*nn*pp)*100);
    toc(tStart);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
end
DataCubeOut=DataCubeOut./get_covering_subcube_count(DataCube,subcube_size,overlap_pixel);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n去噪完成\n');
toc(tStart);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
