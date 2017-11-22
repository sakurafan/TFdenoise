function [x,y,z]=get_subcube_index(DataCube,subcube_size,overlap_pixel,i,j,k)

if(any(overlap_pixel>subcube_size))
    error('get_subcube_index:tooLargeOverlap','重叠间距过远。'); 
end

[m,n,p]=size(DataCube);
if(any(subcube_size>[m,n,p]))
    error('get_subcube_index:tooLargeSubcube','子立方体块过大。'); 
end
mm=ceil((m-subcube_size(1))/overlap_pixel)+1;
nn=ceil((n-subcube_size(2))/overlap_pixel)+1;
pp=ceil((p-subcube_size(3))/overlap_pixel)+1;
if(any([i,j,k]>[mm,nn,pp]))
    error('get_subcube_index:indexOutOfRange','子立方体下标越界。'); 
end

xStart=min((i-1)*overlap_pixel+1,m-subcube_size(1)+1);
x=xStart:xStart+subcube_size(1)-1;
yStart=min((j-1)*overlap_pixel+1,n-subcube_size(2)+1);
y=yStart:yStart+subcube_size(2)-1;
zStart=min((k-1)*overlap_pixel+1,p-subcube_size(3)+1);
z=zStart:zStart+subcube_size(3)-1;

