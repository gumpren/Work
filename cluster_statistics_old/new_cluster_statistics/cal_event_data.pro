pro cal_event_data
  
  start=systime(1)
  
  selected_cluster_data
  
  indentify_data_set
  
  ;tplot_restore,filenames='C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_final.tplot'
  
  get_data,'pos_gsm_interp',time,pos_gsm
  get_data,'density_interp',time,density
  get_data,'velocity_gsm_interp',time,velocity_gsm
  get_data,'temperature_interp',time,temperature
  get_data,'pressure_interp',time,pressure
  
  H_Re=return_thermal_energy_flow_density(pressure,velocity_gsm[*,0],velocity_gsm[*,1],velocity_gsm[*,2],2)
  K_Re=return_kinetic_energy_flow_density(density,velocity_gsm[*,0],velocity_gsm[*,1],velocity_gsm[*,2],2)
  
  eventimes=return_vari_event(pos_gsm[*,0],pos_gsm[*,1])
  event_n=return_vari_event(pos_gsm[*,0],pos_gsm[*,1],density)
  event_t=return_vari_event(pos_gsm[*,0],pos_gsm[*,1],temperature)
  event_p=return_vari_event(pos_gsm[*,0],pos_gsm[*,1],pressure)
  event_vx=return_vari_event(pos_gsm[*,0],pos_gsm[*,1],velocity_gsm[*,0])
  event_vy=return_vari_event(pos_gsm[*,0],pos_gsm[*,1],velocity_gsm[*,1])
  H_Re_x=return_vari_event(pos_gsm[*,0],pos_gsm[*,1],H_Re[*,0])
  H_Re_y=return_vari_event(pos_gsm[*,0],pos_gsm[*,1],H_Re[*,1])
  K_Re_x=return_vari_event(pos_gsm[*,0],pos_gsm[*,1],K_Re[*,0])
  K_Re_y=return_vari_event(pos_gsm[*,0],pos_gsm[*,1],K_Re[*,1])
  
  save,eventimes,event_n,event_t,event_p,event_vx,event_vy,H_Re_x,H_Re_y,K_Re_x,K_Re_y,$
       filename='C:\__Data\Datasave\2001_2009_median_new\event_data.sav'
 
 
  print,'time_use',(systime(1)-start)/3600.0
 stop
end