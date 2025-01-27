function udash= migmodel(t,u,p,Rain,Temper)

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

  
  Sd=u(1);
  Id=u(2);
  Rd=u(3);
  Sdv=u(4);
  Idv=u(5);
  

 %%   For origin
  
  gamma=fixpara(1);
  b2=fixpara(2); 
  b2v=fixpara(3); 
  
  % estimate parameters
  
  beta1d=p(1); 
  
  %%   For destination
  mud=fixpara(4);
  mu1d=fixpara(5);
  mu2d=fixpara(6);
  
  
   
  A1d=p(3)*((1-exp(-p(2)*r)))+p(4)*exp(-p(5)*T)/(1.11+10.112/(1+((T/19.096)^2.3)));%+0.9*((T-11)/110));
 
  


%% For destination human
Sddash = mud - b2*beta1d*Idv*Sd - mu1d*Sd;
Iddash = b2*beta1d*Idv*Sd - mu1d*Id-gamma*Id ;
Rddash = gamma*Id - mu1d*Rd;

%For desti vector
Sdvdash= A1d-mu2d*Sdv-b2v*beta1d*Id*Sdv; %% Note - Im+Id will come in contact with Sdv 
Idvdash= b2v*beta1d*Id*Sdv - mu2d*Idv;



udash=[Sddash;Iddash;Rddash;Sdvdash;Idvdash];

end