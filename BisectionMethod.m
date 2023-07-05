%x = [-10:1:50];
%f = x.^3 - 45*x.^2 - 264*x + 1700;
%plot(x,f)
syms x; %symbol
f = input('input formula: '); %input
xmin = input('input xmin: ');
xmax = input('input xmax: ');
es = input('input error: ');
x1 = eval(subs(f,x,xmin)); %find value
x2 = eval(subs(f,x,xmax));
if x1*x2 > 0 %bisection method x<0 or x>0
    disp('This bracket has not root');
else
    middle = (xmin+xmax) / 2;
    ea = eval(subs(f,x,middle));
    fprintf('\nxmin            xmax            middle         ea\n');
    while abs(ea)>es
        fprintf('%f\t%f\t%f\t%f\n',xmin,xmax,middle,ea);
        if x1 * ea < 0
            xmax = middle;
        else
            xmin = middle;
        end
        middle = (xmin+xmax) /2;
        ea = eval(subs(f,x,middle));
    end
    fprintf('\nroot is: %f\n', middle);
end
