;+
; :Description:
;    Describe the procedure.
;    计算能流密度 /m^3
;     input:
;     peif_density  cm^-3
;     peif_avgtemp        eV
;     vx_gsm,vy_gsm,vz_gsm     km/s
;     
;     output:
;     energy_total               ;erg/m^3
;     
;     energy_total_flow_xyz      ;erg/Re^2/s
;     
;     keyword：
;     energy_total
;   
;     
; :Author: dell
;-
FUNCTION themis_caculate_energy_flow,peif_density,peif_avgtemp,vx_gsm,vy_gsm,vz_gsm,energy_total=energy_total
  compile_opt idl2
  
  ;caculate energy E=3/2*nkt+1/2*ρv^2
  ;
  m_i=1.6726e-27    ;kg  proton
  n_i=peif_density*(1e+6)  ;m^-3
  vtotal=sqrt((vx_gsm^2+vy_gsm^2+vz_gsm^2)*(1e+6)) ;m/s
  e_v=1.6022e-19   ; 1ev
  kinetic_energy=0.5*m_i*n_i*(vtotal^2)/e_v  ; kg*m^-3*m^2*s^-2  j*m^-3    ev/m^3
  
  k=1.3807e-23  ;J/k
  internal_energy=5.0/2*n_i*k*peif_avgtemp*11600/e_v;j*m^-3  ev/m^3
  
  energy_total=kinetic_energy+internal_energy    ;ev/m^3
  
  erg=6.2415e+11          ;ev
  Re=6374.4                ;km
  energy_total=energy_total/erg                ;erg/m^3
  
  energy_total_flow_x=energy_total*vx_gsm*1.0e+9*RE^2      ;erg/m^3*km/s                     erg/Re^2/s
  energy_total_flow_y=energy_total*vy_gsm*1.0e+9*RE^2
  energy_total_flow_z=energy_total*vz_gsm*1.0e+9*RE^2
  
  energy_total_flow_xyz=[[energy_total_flow_x],[energy_total_flow_y],[energy_total_flow_z]]
  return,energy_total_flow_xyz
  if KEYWORD_SET(energy_total) then   return,energy_total

end
