pro cluster_temperature_data_from_cdaweb
   compile_opt idl2
   
   Re=6371.0  
   kb=1.38e-23
   
   start=systime(1)
   root_dir='C:\__Data\Datasave\dayside_plasma_sheet\'
 
;;; ________________________________part2_______________________
  



  
  
  for ii=0,8  do begin
    year='200'+strcompress(ii+1,/remove)
    filename1=file_search('C:\__Data\Cluster\CIS\CSA_Download_20161216_0640\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*__'+year+'*.cdf')
    cdf2tplot,filename1,varformat='*'
    get_Data,'temp_par__C3_CP_CIS-HIA_ONBOARD_MOMENTS',time1,temp_par1
    get_Data,'density__C3_CP_CIS-HIA_ONBOARD_MOMENTS',time1,density1
    get_Data,'pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS',time1,pressure1
    
    filename2=file_search('D:\__Data\CDAweb_NASA\CIS\'+year+'\*.cdf')
    cdf2tplot,filename1,varformat='*'
    get_Data,'T_p_par__C3_PP_CIS',time2,temp_par2
    get_Data,'N_p__C3_PP_CIS',time2,density2
 
  
 
 
 
    
    filename1=file_search('C:\__Data\Cluster\CP_FGM_SPIN\*__'+year+'*.cdf')
    cdf2tplot,filename1,varformat=['B_mag__C3_CP_FGM_SPIN','B_vec_xyz_gse__C3_CP_FGM_SPIN','sc_pos_xyz_gse__C3_CP_FGM_SPIN']
    ; newname=['B_mag','B_gse','pos_gse']
  
  
    filename2=file_search('D:\__Data\CDAweb_NASA\CIS\'+year+'\*.cdf')
    cdf2tplot,filename2,varformat=[]
;    ['temp_par__C3_CP_CIS-HIA_ONBOARD_MOMENTS','temp_perp__C3_CP_CIS-HIA_ONBOARD_MOMENTS',$
;      'density__C3_CP_CIS-HIA_ONBOARD_MOMENTS','pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS']
  
    factor_to_kev=1.0e6/(1000.0*11600)
    calc,'"temp_par"="temp_par__C3_CP_CIS-HIA_ONBOARD_MOMENTS"*factor_to_kev'
    calc,'"temp_perp"="temp_perp__C3_CP_CIS-HIA_ONBOARD_MOMENTS"*factor_to_kev'
    calc,'"pos_gse"="sc_pos_xyz_gse__C3_CP_FGM_SPIN"/Re'
    calc,'"B_total"="B_mag__C3_CP_FGM_SPIN"/1.0'
    cotrans,'B_vec_xyz_gse__C3_CP_FGM_SPIN','B_gsm',/gse2gsm
    cotrans,'pos_gse','pos_gsm',/gse2gsm
    calc,'"pressure"="pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'
    calc,'"density"="density__C3_CP_CIS-HIA_ONBOARD_MOMENTS"/1.0'
    ;clean_spikes,'pressure',nsmooth=10
  
  
    tinterpol_mxn,'B_gsm','density',/NEAREST_NEIGHBOR,/IGNORE_NANS
    tinterpol_mxn,'pos_gsm','density',/NEAREST_NEIGHBOR,/IGNORE_NANS
    tinterpol_mxn,'B_total','density',/NEAREST_NEIGHBOR,/IGNORE_NANS
  
    beta_fac=1.0e-9/(1.0e-9)^2
    miu0=!pi*4e-7
    calc,'"Beta"=2*(beta_fac)*(miu0)*"pressure"/"B_total_interp"^2'
    tclip,'Beta',0.3,10000
    tdeflag,'Beta_clip','remove_nan'                 ; beta identified
  
    tinterpol_mxn,'pos_gsm','Beta_clip_deflag',/NEAREST_NEIGHBOR,/IGNORE_NANS
    get_data,'pos_gsm_interp',time,pos_gsm_interp
  
    index=identify_plasma_sheet(pos_gsm_interp[*,0],pos_gsm_interp[*,1],pos_gsm_interp[*,2],3)
    time_index=time[index]
    pos_gsm_interp=pos_gsm_interp[index,*]          ;  plasma sheet identified
  
    store_Data,'pos_gsm_interp',data={x:time_index,y:pos_gsm_interp}
  
    tinterpol_mxn,'B_total','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
    tinterpol_mxn,'B_gsm','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
    tinterpol_mxn,'temp_par','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
    tinterpol_mxn,'temp_perp','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
    tinterpol_mxn,'density','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
    tinterpol_mxn,'pressure','pos_gsm_interp',/NEAREST_NEIGHBOR,/IGNORE_NANS
    
    
    transfer_fac=1.16e22
    calc,'"pressure_par"=kb*"density_interp"*"temp_par_interp"*transfer_fac'
    calc,'"Beta_par"=2*(beta_fac)*(miu0)*"pressure_par"/"B_total_interp"^2'
    calc,'"t_ratio"=("temp_perp_interp"/"temp_par_interp")-1'
    ;some removed bad points will come back when doing interpol
    ;      rbsp_remove_spikes,'pressure_interp',/samename
    ;      rbsp_remove_spikes,'temperature_interp',/samename
    ;      rbsp_remove_spikes,'velocity_gsm_interp',/samename
    ;      rbsp_remove_spikes,'density_interp',/samename            ;remove bad points
    ;
    ;      tdeflag,'pressure_interp','remove_nan',/overwrite
    ;      tdeflag,'temperature_interp','remove_nan',/overwrite
    ;      tdeflag,'velocity_gsm_interp','remove_nan',/overwrite
    ;      tdeflag,'density_interp','remove_nan',/overwrite
    ;                                                    ; bad points in different variables are located in different positions in array list
    
    get_Data,'temp_par_interp',time_1,temp_par
    get_Data,'temp_perp_interp',time_1,temp_perp
    get_Data,'density_interp',time_1,density
    get_Data,'pos_gsm_interp',time_1,pos_gsm
    get_Data,'Beta_par',time_1,Beta_par
    get_Data,'t_ratio',time_1,t_ratio
    
    append_Array,time1,TEMPORARY(time_1)
    append_Array,pos_gsm1,TEMPORARY(pos_gsm)
    append_Array,density1,TEMPORARY(density)
    append_Array,temp_perp1,TEMPORARY(temp_perp)
    append_Array,temp_par1,TEMPORARY(temp_par)
    append_Array,t_ratio1,TEMPORARY(t_ratio)
    append_Array,Beta_par1,TEMPORARY(Beta_par)
    
    del_data,'*'
    print,ii
  
  endfor
  
  
  save_time_c3fgmcis=(systime(1)-start)/3600.0
  print,'save_time ',save_time_c3fgmcis,' hour'
  save_time_c3fgmcis=strcompress(save_time_c3fgmcis,/remove)+' hours'
  
  save,save_time_c3fgmcis,time1,pos_gsm1,density1,temp_perp1,temp_par1,t_ratio1,Beta_par1,$
    filename=root_dir+'c3_temperature_perp_par_data_2001_2009_wider.sav'
  
 ; undefine,t_c3fgm1,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1

  stop
  
 ;________________________________part3_______________________  
  

  restore,'C:\__Data\Datasave\dayside_plasma_sheet\c3_temperature_perp_par_data_2001_2009_wider.sav'
  
  index1=where(temp_par1 le 10 and temp_perp1 le 10)
  
  time1=time1[index1]
  pos_gsm1=pos_gsm1[index1,*]
  density1=density1[index1]
  temp_perp1=temp_perp1[index1]
  temp_par1=temp_par1[index1]
  t_ratio1=t_ratio1[index1]
  Beta_par1=Beta_par1[index1]
  
 
  reverse_gap=10.0/10.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\dayside_plasma_sheet\'

  event_t_ratio=return_vari_event_dayside(pos_gsm1[*,0],pos_gsm1[*,1],t_ratio1,reverse_gap,xrange=[0,15],yrange=[-15,15])
  event_Beta_par=return_vari_event_dayside(pos_gsm1[*,0],pos_gsm1[*,1],Beta_par1,reverse_gap,xrange=[0,15],yrange=[-15,15])

  
  bar_title1='T!D!9' + String(120b) + '!X!N/T!D!9'+String(35b) +'!X!N-1'
  bar_title2='!4'+String(98b)+'!X!D!9'+String(35b) +'!X!N'
  
  
  zrange1=[-1,3.0];N
  zrange2=[0,10];T
 
  
  zrange=[[zrange1],[zrange2]]
  bar_title=[bar_title1,bar_title2]

  event_t_ratio=reform(event_t_ratio,15*30*reverse_gap^2)
  event_Beta_par=reform(event_Beta_par,15*30*reverse_gap^2)



  data=[[event_t_ratio],[event_Beta_par]]

  title_char='beta_par_wider'
  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  x=linspace(0,15,15*reverse_gap+1)
  v=linspace(-15,15,30*reverse_gap+1)  ; connect to the return_vari function. follow the same start point
  xrange=[15,0]
  yrange=[15,-15]
  

  idx=where(data eq 0)
  data[idx]=!values.f_nan
  pos=set_plot_position(2,1,left=0.01,right=0.36,xgap=0.03,ygap=0.06,low=0.01,high=0.96)
  ;cgloadct,38;,/reverse
  ;cgloadct,72,/reverse
  ;  restore,'E:\OneDrive\IDLworks\Other\blue_white_red_256.ctl'
  ;  tvlct,r,g,b
  pos=pos[*,0,*]
  pos=reform(pos)

  ;str_element,extra,'title','test',/add
  str_element,opt_plot,'charsize',0.7,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'xticks',2,/add
  str_element,opt_plot,'xrange',xrange,/add
  str_element,opt_plot,'yrange',yrange,/add
  str_element,opt_plot,'xtitle','X(Re)',/add
  
  ;str_element,opt_bar,'position',[],/add
  str_element,opt_bar,'no_color_scale',0,/add
  str_element,opt_bar,'charsize',0.8,/add
  ;str_element,opt_bar,'title',bar_title,/add
  
  bottom=0
  ncolors=253
  cgloadct,34,ncolors=ncolors,bottom=bottom
  
  for i=0,1 do begin
    str_element,opt_bar,'title',bar_title[i],/add
 
     ; if i eq 1 then str_element,opt_bar,'no_color_scale',0,/add else str_element,opt_bar,'no_color_scale',1,/add
      str_element,opt_bar,'position',[pos[i,2]+0.02,pos[i,1],pos[i,2]+0.05,pos[i,3]],/add
      d={x:x,y:reform(data[*,i],15*reverse_gap,30*reverse_gap),v:v}
      color_fill,pos[i,*],d,xrange=xrange,yrange=yrange,zrange=zrange[*,i],top=255,bottom=0,backcolor='grey',opt_plot=opt_plot,opt_bar=opt_bar
     
  endfor                                                      ;[-0.3,0.3] thermal EFD range
  cgps_close
   stop
  end