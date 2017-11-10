pro cal_event_data
  
  start=systime(1)
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  root_dir='C:\__Data\Datasave\2001_2009_median_new\'

  restore,'C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_selected__BZgt0_durale1hr_yearly_newversion.sav'
  pos_gsm2=pos_gsm1    &   velocity_gsm2=velocity_gsm1      &     t_c3cis2=t_c3cis1
  density2=density1    &   temperature2=temperature1        &     pressure2=pressure1 
  
  idxv2=where(abs(velocity_gsm2) gt 3000.0)
  velocity_gsm2[idxv2]=!values.f_nan
  
  idxn2=where(abs(density2) gt 100.0)
  density2[idxn2]=!values.f_nan
  
  idxt2=where(abs(temperature2) gt 800.0)
  temperature2[idxt2]=!values.f_nan
  
  idxp2=where(abs(pressure2) gt 10.0)
  pressure2[idxp2]=!values.f_nan
   
   
  restore,'C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_selected__BZle0_duragt1hr_yearly_newversion.sav'
  pos_gsm3=pos_gsm1    &   velocity_gsm3=velocity_gsm1      &     t_c3cis3=t_c3cis1
  density3=density1    &   temperature3=temperature1        &     pressure3=pressure1 
  
  idxv3=where(abs(velocity_gsm3) gt 3000.0)
  velocity_gsm3[idxv3]=!values.f_nan

  idxt3=where(abs(temperature3) gt 800.0)
  temperature3[idxt3]=!values.f_nan

  idxp3=where(abs(pressure3) gt 10.0)
  pressure3[idxp3]=!values.f_nan
    
    
  restore,'C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_selected__BZle0_durale1hr_yearly_newversion.sav'  
  pos_gsm4=pos_gsm1    &   velocity_gsm4=velocity_gsm1      &     t_c3cis4=t_c3cis1
  density4=density1    &   temperature4=temperature1        &     pressure4=pressure1 

  idxn4=where(abs(density4) gt 100.0)
  density4[idxn4]=!values.f_nan

  idxt4=where(abs(temperature4) gt 300.0)
  temperature4[idxt4]=!values.f_nan

  idxp4=where(abs(pressure4) gt 100.0)
  pressure4[idxp4]=!values.f_nan

  restore,'C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_selected__BZgt0_duragt1hr_yearly_newversion.sav'
  pos_gsm1=pos_gsm1    &   velocity_gsm1=velocity_gsm1      &     t_c3cis1=t_c3cis1
  density1=density1    &   temperature1=temperature1        &     pressure1=pressure1
  
  idxv1=where(abs(velocity_gsm1) gt 2000.0)
  velocity_gsm1[idxv1]=!values.f_nan

  idxn1=where(abs(density1) gt 100.0)
  density1[idxn1]=!values.f_nan

  idxt1=where(abs(temperature1) gt 800.0)
  temperature1[idxt1]=!values.f_nan

  idxp1=where(abs(pressure1) gt 8.0)
  pressure1[idxp1]=!values.f_nan
  
  
  
  
  eventimes1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],[],reverse_gap)
  eventimes2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],[],reverse_gap)
  eventimes3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],[],reverse_gap)
  eventimes4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],[],reverse_gap)
  save,eventimes1,eventimes2,eventimes3,eventimes4,filename=root_dir+'eventimes'+save_str+'.sav'
   
  event_n1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],density1,reverse_gap)
  event_n2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],density2,reverse_gap)
  event_n3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],density3,reverse_gap)
  event_n4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],density4,reverse_gap)  ;200 data error
  save,event_n1,event_n2,event_n3,event_n4,filename=root_dir+'event_n'+save_str+'.sav'
  
  
  event_t1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],temperature1,reverse_gap)
  event_t2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],temperature2,reverse_gap)
  event_t3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],temperature3,reverse_gap)  ; 
  event_t4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],temperature4,reverse_gap)   ;300 data error
  save,event_t1,event_t2,event_t3,event_t4,filename=root_dir+'event_t'+save_str+'.sav'
  
  
  event_p1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],pressure1,reverse_gap)
  event_p2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],pressure2,reverse_gap)
  event_p3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],pressure3,reverse_gap)  
  event_p4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],pressure4,reverse_gap)  ;1000 npa error
  save,event_p1,event_p2,event_p3,event_p4,filename=root_dir+'event_p'+save_str+'.sav'
  
  event_vx1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],velocity_gsm1[*,0],reverse_gap)
  event_vx2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],velocity_gsm2[*,0],reverse_gap)
  event_vx3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],velocity_gsm3[*,0],reverse_gap) ; 550 error
  event_vx4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],velocity_gsm4[*,0],reverse_gap)
  
  
  event_vy1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],velocity_gsm1[*,1],reverse_gap)
  event_vy2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],velocity_gsm2[*,1],reverse_gap)
  event_vy3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],velocity_gsm3[*,1],reverse_gap)
  event_vy4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],velocity_gsm4[*,1],reverse_gap)
  save,event_vx1,event_vx2,event_vx3,event_vx4,event_vy1,event_vy2,event_vy3,event_vy4,  $
       filename=root_dir+'event_vxy'+save_str+'.sav'
  
  
  
  H_Re1=return_thermal_energy_flow_density(pressure1,velocity_gsm1[*,0],velocity_gsm1[*,1],velocity_gsm1[*,2],2)
  H_Re2=return_thermal_energy_flow_density(pressure2,velocity_gsm2[*,0],velocity_gsm2[*,1],velocity_gsm2[*,2],2)
  H_Re3=return_thermal_energy_flow_density(pressure3,velocity_gsm3[*,0],velocity_gsm3[*,1],velocity_gsm3[*,2],2)
  H_Re4=return_thermal_energy_flow_density(pressure4,velocity_gsm4[*,0],velocity_gsm4[*,1],velocity_gsm4[*,2],2)
  K_Re1=return_kinetic_energy_flow_density(density1,velocity_gsm1[*,0],velocity_gsm1[*,1],velocity_gsm1[*,2],2)
  K_Re2=return_kinetic_energy_flow_density(density2,velocity_gsm2[*,0],velocity_gsm2[*,1],velocity_gsm2[*,2],2)
  K_Re3=return_kinetic_energy_flow_density(density3,velocity_gsm3[*,0],velocity_gsm3[*,1],velocity_gsm3[*,2],2)
  K_Re4=return_kinetic_energy_flow_density(density4,velocity_gsm4[*,0],velocity_gsm4[*,1],velocity_gsm4[*,2],2)
  
  

  H_Re_x1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],H_Re1[*,0],reverse_gap)
  H_Re_x2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],H_Re2[*,0],reverse_gap)
  H_Re_x3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],H_Re3[*,0],reverse_gap)
  H_Re_x4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],H_Re4[*,0],reverse_gap)
  
  H_Re_y1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],H_Re1[*,1],reverse_gap)
  H_Re_y2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],H_Re2[*,1],reverse_gap)
  H_Re_y3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],H_Re3[*,1],reverse_gap)
  H_Re_y4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],H_Re4[*,1],reverse_gap)
  save,H_Re_x1,H_Re_x2,H_Re_x3,H_Re_x4,H_Re_y1,H_Re_y2,H_Re_y3,H_Re_y4,  $
    filename=root_dir+'H_Re_xy'+save_str+'.sav'
  
  
  K_Re_x1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],K_Re1[*,0],reverse_gap)
  K_Re_x2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],K_Re2[*,0],reverse_gap)
  K_Re_x3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],K_Re3[*,0],reverse_gap)
  K_Re_x4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],K_Re4[*,0],reverse_gap)
  
  K_Re_y1=return_vari_event(pos_gsm1[*,0],pos_gsm1[*,1],K_Re1[*,1],reverse_gap)
  K_Re_y2=return_vari_event(pos_gsm2[*,0],pos_gsm2[*,1],K_Re2[*,1],reverse_gap)
  K_Re_y3=return_vari_event(pos_gsm3[*,0],pos_gsm3[*,1],K_Re3[*,1],reverse_gap)
  K_Re_y4=return_vari_event(pos_gsm4[*,0],pos_gsm4[*,1],K_Re4[*,1],reverse_gap)
  
  save,K_Re_x1,K_Re_x2,K_Re_x3,K_Re_x4,K_Re_y1,K_Re_y2,K_Re_y3,K_Re_y4,  $
    filename=root_dir+'K_Re_xy'+save_str+'.sav'
 
 
  print,'time_use',(systime(1)-start)/3600.0
  
  stop
end