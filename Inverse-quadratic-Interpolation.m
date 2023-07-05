%   강의 교안 20~23쪽에 나와 있는 inverse quadratic interpolation 방법으로
%   방정식의 해를 구하는 m code를 작성하라. 
%   작성된 m code가 올바르게 동작하는 지를 확인하기 위해, 다음 함수의 해를 구하라. 
%   해를 구할 때, 초기치는 x1 = 4, x2 = 4.5, x3 = 5.0으로 설정하고 허용 
%   오차(stopping criterion, es)는 10^-4 (%)로 설정한다. 
%       f(x) = x^2 - sin( x ) = 0;
%   초기치를 x1 = 4.0, x2 = 5.0, x3 = 4.5 로 설정한 후 함수의 해를 구하라. 

% mathematical function
fn2 = @(x) x^2 - 4 * sin(x);

% initial guesses for invers quadratice interpolation
x1 = 4;
x2 = 4.5;
x3 = 5;

[sol, err, iter] = InvQuadInterpol( fn2, x1, x2, x3, es );
% printing results
fprintf( 'nsolution (x1=%f, x2=%f, x3=%f): %f\n', x1, x2, x3, sol );
fprintf( 'percent relative error: %e\n', err );
fprintf( 'no of iteration: %d\n', iter );

% initial guesses for invers quadratice interpolation
x1new = 4;
x2new = 5;
x3new = 4.5;

[sol, err, iter] = InvQuadInterpol( fn2, x1new, x2new, x3new, es );
% printing results
fprintf( '\nsolution (x1=%f, x2=%f, x3=%f): %f\n', x1new, x2new, x3new, sol );
fprintf( 'percent relative error: %e\n', err );
fprintf( 'no of iteration: %d\n', iter );


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [sol, err, iter] = InvQuadInterpol( fn, x1, x2, x3, es )
    % InvQuadInterpol: finding a root of a given equation
    %   [sol, err, iter] = InvQuadInterpol( fn, x1, x2, x3, es )
    %
    % Inputs
    %   fn: equation -- passed function
    %   x1, x2, x3: initial searching range
    %   es: stopping criterion
    % Outputs
    %   sol: root
    %   err: the percent relative error
    %   iter: number of iteration

    maxit = 100;
    er = 100;
    iter = 0;
    
    f1 = fn( x1 );
    f2 = fn( x2 );
    f3 = fn( x3 );
    
    while ( 1 )
        sol = f2 * f3 * x1 / ((f1 - f2) * (f1 - f3)) + ...
                f1 * f3 * x2 / ((f2 - f1) * (f2 - f3)) + ...
                f1 * f2 * x3 / ((f3 - f1) * (f3 - f2));
        iter = iter + 1;
        if sol ~= 0
            err = abs( (sol - x3) / sol ) * 100;
        end
        
        if err < es || iter >= maxit, break;
        else
            x1 = x2;
            x2 = x3;
            x3 = sol;
            f1 = f2;
            f2 = f3;
            f3 = fn( x3 );
        end
    end    
end
