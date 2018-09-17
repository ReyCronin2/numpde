clear
close all
%function derive(der, x)

iter=1:5;

h=zeros(1,length(iter));
error_norm_d1=h;
error_norm_d2=h;


for i=iter

h(1,i)=1/i;
    
x=2:1/i:10; 
%x(5)=[];
n=length(x);
der=1;

u=x.^3;
u1=3*x.^2;
u2=6*x; %second derivative

% u=log(x);
% u1=1./x;
% u2=-1./x.^2;

% u=exp(x);
% u1=exp(x);
% u2 = exp(x);

u=u';

% x should be a vector of points from your grid
% der is a choice between first and second derivative

if( der ~= 1 && der ~= 2 )
    error('only first or second derivative are evaluted')
end

deltax = zeros(n,1);
deltax2 = zeros(n,1);

% first derivative
if der == 1
    D = diffmat(n);
    deltax(1) = x(3) - x(1); % right difference
    deltax(2:n-1) = x(3:n) - x(1:n-2); % centered difference
    deltax(n) = x(n) - x(n-2); % left difference    
    % for the first derivative, it should be 2h
end

der2 = 2;
% second derivative
if der2 == 2
    D2 = diffmat2(n);
    deltax2(1) = ((x(4) - x(1))./3).^2; % right difference
    deltax2(2:n-1) = ((x(3:n) - x(1:n-2))./2).^2; % centered difference
    deltax2(n) = ((x(n) - x(n-3))./3).^2; % left difference

end


A = D(1:n,:) ./ deltax(1:n,1);
F = A*u;

A2 = D2(1:n,:) ./ deltax2(1:n,1);
F2 = A2*u;

error_d1=abs(F'-u1);
error_norm_d1(1,i) = norm(error_d1,Inf);

error_d2=abs(F2' - u2);
error_norm_d2(1,i) = norm(error_d2,Inf);




end

clf
figure(1)
plot(x,u1,'k')
hold on
plot(x,F','.r','MarkerSize',10)
title('first derivative');
xlabel('x')
ylabel('du/dx')
legend('actual', 'computed','Location','SouthWest')


figure(2)
plot(x,u2,'k')
hold on
plot(x,F2','.r','MarkerSize',10)
title('second derivative');
xlabel('x')
ylabel('d^2u/dx^2')
legend('actual', 'computed','Location','SouthWest')

% 

figure(3)
for i=iter
loglog(h,error_norm_d1,'.b','MarkerSize',20)
hold on
loglog(h,error_norm_d2,'.k','MarkerSize',20)
hold on
loglog(h,h.^2,'r')
hold on
loglog(h,h,'g')
ylabel('norm derivative error')
xlabel('resolution h')
legend('1st der','2nd der','h^2','h', 'Location','SouthEast');

end













