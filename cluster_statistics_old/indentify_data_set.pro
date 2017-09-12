pro indentify_data_set
  Re=6371.0
  ;tplot_restore,filename='C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_origin.tplot'
  restore,'C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_selected__BZgt0_durale1hr_yearly.sav'
  
  store_Data,'B_total',data={x:t_c3fgm1,y:B_total1}
  store_Data,'B_gse',data={x:t_c3fgm1,y:B_gse1}
  store_Data,'pos_gse',data={x:t_c3fgm1,y:pos_gse1}
  store_Data,'density',data={x:t_c3cis1,y:density1}
  store_Data,'velocity_gse',data={x:t_c3cis1,y:velocity_gse1}
  store_Data,'temperature',data={x:t_c3cis1,y:temperature1}
  store_Data,'pressure',data={x:t_c3cis1,y:pressure1}
  
  calc,'"pos_gse"="pos_gse"/Re'
  cotrans,'B_gse','B_gsm',/gse2gsm
  cotrans,'pos_gse','pos_gsm',/gse2gsm
  cotrans,'velocity_gse','velocity_gsm',/gse2gsm
  
  tinterpol_mxn,'B_gsm','density',/NEAREST_NEIGHBOR
  tinterpol_mxn,'pos_gsm','density',/NEAREST_NEIGHBOR
  tinterpol_mxn,'B_total','density',/NEAREST_NEIGHBOR
  
  beta_fac=1.0e-9/(1.0e-9)^2
  miu0=!pi*4e-7
  calc,'"Beta"=2*(beta_fac)*(miu0)*"pressure"/"B_total_interp"^2'
  tclip,'Beta',0.3,10000
  tdeflag,'Beta_clip','remove_nan'
 ; get_data,'Beta_clip_deflag',t,Beta_clip_deflag
  
  
  tinterpol_mxn,'pos_gsm','Beta_clip_deflag',/NEAREST_NEIGHBOR
;  tinterpol_mxn,'B_gsm','Beta_clip_deflag',/NEAREST_NEIGHBOR
;  tinterpol_mxn,'density','Beta_clip_deflag',/NEAREST_NEIGHBOR
;  tinterpol_mxn,'velocity_gsm','Beta_clip_deflag',/NEAREST_NEIGHBOR
;  tinterpol_mxn,'temperature','Beta_clip_deflag',/NEAREST_NEIGHBOR
;  tinterpol_mxn,'pressure','Beta_clip_deflag',/NEAREST_NEIGHBOR
  
  get_data,'pos_gsm_interp',time,pos_gsm_interp
;  split_vec,'pos_gsm_interp'
;  tclip,'pos_gsm_interp_x',-100,-10
;  tclip,'pos_gsm_interp_y',-15,15
;  tclip,'pos_gsm_interp_z',-6,6,newname='pos_gsm_interp_z_le_6'
;  calc,'"pos_gsm_interp_yz"=sqrt("pos_gsm_interp_y"^2+"pos_gsm_interp_z"^2)'
  
  index=identify_plasma_sheet(pos_gsm_interp[*,0],pos_gsm_interp[*,1],pos_gsm_interp[*,2])
  time1=time[index]
  pos_gsm_interp=pos_gsm_interp[index,*]
  
  store_Data,'pos_gsm_interp',data={x:time1,y:pos_gsm_interp}
  
  tinterpol_mxn,'B_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR
  tinterpol_mxn,'density','pos_gsm_interp',/NEAREST_NEIGHBOR
  tinterpol_mxn,'velocity_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR
  tinterpol_mxn,'temperature','pos_gsm_interp',/NEAREST_NEIGHBOR
  tinterpol_mxn,'pressure','pos_gsm_interp',/NEAREST_NEIGHBOR
  
;  get_data,'B_gsm_interp',time2,B_gsm_interp
;  get_data,'density_interp',time2,density_interp
;  get_data,'velocity_gsm_interp',time2,velocity_gsm_interp
  
  get_data,'B_gsm_interp',time_c3,B_gsm
  get_data,'pos_gsm_interp',time_c3,pos_gsm
  get_data,'density_interp',time_c3,density
  get_data,'velocity_gsm_interp',time_c3,velocity_gsm
  get_data,'temperature_interp',time_c3,temperature
  get_data,'pressure_interp',time_c3,pressure
  
  save,time_c3,B_gsm,pos_gsm,density,velocity_gsm,temperature,pressure,$
    filename='C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_final_yearly.sav',/compress
  
  tplot_save,['B_gsm_interp','pos_gsm_interp','density_interp','velocity_gsm_interp','temperature_interp',$
  'pressure_interp'],filename='C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_final',compress=compress
  
end

;
;get_data,'B_gsm',t_c3fgm,B_gsm
;get_data,'pos_gsm',t_c3fgm,pos_gsm
;
;get_Data,'density',t_c3cis,density
;get_Data,'velocity_gsm',t_c3cis,velocity_gsm
;get_Data,'temperature',t_c3cis,temperature
;get_Data,'pressure',t_c3cis,pressure
;
;get_data,'B_gsm_interp',t_c3fgm_interp,B_gsm_interp
;get_data,'pos_gsm_interp',t_c3fgm_interp,pos_gsm_interp
;
;=identify_plasma_beta(B_gsm_interp[*,0],B_gsm_interp[*,1],B_gsm_interp[*,2],pressure)
