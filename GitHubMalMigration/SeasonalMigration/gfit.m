% This *.m-file will compute the goodness-of-fit for regression model

% --------------------------------------------------------
% GFitMeasure:  string value representing different form of goodness of fit measure as follows
%               '1' - mean squarred error (mse)  
%               '2' - normalised mean squarred error (nmse)
%               '3' - root mean squarred error (rmse)
%               '4' - normalised root mean squarred error (nrmse)
%               '5' - mean absolute error (mae)
%               '6' - mean  absolute relative error  (mare)
%               '7' - coefficient of correlation (r)
%               '8' - coefficient of determination (d)
%               '9' - coefficient of efficiency (e)         
%              
% OUTPUT:
%       gf:  goodness of fit values between model output and target 
%



function [gf,Error1, absError1] = gfit(t,y,varargin)


% ---------------------------------------------------------------------
% INPUT ARGUMENTS CHECK
error(nargchk(2,3,nargin));
if ~isvector(t) || ~isvector(y)
    error('Invalid data size: input data must be vector')
end
t = t(:);
y = y(:);
n = length(t);
if n ~= length(y)
    error('Invalid data size: lenght of t and y must be same')
end
if nargin == 3
    gFitMeasure = varargin{1};    
else
   gFitMeasure = '1';          % default goodness of fit as mse
end
e = t - y;
Error1 = sum(e.^2)/156;
absError1 = mean(e.^2)/var(t);
switch gFitMeasure
  
case '1'                      % mean squarred error
    gf = mean(e.^2);        % 0 - perfect match between output and target
    
case '2'                      % normalised mean squarred error
    gf = mean(e.^2)/var(t); % 0 - perfect match 
    
case '3'                      % root mean squarred error
    gf = sqrt(mean(e.^2));  % 0 - perfect match     
    
case '4'                            % normalised root mean squarred error
    gf = sqrt(mean(e.^2)/var(t)); % 0 - perfect match
    
case '5'                      % mean absolute error 
   gf = mean(abs(e));       % 0 - perfect match
   
case '6'                      % mean absolute relative error
   gf = mean((abs(e./t)));  % 0 - perfect match
   
case '7'                      % coefficient of correlation
   cf = corrcoef(t,y);      % 1 - perfect match
   gf = cf(1,2);     
   
case '8'                      % coefficient of determination
   cf = corrcoef(t,y);      
   gf = cf(1,2);
   gf = gf^2;               % 1 - perfect match
   
case '9'                                       % coefficient of efficiency
   gf = 1 - sum(e.^2)/sum((t - mean(t)).^2); % 1 - perfect match
   
otherwise
  error('Invalid goodness of fit measure: It must be one of the strings {1 2 3 4 5 6 7 8 9}')
end
