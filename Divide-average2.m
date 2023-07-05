% 임의의 양수 a의 제곱근 (x) 을 구하는 방법인 “divide and average” 법은 아래 공식을 활용한다.
%       x = (x + a/x) / 2
% while...break 문을 이용하여 이 알고리즘을 구현하는 M-file function을 작성하라. 
% 작성된 코드가 명확하게 보일 수 있도록 들여 쓰기(indentation)를 적절히 활용하라.
% while 문의 반복 계산 과정에서 근사오차가 지정된 값(e_s) 이하가 되면 반복 계산을 멈춰라.
% 작성된 함수는 계산된 근사값과 오차를 반환해야 한다.
% 작성된 function가 제대로 동작하는지를 평가하기 위해 a = 0, 2, 10인 경우의 결과를 구하라. 
% 이때 e_s는 1×10^(-4)로 지정하라.
% 사실, 이 방법은 0이나 음수의 제곱근을 구할 수 없다. 
% a가 0 또는 음수일 때에도 제곱근을 구할 수 있도록 작성된 function을 수정해 봐라.

clc, clear;

%%% parameter 설정
e_s   = 1.0 * 10^(-4); % tolerance
maxit = 1000; % maximum number of iteration

%%% Evaulation 1 %%%
a = 0; % <--- 결과가 이상하게 나온다는 사실을 확인하세요!!!
[sqrtvalue1, appr_error, iter] = divNavgPos(a, e_s, maxit);
fprintf('Evaluation 1 (a = %f) : approximate sqrt root = %f, relative error = %e, iternation = %d\n', a, sqrtvalue1, appr_error, iter);

%%% Evaulation 2 %%%
a = 2;
[sqrtvalue1, appr_error, iter] = divNavgPos(a, e_s, maxit);
fprintf('Evaluation 2 (a = %f) : approximate sqrt root = %f, relative error = %e, iternation = %d\n', a, sqrtvalue1, appr_error, iter);

%%% Evaulation 3 %%%
a = 10;
[sqrtvalue1, appr_error, iter] = divNavgPos(a, e_s, maxit);
fprintf('Evaluation 3 (a = %f) : approximate sqrt root = %f, relative error = %e, iternation = %d\n', a, sqrtvalue1, appr_error, iter);

%%% Evaulation 4 (zero) %%%
a = 0;
[sqrtvalue, appr_error, iter] = divNavgAll(a, e_s, maxit);
fprintf('Evaluation 4 (a = %e) : approximate sqrt root = %f+%fi, relative error = %e, iternation = %d\n', a, real(sqrtvalue), imag(sqrtvalue), appr_error, iter);

%%% Evaulation 5 (nearly zero) %%%
a = 1 * 10^-10;
[sqrtvalue, appr_error, iter] = divNavgAll(a, e_s, maxit);
fprintf('Evaluation 5 (a = %e) : approximate sqrt root = %f+%fi, relative error = %e, iternation = %d\n', a, real(sqrtvalue), imag(sqrtvalue), appr_error, iter);

%%% Evaulation 6 (negative a) %%%
a = -4;
[sqrtvalue, appr_error, iter] = divNavgAll(a, e_s, maxit);
fprintf('Evaluation 6 (a = %e) : approximate sqrt root = %f+%fi, relative error = %e, iternation = %d\n', a, real(sqrtvalue), imag(sqrtvalue), appr_error, iter);

fprintf('실행 종료\n');

function [sqrtval, error, iter] = divNavgPos(a, e_s, maxit)
    % The divide and average method, an old-time method for approximating the square root of any positive number a,
    % input
    %   a : any positive number
    %   e_s : tolerance
    %   maxit : maximum no. of iteration
    % ouput
    %   sqrtval : approximate value of square root
    %   error : approximate relative error
    %   iter : number of iteration
    
    iter = 1;
    x0 = 1; % initial guess
    
    x = (x0 + a / x0) / 2;
    error = abs( (x - x0) / x );
    
    while (1)
        x0 = x;
        iter = iter + 1;
        x = (x0 + a / x0) / 2;
        error = abs( (x - x0) / x );
        if error <= e_s || iter > maxit
            break;
        end
    end
    
    sqrtval = x;
end

function [sqrtval, error, iter] = divNavgAll(a, e_s, maxit)
    % The divide and average method, an old-time method for approximating the square root of any positive number a,
    % input
    %   a : any number
    %   e_s : tolerance
    %   maxit : maximum no. of iteration
    % ouput
    %   sqrtval : approximate value of square root
    %   error : approximate relative error
    %   iter : number of iteration
    
    iter = 1;
    bPositive = true;

    if a < 0
        a = -a;
        bPositive = false;
    elseif a == 0
        sqrtval = 0;
        error = 0;
        return
    end
    
    x0 = 1; % initial guess
    x = (x0 + a / x0) / 2;
    error = abs( (x - x0) / x );
    
    while (1)
        x0 = x;
        iter = iter + 1;
        x = (x0 + a / x0) / 2;
        error = abs( (x - x0) / x );
        if error <= e_s || iter > maxit
            break;
        end
    end
    
    if bPositive == true
        sqrtval = x;
    else 
        sqrtval = complex(0, x);
    end
end
