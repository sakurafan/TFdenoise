function label=subcube_kmeans(DataCube,subcube_size,overlap_pixel,classNum,maxItr)
if (nargin<5)
    maxItr=100;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n\n聚类开始\n');
tStart=tic;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[m,n,p]=size(DataCube);
mm=ceil((m-subcube_size(1))/overlap_pixel)+1;
nn=ceil((n-subcube_size(2))/overlap_pixel)+1;
pp=ceil((p-subcube_size(3))/overlap_pixel)+1;
subcubeLength=subcube_size(1)*subcube_size(2)*subcube_size(3);
if(classNum>mm*nn*pp)
   error('subcube_kmeans:tooManyClusters','聚类数过多。'); 
end
%%初始化中心点
centers=zeros([subcubeLength,classNum]);

initial_idx=randsample(mm*nn*pp,classNum);
[xx,yy,zz]=ind2sub([mm,nn,pp],initial_idx);

for i=1:classNum
    [x_rg,y_rg,z_rg]=get_subcube_index(DataCube,subcube_size,overlap_pixel,xx(i),yy(i),zz(i));
    temp=DataCube(x_rg,y_rg,z_rg);
    centers(:,i)=temp(:);
end
fprintf('初始化结束');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
label=ones(mm,nn,pp);
distance=zeros(1,classNum);
itrCount=0;
last=0;
while( any(label~=last) )
    last=label;    
     start=tic; 
    for ii=1:mm
        for jj=1:nn
            for kk=1:pp
                [x_rg,y_rg,z_rg]=get_subcube_index(DataCube,subcube_size,overlap_pixel,ii,jj,kk);
                temp=DataCube(x_rg,y_rg,z_rg);
                
                %%得到距离最小的K下标
%                 [~,label(ii,jj,kk)]=min(dist(temp(:)',centers),[],2);
               
                for class=1:classNum
                    for num=1:subcubeLength
                        distance(class)=distance(class)+(temp(num)-centers(num,class))*(temp(num)-centers(num,class));

                    end
                end
                [~,label(ii,jj,kk)]=min(distance);
                toc(start);
%                 label(ii,jj,kk)=ceil(rand()*k);
            end
            
        end
    end
    fprintf('一次聚类结束');
    %均值
    for i=1:classNum
        [xx,yy,zz]=ind2sub([mm,nn,pp],find(label(:)==i));
        %%当某一类为空类，随机生成一个新类
        if(isempty(xx))
            random_idx=randsample(mm*nn*pp,1);
            [xx,yy,zz]=ind2sub([mm,nn,pp],random_idx);
            [x_rg,y_rg,z_rg]=get_subcube_index(DataCube,subcube_size,overlap_pixel,xx,yy,zz);
            temp=DataCube(x_rg,y_rg,z_rg);
            centers(:,i)=temp(:);
        else
            sum_cube=zeros(subcube_size(1)*subcube_size(2)*subcube_size(3),1);
            for ii=1:length(xx)
                [x_rg,y_rg,z_rg]=get_subcube_index(DataCube,subcube_size,overlap_pixel,xx(ii),yy(ii),zz(ii));
                temp=DataCube(x_rg,y_rg,z_rg);
                sum_cube=sum_cube+temp(:);
            end
            centers(:,i)=sum_cube/length(xx);
        end    
    end
    itrCount=itrCount+1;
    fprintf('k-means第%d次迭代\n',itrCount);
    toc(tStart);
    if (itrCount>=maxItr)
        warning('stats:subcube_kmeans:FailedToConverge','%d次迭代后未达到收敛。',maxItr);
        break;
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('\n聚类完成\n');
toc(tStart);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function D=dist(X,Y)
% D = sqrt(bsxfun(@plus,dot(X,X,2),dot(Y,Y,1))-2*(X*Y));
D = bsxfun(@plus,dot(X,X,2),dot(Y,Y,1))-2*(X*Y); %欧氏距离平方

