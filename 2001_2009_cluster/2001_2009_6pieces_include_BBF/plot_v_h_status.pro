pro plot_v_h_status
  ;0-8   (20040727,20050824)
  Re=6371.0
  date='200508'    ;20040727 20050824
  year='2005'

  filename1=file_search('C:\__Data\Cluster\CP_FGM_SPIN\*__'+year+'*.cdf')
  cdf2tplot,filename1,varformat=['B_mag__C3_CP_FGM_SPIN','B_vec_xyz_gse__C3_CP_FGM_SPIN','sc_pos_xyz_gse__C3_CP_FGM_SPIN']
  ; newname=['B_mag','B_gse','pos_gse']

  filename2=file_search('C:\__Data\Cluster\CIS\CSA_Download_20161216_0640\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*__'+year+'*.cdf')
  cdf2tplot,filename2,varformat=['density__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',$
    'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS','pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS']

  factor_to_kev=1.0e6/(1000.0*11600)
  calc,'"temperature"="temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS"*factor_to_kev'
  calc,'"pos_gse"="sc_pos_xyz_gse__C3_CP_FGM_SPIN"/Re'
  calc,'"B_total"="B_mag__C3_CP_FGM_SPIN"/1.0'
  cotrans,'B_vec_xyz_gse__C3_CP_FGM_SPIN','B_gsm',/gse2gsm
  cotrans,'pos_gse','pos_gsm',/gse2gsm
  cotrans,'velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gsm',/gse2gsm
  calc,'"density"="density__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'
  calc,'"pressure"="pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'


  tinterpol_mxn,'B_gsm','density',/NEAREST_NEIGHBOR,/IGNORE_NANS
  tinterpol_mxn,'pos_gsm','density',/NEAREST_NEIGHBOR,/IGNORE_NANS
  tinterpol_mxn,'B_total','density',/NEAREST_NEIGHBOR,/IGNORE_NANS

  beta_fac=1.0e-9/(1.0e-9)^2
  miu0=!pi*4e-7
  mi=1.67e-27
  h_fac=Re^2/1.0e9
  k_fac=1.0e12*Re^2
  split_vec,'velocity_gsm'
  calc,'"Beta"=2*(beta_fac)*(miu0)*"pressure"/"B_total_interp"^2'
  calc,'"enthaphy_flux_x"=h_fac*2.5*"pressure"*"velocity_gsm_x"'
  calc,'"kinetic_flux_x"=k_fac*0.5*(mi)*"density"*("velocity_gsm_x"^2+"velocity_gsm_y"^2+"velocity_gsm_z"^2)*"velocity_gsm_x"'
  
 
  
  
  tstart=time_double('2005-08-24/09:12:55')
  tend=time_double('2005-08-24/09:53:48')


  plot_trange=[tstart,tend]

  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_6pieces_include_BBF\littlev_largeh_events\'
  save_dir='C:\__Data\Datasave\2001_2009_6pieces_include_BBF\littlev_largeh_events'
  title_char='v_h_status_'+time_string(tstart,format=2)+'_'+time_string(tend,format=2)

  ;timespan,time_string(time[0]),time[n_elements(time)-1]-time[0],/seconds
  init_crib_colors

  popen,output_dir+title_char,xsize=4.5,ysize=7.0,font=1,units='inches'
  tplot_options, 'font', 1
  tplot_options, 'charsize', 0.7
  tplot_options, 'xticklen', 0.05
  tplot_options, 'yticklen', 0.015
  tplot_options, 'zticklen', 0.3
  tplot_options, 'xgap', 0.3
  tplot_options, 'ygap', 0.8
  tplot_options, 'xmargin', [14,10]
  tplot_options, 'ymargin', [1,1]
  ; tplot_options, 'tickinterval', 60.*10.
  tplot_options,'y_no_interp',1
  time_stamp,/off
  ; options,'*',colors=[0,4,6]


  ;    tplot_options,'polyfill.tstart',time_string(tstart_shadow)
  ;    tplot_options,'polyfill.tend',time_string(tend_shadow)
  ;    tplot_options,'polyfill.color','grey'

  ;   tlimit, time[0], time[n_elements(time)-1]-time[0], /seconds

  options, 'density',ytitle='n(cm^-3)',labflag=-1
  options, 'temperature',ytitle='T(kev)',labflag=-1
  options, 'pressure',ytitle='p(nPa)',labflag=-1
  options, 'velocity_gsm',ytitle='V(km/s)',labels=['Vx','Vy','Vz'],labflag=-1
  options, 'pos_gsm_interp',ytitle='position',labels=['X','Y','Z'],labflag=-1
  options, 'B_gsm_interp',ytitle='B(nT)',labels=['Bx','By','Bz'],labflag=-1
  options, 'enthaphy_flux_x',ytitle='Hx',labflag=-1  ;'H(10!u16!n!xergs!u-1!n!xRe!u-2!n!x)'
  options, 'kinetic_flux_x',ytitle='KX',labflag=-1
;    options, 'AE_INDEX',ytitle='AE',labflag=-1
;    options, 'SYM_H',ytitle='SYM_H',labflag=-1
  tplot,['density','temperature','pressure','velocity_gsm','pos_gsm_interp','B_gsm_interp','enthaphy_flux_x','kinetic_flux_x'],trange=plot_trange
 


  pclose


  stop

end