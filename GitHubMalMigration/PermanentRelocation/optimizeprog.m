% This *.m file will be called by master file 'optimizamaster.m' for optimization. 
% This function will call *.m files of ODE model. It will also call 'gfit.m' to 
%determine the goodness-of-fit.

function mle = optimizeprog(parameters,MalNewCase,Rain,Temper,Mig,runningPlot,numinit)

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


beta1 = pars(1);
beta1d = pars(2);  
betaMd = pars(3);


% Setup the ODE solver.
options=odeset('RelTol',1e-4,'AbsTol',1e-6,'stats','off');

% Choose the appropriate ODE solver:
solver = @ode45; 

%time span
ts=1:12*21;   


% Call the solver
u0=init;
[~, u]=solver(@migmodel,ts,u0,options,pars,Rain,Temper,Mig);


% For origin 
b2 = fixpara(6); 
bM = fixpara(15);


%computing New Cases
NewCases_destin = b2*beta1d*u(:,6).*u(:,10);
NewCases_mig   =  bM*betaMd*u(:,10).*u(:,11);
Total_case= NewCases_destin+NewCases_mig;


p(9)=pars(9);
p1=p(9);
 

TPP = p1*poissrnd(round(1000*Total_case)); %%BLACK%%

TP = TPP(90:90+155);


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


Iosol=u(97:end,2);
Idsol=b2*beta1d*u(92:end,6).*u(92:end,10);
Imsol=bM*betaMd*u(92:end,10).*u(92:end,11);



% Plotting of figures during fitting
 if runningPlot==1
    figure(1);
    plot(1:156,MalNewCase,1:156,TP,'r');
    drawnow;   
    
    
    figure(111)
%For orign
%%
subplot(131)
plot(Iosol,'r')
title('Infected at origin')
xlabel('time')
ylabel('Proportion of population Io')
subplot(132)
plot(Idsol,'b')
title('Infected ,Id')
xlabel('time')
ylabel('Proportion of population Id')
subplot(133)
plot(Imsol,'b')
title('Infected ,Im')
xlabel('time')
ylabel('Proportion of population Im')
 end
end

