function D = diffmat2(n)

if n < 4
    error('please make n >= 4')
end

D = zeros(n,n);
% right difference for start point
rd = [2 -5 4 -1];
% left difference for end point
ld = [-1 4 -5 2];
% center difference
cd = [1 -2 1];

D(1,1:4) = rd;
D(n,n-3:n) = ld;

% filling in the centered difference for D
for i=1:n-2
    D(i+1,i:i+2) = cd;
end



