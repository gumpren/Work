pro test111
   restore,'C:\__Data\Datasave\2001_2009_median_-0.5_Z_0.5\OMNI_2001_2009_Bz_Vxyz_p_AE_SYMH.sav'
   restore,'C:\__Data\Datasave\2001_2009_median_-0.5_Z_0.5\C3_FGM_2001_2009_Bxyz_Positionxyz_-0.5_Z_0.5.sav'
   
   t_c3fgm=(time_c3fgm-time_omni[0])/60000.0
   t1_omni=data_divided.t1_omni[0:n_elements(data_divided.t1_omni)/24.0]
   t_c3fgm=t_c3fgm[0:n_elements(t_c3fgm)/24.0]
   
   tinterpol_mxn
;   ;test 1
;   tic
;   t_omni_to_c3fgm1=neighbor_time(t1_omni,time_c3fgm)
;   help,t_omni_to_c3fgm1
;   toc

   ;test 2
   
   find_nearest_neighbor, time_series, target_time
   

   stop
end
  