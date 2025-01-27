%% Estimation of parameters and Confidence interval (Master file)
% This will call other *.m files to estimate the parameters and save the data 
% Written by Samit Bhattacharyya, Penn State University, 2014
%---------------------------------------------------------------------

function [optMast] = optimizemast

global MalCase AIC goodofit1 MLhood 

tic;
% Loads the data
Rainn = 'RainFallDAT.txt';
Temperr = 'TempDAT.txt';
MalNewCasee = 'Cases.txt';

IniPt = 'IniPt.txt';


MalNewCase = importdata(MalNewCasee);
Rain = importdata(Rainn);
Temper = importdata(Temperr);
IniPts = importdata(IniPt);

% %Start values of Initial condition

Init1S= IniPts(1);
Init2S= IniPts(2);
Init3S= IniPts(3);
Init4S= IniPts(4);
Init5S= IniPts(5);


% Start values of parameters to be estimated
beta1ds = 0.55*30; %p(1) = biting rate at destination
scalingRs = 0.5; %p(2) scaling factor for Rain
multiRs = 0.95;  %p(3) multiplier factor for Rain 
multiTs = 0.3;  %p(4) multiplier factor for Temperature 
scalingTs = 0.19;  %p(5) scaling factor for temperature
p1s = 0.85; %p(6) = reporting probability

 lb = [0.949,0.499,0.0009,0.799,0.199,0.1*30,0.45,0.9,0.299,...
    0.0129,0.809];
 ub = [0.951,0.501,0.002,0.801,0.201,1*30,0.6,1,0.65,0.211,...
    1];



startvals = [Init1S, Init2S, Init3S, Init4S, Init5S, beta1ds,...
    scalingRs, multiRs, multiTs, scalingTs, p1s]; 
                                          
% Number of initial conditions
numinit = 5;         

% Parameter names
parnames = {'beta1ds'; 'scalingRs'; 'multiRs';...
    'multiTs'; 'scalingTs'; 'p1s'};          

% Number of running plot
runningPlot = 1;                          


%-------------------------------------------------------------------------
% OPTIMIZATION for parameter estimation
opts = optimset('Display','iter','Algorithm','SQP','TolX',1e-10000,'TolCon',1e-10000,'TolFun',1e-10000,...
    'MaxIter',2 , 'MaxFunEvals', 1e+1000000); % Sets fminsearch options
[pEstimates, ~, ~, ~, ~, ~, HESSIAN] = fmincon(@(par) ...        % Computes model parameter
    optimizeprog(par,MalNewCase,Rain,Temper,runningPlot,...    %   estimates using startvals
    numinit),startvals,[],[],[],[],lb,ub,[],opts); %   as starting values


%--------------------------------------------------------------------------
optMast = struct('MalCase',MalCase,'MLhood',MLhood,'AIC', AIC, 'GOF1', goodofit1,...
   'estimates',pEstimates,'Hessian',HESSIAN);


save('MalCaseresult.mat', 'optMast')
toc;
end


