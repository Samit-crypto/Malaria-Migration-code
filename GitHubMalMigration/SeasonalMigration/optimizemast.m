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
Migg = 'MigrationDAT.txt';
MalNewCasee = 'Cases.txt';

IniPt = 'IniPt.txt';


MalNewCase = importdata(MalNewCasee);
Rain = importdata(Rainn);
Temper = importdata(Temperr);
Mig = importdata(Migg);
IniPts = importdata(IniPt);

% %Start values of Initial condition
Init1S= IniPts(1);
Init2S= IniPts(2);
Init3S= IniPts(3);
Init4S= IniPts(4);
Init5S= IniPts(5);
Init6S= IniPts(6);
Init7S= IniPts(7);
Init8S= IniPts(8);
Init9S= IniPts(9);
Init10S= IniPts(10);
Init11S= IniPts(11);
Init12S= IniPts(12);
Init13S= IniPts(13);

% Start values of parameters to be estimated
beta1s=0.6*30; %p(1) = biting rate at origin
beta1ds = 0.65*30; %p(2) = biting rate at destination
betaMds= 0.55*30; %p(3) = biting rate for migrants
scalingRs = 0.5; %p(4) scaling factor for Rain
multiRs = 0.95;  %p(5) multiplier factor for Rain 
multiTs = 0.99;  %p(6) multiplier factor for Temperature 
scalingTs = 0.013;  %p(7) scaling factor for temperature
scalingMigs = 6.5;%0.9;  %p(8) scaling factor for migration
p1s = 0.8; %p(9) = reporting probability

 lb = [0.949,0.499,0.0009,0.799,0.199,0.949,0.499,0.0009,0.799,0.199,...
     0.0009,0.0009,0.0009,0.59*30,0.6*30,0.54*30,0.45,0.9,0.899,...
    0.00129,6,0.80];
 ub = [0.951,0.501,0.002,0.801,0.201,0.951,0.501,0.002,0.801,0.201,0.002,...
     0.002,0.002,0.61*30,0.7*30,0.61*30,0.6,1,0.99,0.0231,...
    7,1];



startvals = [Init1S, Init2S, Init3S, Init4S, Init5S, Init6S, Init7S,...
    Init8S, Init9S, Init10S, Init11S, Init12S, Init13S, beta1s, ...
    beta1ds, betaMds, scalingRs, multiRs, multiTs, scalingTs,...
    scalingMigs, p1s]; 
                                          
% Number of initial conditions
numinit = 13;         

% Parameter names
parnames = {'beta1s'; 'beta1ds'; 'betaMds'; 'scalingRs'; 'multiRs';...
    'multiTs'; 'scalingTs'; 'scalingMigs'; 'p1s'};          

% Number of running plot
runningPlot = 1;                          


%-------------------------------------------------------------------------
% OPTIMIZATION for parameter estimation
opts = optimset('Display','iter','Algorithm','SQP','TolX',1e-10000,'TolCon',1e-10000,'TolFun',1e-10000,...
    'MaxIter',1 , 'MaxFunEvals', 1e+1000000); % Sets fminsearch options
[pEstimates, ~, ~, ~, ~, ~, HESSIAN] = fmincon(@(par) ...        % Computes model parameter
    optimizeprog(par,MalNewCase,Rain,Temper,Mig,runningPlot,...    %   estimates using startvals
    numinit),startvals,[],[],[],[],lb,ub,[],opts); %   as starting values


%--------------------------------------------------------------------------
optMast = struct('MalCase',MalCase,'MLhood',MLhood,'AIC', AIC, 'GOF1', goodofit1,...
   'estimates',pEstimates,'Hessian',HESSIAN);

save('MalCaseresult.mat', 'optMast')
toc;
end


