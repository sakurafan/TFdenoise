function [subcubes,xx,yy,zz]=get_subcubes_in_cluster(DataCube,subcube_size,overlap_pixel,label,cluster_index)
 [xx,yy,zz]=ind2sub(size(label),find(label(:)==cluster_index));
 subcubes=zeros(subcube_size(1)*subcube_size(2)*subcube_size(3),length(xx));
 for i=1:length(xx)
     [x_rg,y_rg,z_rg]=get_subcube_index(DataCube,subcube_size,overlap_pixel,xx(i),yy(i),zz(i));
     temp=DataCube(x_rg,y_rg,z_rg);
     subcubes(:,i)=temp(:);
 end
 



