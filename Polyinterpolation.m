%x = [-100:1:100];
%f = x.^2 - sin(x);
%plot(x,f)

f = @(x) x.^2 - sin(x);
x1 = 4;
x2 = 4.5;
x3 = 5.0;
k = 0;
while abs(x3-x2) > eps %abs = 절대값을 반환, eps = Floating point
    x = polyinterp([f(x1),f(x2),f(x3)],[x1,x2,x3],0);
    x1 = x2;
    x2 = x3;
    x3 = x;
    k = k+1;
end
fprintf('root : %1.4f\n',x1)
fprintf('iterationen: %d\n',k)
%function v = polyinterp(x,y,u)
%n = length(x);
%v = zeros(size(u));
%for k = 1:n
%    w = ones(size(u));
%    for j = [1:k-1 k+1:n]
%        w = (u-x(j))./(x(k)-x(j)).*w;
%    end
%    v = v+w*y(k);
%end
