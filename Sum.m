% 정수 1부터 10까지를 덧셈하여 그 결과를 화면에 출력
%

% 방법 1 -- for 문 활용
sum1 = 0;
for i1 = 1 : 10
    sum1 = sum1 + i1;
end

disp ('방법 1: '), disp( sum1 );

% 방법 2
i2 = 1 : 10;
%sum2 = sum( i2 );
disp ('방법 2: '), disp( sum( i2 ) );

% 방법 3 -- function 활용
N2 = input('덧셈할 최대 정수를 입력하세요 = ');
sum3 = IntegerSum(1, N2);
fprintf( '방법 3: summation = %d\n', sum3 );

function result = IntegerSum( N1, N2 )
    i = N1 : 1 : N2;
    result = sum( i );
end
