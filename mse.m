function e=mse(a,b)
if(any(size(a)~=size(b)))
    error('size not match');
end
e=sum((a(:)- b(:)).^2) / numel(a);
