% 함수 : y = x^2 - 1
%

% 방법 1
i = 0;
for t = 0 : 0.2 : 5
    i = i + 1;
    x1(i) = t;
    y1(i) = x1(i)^2 - 1;
end

figure( 1 )
plot( x1', y1', 'o-g');
xlabel( 'x' ); ylabel( 'y' );

% 방법 2
x2 = [0 : 0.2 : 5]';

for i = 1 : length(x2)
    y2(i) = x2(i)^2 - 1;
end

figure( 2 )
plot( x2', y2', 'o-k');
xlabel( 'x' ); ylabel( 'y' );

% 방법 3 -- vectorization
x3 = [0 : 0.2 : 5]'; % transpose --> column vector 생성
y3 = x3.^2 - 1;

figure( 3 )
plot( x3, y3, 'd-r' );
xlabel( 'x' ); ylabel( 'y' );

% 방법 4 -- function 활용
funcy = @(x) x.^2 - 1; % 익명 함수

x4 = [0 : 0.2 : 5]'; % transpose --> column vector 생성
y4 = funcy( x4 );

figure( 4 )
plot( x4, y4, '^-b' );
xlabel( 'x' ); ylabel( 'y' );
