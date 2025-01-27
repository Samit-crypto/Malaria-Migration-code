function udash= migmodel(t,u,p,Rain,Temper,Mig)

fixpara = parametermig;

tt = mod(t,12)+1;

i=floor(tt);

r = Rain(i,1)+randn*Rain(i,2);
if r<0
   r=0;
end

T = Temper(i,1)+randn*Temper(i,2);
if T<0
   T=0;
end

  So=u(1);
  Io=u(2);
  Ro=u(3);
  Sov=u(4);
  Iov=u(5);
  Sd=u(6);
  Id=u(7);
  Rd=u(8);
  Sdv=u(9);
  Idv=u(10);
  Sm=u(11);
  Im=u(12);
  Rm=u(13);

 %%   For origin
  mu=fixpara(1);
  mu1=fixpara(2);
  mu2=fixpara(3); 
  gamma=fixpara(4);
  b1=fixpara(5); 
  b2=fixpara(6); 
  b1v=fixpara(13); 
  b2v=fixpara(14); 
  bM=fixpara(15); 
  % estimate parameters
  beta1=p(1);
  beta1d=p(2); 
  betaMd = p(3);
  %%   For destination
  mud=fixpara(8);
  mu1d=fixpara(9);
  mu2d=fixpara(10);
  
  
  
  
  A1=p(5)*(1-exp(-p(4)*r))+p(6)*exp(-p(7)*T)/(1.11+10.112/(1+((T/19.096)^2.3)));

   
  A1d=p(5)*((1-exp(-p(4)*r)))+p(6)*exp(-p(7)*T)/(1.11+10.112/(1+((T/19.096)^2.3)));
 
  

 
 
 %% 
 etaa = Mig(i,1)*p(8);
 eta = etaa; 

  if (i>4)&&(i<7)
  nu = 0.72;
  else 
      nu = 0.1;
  end

  

  

% model
% For origin human 
Sodash = mu - b1*beta1*Iov*So-mu1*So- eta*So + nu*Sm;
Iodash = b1*beta1*Iov*So - mu1*Io- gamma*Io - eta*Io+nu*Im;
Rodash = gamma*Io - mu1*Ro- eta*Ro + nu*Rm;

% For origin vector
Sovdash= A1-mu2*Sov-b1v*beta1*Io*Sov; %A1
Iovdash= b1v*beta1*Io*Sov - mu2*Iov;

%% For destination human
Sddash = mud - b2*beta1d*Idv*Sd - mu1d*Sd;
Iddash = b2*beta1d*Idv*Sd - mu1d*Id-gamma*Id ;
Rddash = gamma*Id - mu1d*Rd;

%For desti vector
Sdvdash= A1d-mu2d*Sdv-b2v*beta1d*(1.5*Im+Id)*Sdv; %% Note - Im+Id will come in contact with Sdv 
Idvdash= b2v*beta1d*(Id+1.5*Im)*Sdv - mu2d*Idv;

%%For Migrants
Smdash = eta*So - bM*Idv*betaMd*Sm - nu*Sm;
Imdash = bM*Idv*betaMd*Sm + eta*Io - nu*Im;
Rmdash = eta*Ro- nu*Rm;

udash=[Sodash;Iodash;Rodash;Sovdash;Iovdash;Sddash;Iddash;Rddash;Sdvdash;Idvdash;Smdash;Imdash;Rmdash];

end