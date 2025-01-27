function fixpara = parametermig()
%%For origin
  k  =30;            % to make monthly 
  mu =30.4/(70*12);  % 5.4/(70*12);   % Very Sensitive  %natural birth rate of human at origin
  mu1=0.0004*k;      %natural  death rate of infected human origin
  mu2=0.052*k;       %natural  death rate of infected mosquito origin
  
  gamma=k/(24*7);   %rate of recovery
  
  beta1=0*k;          %biting rate at origin
  b1=0.31;       %Sensitive  % probability of infection os sus per bite at origin
  b1v =0.6;     %Sensitive  %probability of infection of a susceptible mosquito per bite on an infected at origin  

  
  b2=0.31;    %Sensitive  % probability of infection os sus per bite at destination     
  b2v = 0.6;  %Sensitive  %probability of infection of a susceptible mosquito per bite on an infected at destination
%% For destination

  mud =30.1/(70*12);     % Very Sensitive  %natural birth rate of human at dest
  mu1d=0.0001*k;      %natural  death rate of infected human dest
  mu2d=0.052*k;       %natural  death rate of infected mosquito dest
  
  beta1d=0*k;          %biting rate at destination
  

%Migrants
  betaMd = 0*k;   %biting rate at for migrators
  bM=0.31;    %Sensitive  % probability of infection os sus per bite at destination 
%% For origin 
  fixpara(1) = mu;
  fixpara(2) = mu1;
  fixpara(3) = mu2;
  fixpara(4)=gamma;
  fixpara(5)=b1;   
  fixpara(6)=b2; 
  fixpara(7)=beta1; 
  
  %% For destination Note-just add d in notation like mud,mu1d
  fixpara(8)=mud;
  fixpara(9)=mu1d;
  fixpara(10)=mu2d;
  fixpara(11)=beta1d; 
  
  %% For Migrators
  
  fixpara(12) = betaMd;
  
  fixpara(13)=b1v; 
  fixpara(14)=b2v; 
  fixpara(15)=bM; 
  

end