function fixpara = parametermig()
%% For destination
  k  =30;            % to make monthly 
  gamma=k/(24*7);   %rate of recovery
  b2=0.31;    %Sensitive  % probability of infection os sus per bite at destination     
  b2v = 0.6;  %Sensitive  %probability of infection of a susceptible mosquito per bite on an infected at destination


  mud =30.1/(70*12);  % Very Sensitive  %natural birth rate of human at dest
  mu1d=0.0001*k;      %natural  death rate of infected human dest
  mu2d=0.052*k;       %natural  death rate of infected mosquito dest
   
%% For destination Note-just add d in notation like mud,mu1d
 
  fixpara(1)=gamma;
  fixpara(2)=b2; 
  fixpara(3)=b2v;
  fixpara(4)=mud;
  fixpara(5)=mu1d;
  fixpara(6)=mu2d;
   


end