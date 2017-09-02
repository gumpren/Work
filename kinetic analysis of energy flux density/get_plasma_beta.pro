function get_plasma_beta,Bx,By,Bz,P
  beta_fac=1.0e-9/(1.0e-9)^2
  miu0=!pi*4e-7
  B=sqrt(Bx^2+By^2+Bz^2)
  beta=2*beta_fac*miu0*P/B^2
 
  return,beta
end