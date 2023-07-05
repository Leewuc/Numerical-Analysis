%    It is general practice in engineering and science that equations are plotted as lines 
%    and discrete data as symbols. Here are some data for concentration (c) versus time (t) 
%    for the photo-degradation of aqueous bromine:
%    These data can be described by the following function: c=4.84 exp(-0.0346*t)
%    Use MATLAB to create a plot displaying both the data (using diamond-shaped, 
%    filled-red symbols) and the function (using a green, dashed line). Plot the function for t = 0 to 70 min.

% Photodegradation of agueous bromine
% the equation decribing the photo-degradation
concent = @(t) 4.84 * exp( -0.034 * t);

% Measured values
tmeasured = [10 20 30 40 50 60]';
cmeasured = [3.4 2.6 1.6 1.3 1.0 0.5]';

% Theoretical values
tcalculated = [0 : 0.5 : 70]';
ccalculated = concent( tcalculated );

% Plotting the data and the function
% Method 1: 
figure( 1 )
plot( tcalculated, ccalculated, 'g--', tmeasured, cmeasured, 'rD', 'MarkerFaceColor', 'r' );
xlabel('time (min)'); ylabel('concentration (ppm)');
legend( 'measured', 'calculated');

% Method 2: 일부러 color를 바꿨음.
figure( 2 )
plot( tcalculated, ccalculated, 'r--' );
hold on
plot( tmeasured, cmeasured, 'gD', 'MarkerFaceColor', 'g' );
hold off
xlabel('time (min)'); ylabel('concentration (ppm)');
legend( 'measured', 'calculated');

