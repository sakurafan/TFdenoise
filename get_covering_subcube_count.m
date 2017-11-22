function countDataCube=get_covering_subcube_count(DataCube,subcube_size,overlap_pixel)
[m,n,p]=size(DataCube);
mm=ceil((m-subcube_size(1))/overlap_pixel)+1;
nn=ceil((n-subcube_size(2))/overlap_pixel)+1;
pp=ceil((p-subcube_size(3))/overlap_pixel)+1;
countDataCube=zeros(m,n,p);
for i=1:mm
    for j=1:nn
        for k=1:pp
            [x_rg,y_rg,z_rg]=get_subcube_index(DataCube,subcube_size,overlap_pixel,i,j,k);
            countDataCube(x_rg,y_rg,z_rg)=countDataCube(x_rg,y_rg,z_rg)+1;
        end
    end
end