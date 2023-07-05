%   n차 다항식 함수의 모든 해를 구하는 m code를 작성하라. 
%   Code는 자동적으로 해가 존재하는 구간(들)을 찾아(탐색)내야 하며, 
%   해가 존재하는 구간(들)을 찾은 다음에는 Bisection method 또는 
%   false position method로 각각의 구간에 속한 해를 모두 구해야 한다. 
%   해가 존재하는 구간을 탐색(searching)하기 위해 초기 탐색 구간은 
%   -5에서 +5까지로 한다. 만일 해당 탐색 구간 내에 모든 해가 존재하지 
%   않는다면, 탐색 구간을 점차 확대하면서 해가 존재하는 모든 구간을 찾아야 한다. 
%   작성된 m code가 올바르게 동작하는 지를 확인하기 위해, 다음 다항식 함수의 
%   모든 해를 구하라. 방정식의 해를 구할 때, 허용 오차(stopping criterion, es)는 
%   10-4 (%)로 설정한다. 
%   mathematical function: f(x) = x^3 - 45 * x^2 - 264 * x + 1700 = 0

clc, clear, close all

% coefficient of polynomial: a_n * x^n + a_n-1 * x^(n-1) + ... + a_1 * x + a_0
%   poly coef = [a_n  a_n-1  ...  a_1  a_0]
polycoef = [1 -45 -264 1700]; % f(x) = x^3 - 45 * x^2 - 264 * x + 1700 = 0
polycoef = [1 0 0 -1];

x1 = -5;    x2 = 5; % initial searching range
es = 10^-4;         % stopping criterion

% finding all root of polynomial
[NoRoots, Roots] = FindAllRoots( polycoef, x1, x2, es );

% printing results
nCoeff = length( polycoef ); % number of coefficients
fprintf('Polynomial: %d*x^%d', polycoef(1),  nCoeff-1 );
for i = 2 : nCoeff - 1
    if polycoef(i) > 0, fprintf( ' + %d*x^%d', polycoef(i), nCoeff-i );
    elseif polycoef(i) < 0, fprintf( ' - %d*x^%d', abs(polycoef(i)), nCoeff-i ); end
end
if polycoef( nCoeff ) > 0, fprintf( ' + %d', polycoef(nCoeff) );
elseif polycoef( nCoeff ) < 0, fprintf( ' - %d', abs( polycoef(nCoeff) ) ); end
fprintf( '\n' );

fprintf( '\nNo of roots : %d\n', NoRoots );
for i = 1 : NoRoots
    fprintf( '     %d-th root = %f\n', i, Roots(i) );
end

if NoRoots ~= nCoeff - 1
    fprintf( '\nFailed in finding all roots\n' );
end

% For comparison: Using the built-in function roots
fprintf( '\n\nUsing the built-in function roots\n' );
Solutions = roots( polycoef );

fprintf( '\nNo of roots : %d\n', length(Solutions) );
for i = 1 : length(Solutions)
    if imag( Solutions(i) ) > 0
        fprintf( '     %d-th root = %f + %fi\n', i, real( Solutions(i) ), imag( Solutions(i) ) );
    elseif imag( Solutions(i) ) < 0
        fprintf( '     %d-th root = %f - %fi\n', i, real( Solutions(i) ), abs( imag( Solutions(i) ) ) );
    else
        fprintf( '     %d-th root = %f\n', i, Solutions(i) );
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [noroots, roots] = FindAllRoots( polycoef, x1, x2, es )
    % FindAllRoots: finding all roots of polynomial function
    %   [noroots, roots] = FindAllRoots( polycoef, x1, x2, es )
    %
    % Inputs
    %   polycoef : coefficients of polynomial
    %   x1, x2: initial searching range
    %   es: stopping criterion
    % Outputs
    %   noroots = number of roots
    %   roots = roots

    % Number of roots % because the n-th ploynomial has n roots
    NoSolution = length( polycoef ) - 1;

    % Searching x ranges bracketing one root
    [noroots, rootrange] = SearchAllRootRange( polycoef, x1, x2, NoSolution );
    if noroots == 0
        error( 'Cannot find any roots' );
    end
    
    % Finding all roots
    roots = zeros(1,noroots); % memory allocation
    for i = 1 : noroots
        roots(i) = Bisect( polycoef, rootrange(:,i), es );
    end
end

function [nroots, rootrange] = SearchAllRootRange( polycoef, x1, x2, NoSolution )
    % SearchAllRootRange: finding x ranges for all roots
    %   [nroots, rootrange] = SearchAllRootRange( polycoef, x1, x2, NoSolution )
    %
    % Input
    %   polycoef : coefficients of polynomial
    %   x1, x2: initial searching range
    %   NoSolution: exact number of roots
    % Outputs
    %   noroots = number of root-bracketing ranges
    %   rootrange = root-bracketing ranges
    
    % Checking the inital searching range
    if x1 > x2
        temp = x1 ;
        x1 = x2;
        x2 = temp;
    elseif x1 == x2
        error('Error in difining the initial searching range');
    end
    
    % Adjusting searching interval
    Incremental = 1; % default value
    while Incremental > (x2 - x1) / 50
        Incremental = Incremental / 5; % reduce the searching interval
    end
    FineIncremental = Incremental / 100; % the searching interval for fine searching 
    
    % Initializing and memory allocation
    nroots = 0;
    rootrange = [];

    % Searching x ranges bracketing one root
    [no, range] = SearchRootRange( polycoef, Incremental, x1, x2 );
    if no < NoSolution % trying the incremental searching more finely 
        [nofine, rangefine] = SearchRootRange( polycoef, FineIncremental, x1, x2 );
        nroots = nofine;
        rootrange = rangefine;
        if nroots == NoSolution, return; end
    else
        nroots = no;
        rootrange = range;
        return
    end        
    
    % Expanding the searching range
    ExpandRange = abs(x2 - x1);
    nExpandCount = 0;
    MaxIterforExpand = 10;
    
	xlower0 = x1;
    xupper0 = x2;
    
    while (nroots < NoSolution && nExpandCount < MaxIterforExpand)
        nExpandCount = nExpandCount + 1;

        xlower = xlower0 - ExpandRange;
        [no, range] = SearchRootRange( polycoef, Incremental, xlower, xlower0 );
        if no < NoSolution - nroots
            [nofine, rangefine] = SearchRootRange( polycoef, FineIncremental, xlower, xlower0 );
            if nofine >= 1
                nroots = nroots + nofine;
                rootrange = [rootrange, rangefine];
            end
        elseif no >= 1
            nroots = nroots + no;
            rootrange = [rootrange, range];
        end
        xlower0 = xlower;
        
        if nroots < NoSolution
            xupper = xupper0 + ExpandRange;
            [no, range] = SearchRootRange( polycoef, Incremental, xupper0, xupper );
            if no < NoSolution - nroots
                [nofine, rangefine] = SearchRootRange( polycoef, FineIncremental, xupper0, xupper );
                if nofine >= 1
                    nroots = nroots + nofine;
                    rootrange = [rootrange, rangefine];
                end
            elseif no >= 1
                nroots = nroots + no;
                rootrange = [rootrange, range];
            end
            xupper0 = xupper;
        end
        
        ExpandRange = ExpandRange * 5;
        Incremental = Incremental * 5;
        FineIncremental = FineIncremental * 5;
    end
end

function [nroots, rootrange] = SearchRootRange( polycoef, Interval, x1, x2 )
    % SearchRootRange: finding root-bracketing ranges within the given searching range
    %   [nroots, rootrange] = SearchRootRange( polycoef, Interval, x1, x2 )
    %
    % Input
    %   polycoef : coefficients of polynomial
    %   Interval: incremental for searching
    %   x1, x2: initial searching range
    % Outputs
    %   noroots = number of root-bracketing ranges
    %   rootrange = root-bracketing ranges

    nroots = 0;
    rootrange = [];

    % Searching x ranges bracketing one root
    for x = x1 : Interval : x2
        if polyval( polycoef, x ) * polyval( polycoef, x+Interval ) < 0
            nroots = nroots + 1;
            rootrange(1, nroots) = x;
            rootrange(2, nroots) = x + Interval;
        end
    end  
end

function solution = Bisect( polycoef, xrange, es )
    % Bisect: finding one root witing the x range
    %   solution = Bisect( polycoef, xrange, es )
    %
    % Input
    %   polycoef : coefficients of polynomial
    %   xrange: x range bracketing one root
    %   es: stopping criterion
    % Outputs
    %   solution = the root of the polynomial

    % checking x range
    xl = xrange(1);
    xu = xrange(2);
    
    if polyval( polycoef, xl ) * polyval( polycoef, xu ) > 0
        error( 'improper range' );
    end
    
    maxit = 1000;
    er = 100;
    iter = 0;
    xrold = xl;
        
    while (1)
        xr = (xl + xu) /2; % the new approximation
        er = abs((xr - xrold) / xr) * 100; % the percent relative error
        iter = iter + 1;
        
        if er <= es || iter >= maxit, break; end

        % Selecting the range
        if polyval( polycoef, xl ) * polyval( polycoef, xr ) < 0, xu = xr;
        else, xl = xr; end
        
        xrold = xr;
    end

    if iter >= maxit, fprintf('Incorrect root\n'); end
    
    solution = xr;
end

% function fvalue = polyval( polycoef, x )
% % polyval( polycoef, x ): calculate the value of polynomial
%     n = length( polycoef );
% 
%     fvalue = polycoef( n );
%     for i = n-1 : -1 : 1
%         fvalue = fvalue + power(x, i) * polycoef( n-i );
%     end
% end
