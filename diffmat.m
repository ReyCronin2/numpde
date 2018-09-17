function D = diffmat(n)

if n < 3
    error('please make n >= 3')
end

D = zeros(n,n);
% right difference for start point
rd = [-3 4 -1];
% left difference for end point
ld = [1 -4 3];
% center difference
cd = [-1 0 1];

D(1,1:3) = rd;
D(n,n-2:n) = ld;

% filling in the centered difference for D
for i=1:n-2
    D(i+1,i:i+2) = cd;
end



