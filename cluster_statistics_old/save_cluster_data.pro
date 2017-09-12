pro save_cluster_data

  start=systime(1)
  Re=6371.0
  filename1=file_search('C:\__Data\Cluster\CP_FGM_SPIN\*.cdf')
  filename2=file_search('C:\__Data\Cluster\CIS\CSA\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*.cdf',count=count2)

  filename1=filename1[0]
  varformat1=['B_vec_xyz_gse__C3_CP_FGM_SPIN','B_mag__C3_CP_FGM_SPIN','sc_pos_xyz_gse__C3_CP_FGM_SPIN']
  cdf2tplot,filename1,varformat=varformat1
  
  time_clip,'*','2001-01-01/00:00:00','2010-01-01/00:00:00',replace=1

  get_data,'B_vec_xyz_gse__C3_CP_FGM_SPIN',t_c3fgm,B_gse
  get_data,'B_mag__C3_CP_FGM_SPIN',t_c3fgm,B_total
  get_data,'sc_pos_xyz_gse__C3_CP_FGM_SPIN',t_c3fgm,pos_gse

  pos_gse=pos_gse/Re

;  tplot_save,['B_vec_xyz_gse__C3_CP_FGM_SPIN','B_mag__C3_CP_FGM_SPIN','sc_pos_xyz_gse__C3_CP_FGM_SPIN'],$
;    filename='C:\__Data\Datasave\2001_2009_median_new\c3_fgm_data_origin',compress=compress

  save_time_c3fgm=(systime(1)-start)/3600.0
  print,save_time_c3fgm
  save,save_time_c3fgm,t_c3fgm,B_total,B_gse,pos_gse,$
    filename='C:\__Data\Datasave\2001_2009_median_new\c3_fgm_data_origin2001.sav',/compress





  filename=filename2[0:364]
  varformat2=['density__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',$
    'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS','pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS']
  cdf2tplot,filename,varformat=varformat2
  
  time_clip,'*','2001-01-01/00:00:00','2010-01-01/00:00:00',replace=1
  
  get_data,'density__C3_CP_CIS-HIA_ONBOARD_MOMENTS',t_c3cis,density
  get_data,'velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',t_c3cis,velocity_gse
  get_data,'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS',t_c3cis,temperature
  get_data,'pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS',t_c3cis,pressure
 
  t_c3cis=t_c3cis[where(t_c3cis ge 0)]
  factor_to_kev=1.0e6/(1000.0*11600)
  temperature=temperature*factor_to_kev
  
  
  save_time_c3cis=(systime(1)-start)/3600.0
  print,save_time_c3cis

  save,save_time_c3cis,t_c3cis,density,velocity_gse,temperature,pressure,$
    filename='C:\__Data\Datasave\2001_2009_median_new\c3_cis_data_origin2001.sav',/compress


end