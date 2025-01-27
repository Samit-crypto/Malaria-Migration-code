% This *.m file will be called by master file 'optimizamaster.m' for optimization. 
% This function will call *.m files of ODE model. It will also call 'gfit.m' to 
%determine the goodness-of-fit.

function mle = optimizeprog(parameters,MalNewCase,Rain,Temper,runningPlot,numinit)

global TP AIC goodofit1 MLhood ICs Params

fixpara = parametermig;

%sample size
nout = length(MalNewCase);

% No. of parameter to be estimated
q = length(parameters);

%Initial Conditions
init=parameters(1:numinit);


ICs = init;

% Vector of parameters to be estimated
pars = parameters((numinit+1):q);
%display(pars, 'pars')

Params = pars;



beta1d = pars(1);  



% Setup the ODE solver.
options=odeset('RelTol',1e-4,'AbsTol',1e-6,'stats','off');

% Choose the appropriate ODE solver:
solver = @ode45; 

%time span
ts=1:12*21;   


% Call the solver
u0=init;
[~, u]=solver(@migmodel,ts,u0,options,pars,Rain,Temper);


% For origin 
b2 = fixpara(2); 



%computing New Cases
NewCases_destin = b2*beta1d*u(:,1).*u(:,5);
Total_case= NewCases_destin;


p(6)=pars(6);
p1=p(6);
 

TPP = p1*poissrnd(round(1000*Total_case)); %%BLACK%%

TP = TPP(91:91+155);


% Sum of squared errors to be minimized.
mle = sum(log(0.1+poisspdf(MalNewCase,TP)));
AIC = 2*q+2*mle
MLhood = mle 


% measurement of Goodness of fit (by MSE)
if runningPlot==1
goodofit1 = gfit(MalNewCase,TP,'9');
end

XX = goodofit1;
disp(XX)
Idsol=b2*beta1d*u(92:end,1).*u(92:end,5);

% Plotting of figures during fitting
 if runningPlot==1
    figure(1);
    plot(1:156,MalNewCase,1:156,TP,'r');
    drawnow;   
     

figure(111)
plot(Idsol,'b')
title('Infected ,Id')
xlabel('time')
ylabel('Proportion of population Id')
 end
end

