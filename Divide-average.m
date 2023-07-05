%    The “divide and average” method, an old-time method for approximating the 
%    square root of any positive number a, can be formulated as x = (x + a/x) / 2
%    Write a well-structured M-file function based on the while...break loop structure to 
%    implement this algorithm. Use proper indentation so that the structure is clear. 
%    At each step estimate the error in your approximation as ε = |(xnew - xold)/xnew|
%    Repeat the loop until ε is less than or equal to a specified value. 
%    Design your program so that it returns both the result and the error. 
%    Make sure that it can evaluate the square root of numbers that are equal to and less than zero. 
%    For the latter case, display the result as an imaginary number. 
%    For example, the square root of -4 would return 2i. 
%   Test your program by evaluating a = 0, 2, 10 and -4 for ε = 1 × 10^-4.

es = 10^(-4); % pre-specified tolerance
a  = [0 2 1 -4];

for i = 1 : 4
    [result, error, status] = divide_average(a(i), es);
    
    fprintf( 'The approximate square root of %f : ', a(i) );
    if strcmp( status, 'positive'), fprintf( '%f (relative error: %f)\n', result, error );
    else
        fprintf( '%fi (relative error: %f)\n', result, error );
        result = complex(0, result);
    end
	if i ~= 4, fprintf( '\n' ); end
end


function [result, er, status] = divide_average(a, es)
    % this approximates the square root of any real number a based on the divided and average method
    % input 
    %   a : any real number
    %   es : pre-specified tolerance
    % output
    %   result : the approximate square root
    %   er : approximate relative error

    maxit = 100; % the maxinum number of repitition
    
    iter = 1; % the number of repetition
    er = 100; % the initial relative error
    xnew = 1.; % the initial guess of the result
    
    if a < 0
        a = -a; 
        status = 'negative';
    else
        status = 'positive';
    end
    
    while ( 1 )
        xold = xnew;
        xnew = (xold + a / xold) / 2.;
        iter = iter + 1;
        
        if xnew ~= 0, er = abs( (xnew - xold) / xnew ); end
        if er <= es || iter > maxit, break; end
    end
    
    if iter > maxit
        if abs( xnew - xold ) > es, error( 'Failed' );
        else, result = xnew; end
    else, result = xnew; end
end
