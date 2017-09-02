pro save_data_event_statistics
  compile_opt idl2
  start=systime(1)
  Re=6371
  nums=24.0
  
  root_dir='\2001_2009_median'
  restore,filepath('OMNI_2001_2009_Bz_Vxyz_p_AE_SYMH.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('C3_FGM_2001_2009_Bxyz_Positionxyz.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('time_need_omni_to_c3fgm_2001_2009.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('C3_CIS_2001_2009_n_vbxyz_p_t_need.sav',root_dir='C:\__Data\Datasave'+root_dir)
 
  ;Eventimes
  eventimes1=return_eventimes((([t_omni_to_fgm.t_omni_to_fgm1])[t_cis_to_fgm.t_cis_to_fgm1])[tcis_need.index1],x_pos,y_pos)
  eventimes2=return_eventimes((([t_omni_to_fgm.t_omni_to_fgm2])[t_cis_to_fgm.t_cis_to_fgm2])[tcis_need.index2],x_pos,y_pos)
  eventimes3=return_eventimes((([t_omni_to_fgm.t_omni_to_fgm3])[t_cis_to_fgm.t_cis_to_fgm3])[tcis_need.index3],x_pos,y_pos)
  eventimes4=return_eventimes((([t_omni_to_fgm.t_omni_to_fgm4])[t_cis_to_fgm.t_cis_to_fgm4])[tcis_need.index4],x_pos,y_pos)
  save,eventimes1,eventimes2,eventimes3,eventimes4,filename='eventimes_2001_2009_median.sav'
  stop
 
  ;N
  event_n1=return_vari(density.density1,(([t_omni_to_fgm.t_omni_to_fgm1])[t_cis_to_fgm.t_cis_to_fgm1])[tcis_need.index1],x_pos,y_pos)
  event_n2=return_vari(density.density2,(([t_omni_to_fgm.t_omni_to_fgm2])[t_cis_to_fgm.t_cis_to_fgm2])[tcis_need.index2],x_pos,y_pos)
  event_n3=return_vari(density.density3,(([t_omni_to_fgm.t_omni_to_fgm3])[t_cis_to_fgm.t_cis_to_fgm3])[tcis_need.index3],x_pos,y_pos)
  event_n4=return_vari(density.density4,(([t_omni_to_fgm.t_omni_to_fgm4])[t_cis_to_fgm.t_cis_to_fgm4])[tcis_need.index4],x_pos,y_pos)
  save,event_n1,event_n2,event_n3,event_n4,filename='event_n_2001_2009_median.sav'
  stop
  
  ;T
  event_t1=return_vari(temperature.temperature1,(([t_omni_to_fgm.t_omni_to_fgm1])[t_cis_to_fgm.t_cis_to_fgm1])[tcis_need.index1],x_pos,y_pos)
  event_t2=return_vari(temperature.temperature2,(([t_omni_to_fgm.t_omni_to_fgm2])[t_cis_to_fgm.t_cis_to_fgm2])[tcis_need.index2],x_pos,y_pos)
  event_t3=return_vari(temperature.temperature3,(([t_omni_to_fgm.t_omni_to_fgm3])[t_cis_to_fgm.t_cis_to_fgm3])[tcis_need.index3],x_pos,y_pos)
  event_t4=return_vari(temperature.temperature4,(([t_omni_to_fgm.t_omni_to_fgm4])[t_cis_to_fgm.t_cis_to_fgm4])[tcis_need.index4],x_pos,y_pos)
  save,event_t1,event_t2,event_t3,event_t4,filename='event_t_2001_2009_median.sav'
  stop
  
  ;P
  event_p1=return_vari(pressure.pressure1,(([t_omni_to_fgm.t_omni_to_fgm1])[t_cis_to_fgm.t_cis_to_fgm1])[tcis_need.index1],x_pos,y_pos)
  event_p2=return_vari(pressure.pressure2,(([t_omni_to_fgm.t_omni_to_fgm2])[t_cis_to_fgm.t_cis_to_fgm2])[tcis_need.index2],x_pos,y_pos)
  event_p3=return_vari(pressure.pressure3,(([t_omni_to_fgm.t_omni_to_fgm3])[t_cis_to_fgm.t_cis_to_fgm3])[tcis_need.index3],x_pos,y_pos)
  event_p4=return_vari(pressure.pressure4,(([t_omni_to_fgm.t_omni_to_fgm4])[t_cis_to_fgm.t_cis_to_fgm4])[tcis_need.index4],x_pos,y_pos)
  save,event_p1,event_p2,event_p3,event_p4,filename='event_p_2001_2009_median.sav'
  stop
  
  ;V
  event_vx1=return_vari(vbx.vbx1,(([t_omni_to_fgm.t_omni_to_fgm1])[t_cis_to_fgm.t_cis_to_fgm1])[tcis_need.index1],x_pos,y_pos)
  event_vy1=return_vari(vby.vby1,(([t_omni_to_fgm.t_omni_to_fgm1])[t_cis_to_fgm.t_cis_to_fgm1])[tcis_need.index1],x_pos,y_pos)
  event_vx2=return_vari(vbx.vbx2,(([t_omni_to_fgm.t_omni_to_fgm2])[t_cis_to_fgm.t_cis_to_fgm2])[tcis_need.index2],x_pos,y_pos)
  event_vy2=return_vari(vby.vby2,(([t_omni_to_fgm.t_omni_to_fgm2])[t_cis_to_fgm.t_cis_to_fgm2])[tcis_need.index2],x_pos,y_pos)
  event_vx3=return_vari(vbx.vbx3,(([t_omni_to_fgm.t_omni_to_fgm3])[t_cis_to_fgm.t_cis_to_fgm3])[tcis_need.index3],x_pos,y_pos)
  event_vy3=return_vari(vby.vby3,(([t_omni_to_fgm.t_omni_to_fgm3])[t_cis_to_fgm.t_cis_to_fgm3])[tcis_need.index3],x_pos,y_pos)
  event_vx4=return_vari(vbx.vbx4,(([t_omni_to_fgm.t_omni_to_fgm4])[t_cis_to_fgm.t_cis_to_fgm4])[tcis_need.index4],x_pos,y_pos)
  event_vy4=return_vari(vby.vby4,(([t_omni_to_fgm.t_omni_to_fgm4])[t_cis_to_fgm.t_cis_to_fgm4])[tcis_need.index4],x_pos,y_pos)
  save,event_vx1,event_vy1,event_vx2,event_vy2,event_vx3,event_vy3,event_vx4,event_vy4,filename='event_vxy_2001_2009_median.sav'
  stop
  
  
  ;H,K
  Qk1=return_kinetic_energy_flow_density(density.density1,vbx.vbx1,vby.vby1,vbz.vbz1,2);1 erg/(m^2*s)
  Qk2=return_kinetic_energy_flow_density(density.density2,vbx.vbx2,vby.vby2,vbz.vbz2,2);2 erg/(Re^2*s)
  Qk3=return_kinetic_energy_flow_density(density.density3,vbx.vbx3,vby.vby3,vbz.vbz3,2)
  Qk4=return_kinetic_energy_flow_density(density.density4,vbx.vbx4,vby.vby4,vbz.vbz4,2)
  Qk=return_kinetic_energy_flow_density(density.density,vbx.vbx,vby.vby,vbz.vbz,2)

  Qh1=return_thermal_energy_flow_density(pressure.pressure1,vbx.vbx1,vby.vby1,vbz.vbz1,2)
  Qh2=return_thermal_energy_flow_density(pressure.pressure2,vbx.vbx2,vby.vby2,vbz.vbz2,2)
  Qh3=return_thermal_energy_flow_density(pressure.pressure3,vbx.vbx3,vby.vby3,vbz.vbz3,2)
  Qh4=return_thermal_energy_flow_density(pressure.pressure4,vbx.vbx4,vby.vby4,vbz.vbz4,2)
  Qh=return_thermal_energy_flow_density(pressure.pressure,vbx.vbx,vby.vby,vbz.vbz,2)
  save,Qk,Qh,Qk1,Qk2,Qk3,Qk4,Qh1,Qh2,Qh3,Qh4,filename='Qk_Qh_2001_2009_median.sav'
  stop
  
  
  ;Event_Qk_Qt
  restore,filepath('Qk_Qh_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)
  event_qkx1=return_vari(qk1[*,0],(([t_omni_to_fgm.t_omni_to_fgm1])[t_cis_to_fgm.t_cis_to_fgm1])[tcis_need.index1],x_pos,y_pos)
  event_qky1=return_vari(qk1[*,1],(([t_omni_to_fgm.t_omni_to_fgm1])[t_cis_to_fgm.t_cis_to_fgm1])[tcis_need.index1],x_pos,y_pos)
  event_qkx2=return_vari(qk2[*,0],(([t_omni_to_fgm.t_omni_to_fgm2])[t_cis_to_fgm.t_cis_to_fgm2])[tcis_need.index2],x_pos,y_pos)
  event_qky2=return_vari(qk2[*,1],(([t_omni_to_fgm.t_omni_to_fgm2])[t_cis_to_fgm.t_cis_to_fgm2])[tcis_need.index2],x_pos,y_pos)
  event_qkx3=return_vari(qk3[*,0],(([t_omni_to_fgm.t_omni_to_fgm3])[t_cis_to_fgm.t_cis_to_fgm3])[tcis_need.index3],x_pos,y_pos)
  event_qky3=return_vari(qk3[*,1],(([t_omni_to_fgm.t_omni_to_fgm3])[t_cis_to_fgm.t_cis_to_fgm3])[tcis_need.index3],x_pos,y_pos)
  event_qkx4=return_vari(qk4[*,0],(([t_omni_to_fgm.t_omni_to_fgm4])[t_cis_to_fgm.t_cis_to_fgm4])[tcis_need.index4],x_pos,y_pos)
  event_qky4=return_vari(qk4[*,1],(([t_omni_to_fgm.t_omni_to_fgm4])[t_cis_to_fgm.t_cis_to_fgm4])[tcis_need.index4],x_pos,y_pos)
  
  
  event_qhx1=return_vari(qh1[*,0],(([t_omni_to_fgm.t_omni_to_fgm1])[t_cis_to_fgm.t_cis_to_fgm1])[tcis_need.index1],x_pos,y_pos)
  event_qhy1=return_vari(qh1[*,1],(([t_omni_to_fgm.t_omni_to_fgm1])[t_cis_to_fgm.t_cis_to_fgm1])[tcis_need.index1],x_pos,y_pos) 
  event_qhx2=return_vari(qh2[*,0],(([t_omni_to_fgm.t_omni_to_fgm2])[t_cis_to_fgm.t_cis_to_fgm2])[tcis_need.index2],x_pos,y_pos)
  event_qhy2=return_vari(qh2[*,1],(([t_omni_to_fgm.t_omni_to_fgm2])[t_cis_to_fgm.t_cis_to_fgm2])[tcis_need.index2],x_pos,y_pos)
  event_qhx3=return_vari(qh3[*,0],(([t_omni_to_fgm.t_omni_to_fgm3])[t_cis_to_fgm.t_cis_to_fgm3])[tcis_need.index3],x_pos,y_pos)
  event_qhy3=return_vari(qh3[*,1],(([t_omni_to_fgm.t_omni_to_fgm3])[t_cis_to_fgm.t_cis_to_fgm3])[tcis_need.index3],x_pos,y_pos)
  event_qhx4=return_vari(qh4[*,0],(([t_omni_to_fgm.t_omni_to_fgm4])[t_cis_to_fgm.t_cis_to_fgm4])[tcis_need.index4],x_pos,y_pos)
  event_qhy4=return_vari(qh4[*,1],(([t_omni_to_fgm.t_omni_to_fgm4])[t_cis_to_fgm.t_cis_to_fgm4])[tcis_need.index4],x_pos,y_pos)
  save,event_qhx1,event_qhy1,event_qhx2,event_qhy2,event_qhx3,event_qhy3,event_qhx4,event_qhy4,filename='event_qh_2001_2009_median.sav'
  save,event_qkx1,event_qky1,event_qkx2,event_qky2,event_qkx3,event_qky3,event_qkx4,event_qky4,filename='event_qk_2001_2009_median.sav'
  stop
  
  
end


;event_n1=return_vari(density.density1,(([t_need1])[tfgm_need.tfgm_need1])[tcis_need.index1],x_pos,y_pos)
;event_n2=return_vari(density.density2,(([t_need2])[tfgm_need.tfgm_need2])[tcis_need.index2],x_pos,y_pos)
;event_n3=return_vari(density.density3,(([t_need3])[tfgm_need.tfgm_need3])[tcis_need.index3],x_pos,y_pos)
;event_n4=return_vari(density.density4,(([t_need4])[tfgm_need.tfgm_need4])[tcis_need.index4],x_pos,y_pos)
