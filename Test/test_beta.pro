pro test_beta
  Re=6371.0
  year='200'+strcompress(1,/remove)

  filename1=file_search('C:\__Data\Cluster\CP_FGM_SPIN\*__'+year+'*.cdf')
  cdf2tplot,filename1,varformat=['B_mag__C3_CP_FGM_SPIN','B_vec_xyz_gse__C3_CP_FGM_SPIN','sc_pos_xyz_gse__C3_CP_FGM_SPIN']


  filename2=file_search('C:\__Data\Cluster\CIS\CSA_Download_20161216_0640\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*__'+year+'*.cdf')
  cdf2tplot,filename2,varformat=['density__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',$
    'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS','pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS']

  factor_to_kev=1.0e6/(1000.0*11600)
  calc,'"temperature"="temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS"*factor_to_kev'
  calc,'"pos_gse"="sc_pos_xyz_gse__C3_CP_FGM_SPIN"/Re'
  calc,'"B_total"="B_mag__C3_CP_FGM_SPIN"/1.0'
  cotrans,'B_vec_xyz_gse__C3_CP_FGM_SPIN','B_gsm',/gse2gsm
  cotrans,'pos_gse','pos_gsm',/gse2gsm
  calc,'"density"="density__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'
  calc,'"temperature"="temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'
  calc,'"pressure"="pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'

  tinterpol_mxn,'B_gsm','density',/NEAREST_NEIGHBOR
  tinterpol_mxn,'pos_gsm','density',/NEAREST_NEIGHBOR
  tinterpol_mxn,'B_total','density',/NEAREST_NEIGHBOR

  beta_fac=1.0e-9/(1.0e-9)^2
  miu0=!pi*4e-7
  calc,'"Beta"=2*(beta_fac)*(miu0)*"pressure"/"B_total_interp"^2'
  
  tbeg=time_double('2001-07-08/05:03:00')
  tend=time_double('2001-07-08/07:46:00')
  beta1=tsample('Beta',[tbeg,tend],times=time)
  
;  tclip,'Beta',0.3,10000
;  tdeflag,'Beta_clip','remove_nan'
;
;  tinterpol_mxn,'pos_gsm','Beta_clip_deflag',/NEAREST_NEIGHBOR
;  get_data,'pos_gsm_interp',time,pos_gsm_interp
;
;  index=identify_plasma_sheet(pos_gsm_interp[*,0],pos_gsm_interp[*,1],pos_gsm_interp[*,2])
;  time1=time[index]
;  pos_gsm_interp=pos_gsm_interp[index,*]
;
;  store_Data,'pos_gsm_interp',data={x:time1,y:pos_gsm_interp}
;  
;
;      
;  tinterpol_mxn,'B_total','pos_gsm_interp',/NEAREST_NEIGHBOR
;  tinterpol_mxn,'B_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR
;  tinterpol_mxn,'density','pos_gsm_interp',/NEAREST_NEIGHBOR
;  tinterpol_mxn,'velocity_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR
;  tinterpol_mxn,'temperature','pos_gsm_interp',/NEAREST_NEIGHBOR
;  tinterpol_mxn,'pressure','pos_gsm_interp',/NEAREST_NEIGHBOR
;  tinterpol_mxn,'Beta_clip_deflag','pos_gsm_interp',/NEAREST_NEIGHBOR
;  
;  
;  
;  tbeg=time_double('2001-07-08/07:18:00')
;  tend=time_double('2001-07-08/08:17:00')
;  pressure1=tsample('pressure_interp',[tbeg,tend],times=t_c3fgm_temp)
;  btotal1=tsample('B_total_interp',[tbeg,tend],times=t_c3fgm_temp)
;  beta1=tsample('Beta_clip_deflag_interp',[tbeg,tend],times=t_c3fgm_temp)
;  pos_gsm1=tsample('pos_gsm_interp',[tbeg,tend],times=t_c3fgm_temp)

  
  stop

end