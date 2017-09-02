 pro save_need_time_omni_fgm_cis
  start=systime(1)
  restore,filepath('OMNI_2001_2009_Bz_Vxyz_p_AE_SYMH.sav',root_dir='C:\__Data\Datasave\2001_2009_median_-0.5_Z_0.5')
  restore,filepath('C3_FGM_2001_2009_Bxyz_Positionxyz_-0.5_Z_0.5.sav',root_dir='C:\__Data\Datasave\2001_2009_median_-0.5_Z_0.5')
  ;restore,filepath('C3_CIS_2001_n_vbxyz_p_T.sav',root_dir='D:\__Data\Datasave') \2001_2010
  
  t_omni=(time_omni-time_omni[0])/60000.0
  t_c3fgm=(time_c3fgm-time_omni[0])/60000.0
 ; t_c3cis=(time_c3cis-time_omni[0])/60000.0n

;    t_omni=t_omni[0:n_elements(t_omni)/3.0] 
;    t_c3fgm=t_c3fgm[0:n_elements(t_c3fgm)/3.0]
;    Bz_imf=Bz_imf[0:n_elements(Bz_imf)/3.0]
;    p=p[0:n_elements(p)/6.0]
;    Vx=Vx[0:n_elements(Vx)/6.0]
; 

  ;data=divide_bz(t_omni,bz_imf,p,vx)
  t_omni_to_fgm1=neighbor_time(data_divided.t1_omni,t_c3fgm)
  print,(systime(1)-start)/60.0
  sys=systime(1)
;  t_omni_to_fgm=neighbor_time(t_c3fgm,data_divided.t1_omni)
;  print,(systime(1)-sys)/60.0 
  ;print,t_omni_to_fgm1[where(t_omni_to_fgm1 ne -1 )]
  ;t_omni_to_fgm=neighbor_time(t_omni,t_c3fgm)
  ;print,t_omni_to_fgm[where(t_omni_to_fgm ne -1 )]
 ; print,n_elements(t_omni_to_fgm[where(t_omni_to_fgm ne -1)]) ;don't know why the n_elements(866) of t_omni_to_fgm less than t_omni_to_fgm1(6143)
 ; print,n_elements(t_omni_to_fgm)
  
  t_omni_to_fgm2=neighbor_time(data_divided.t2_omni,t_c3fgm)
  print,(systime(1)-start)/60.0
  t_omni_to_fgm3=neighbor_time(data_divided.t3_omni,t_c3fgm)
  print,(systime(1)-start)/60.0
  t_omni_to_fgm4=neighbor_time(data_divided.t4_omni,t_c3fgm)
  print,(systime(1)-start)/60.0  
  
;  t_omni_to_fgm=neighbor_time(t_omni,t_c3fgm)
;  tcis_need1=neighbor_time(data.t1_omni,t_c3cis)
;  tcis_need2=neighbor_time(data.t2_omni,t_c3cis)
;  tcis_need3=neighbor_time(data.t3_omni,t_c3cis)
;  tcis_need4=neighbor_time(data.t4_omni,t_c3cis)
;  tcis_need=neighbor_time(t_omni,t_c3cis)
  
  
  savetime_tneed=(systime(1)-start)/60.0
  save,savetime_tneed,t_omni_to_fgm1,t_omni_to_fgm2,t_omni_to_fgm3,t_omni_to_fgm4,filename='time_need_omni_to_c3fgm_2001_2009_-0.5_Z_0.5.sav'
  print,savetime_tneed  
  
end