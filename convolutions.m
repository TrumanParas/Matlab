function getNew = convolutions (n,m)

if n <= 3 || m <= 3
    error('Matrix not large enough')
end

mat = randi([0,3], n, m);
padMat = zeros(n+2, m+2);
padMat(2:n+1, 2:m+1) = mat;

kernal = randi([0,3], 3, 3);

for ii = 1:n
    for jj = 1:m
        getNew(ii,jj) = sum(sum(kernal.*padMat(ii:ii+2, jj:jj+2)));
    end
end
        
        
