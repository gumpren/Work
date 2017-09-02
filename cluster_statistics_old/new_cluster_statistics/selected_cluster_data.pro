;pro selected_cluster_data
;  start=systime(1)
;  tic
;  
;  restore,'C:\__Data\Datasave\2001_2009_median_new\c3_cis_data_origin2001.sav'
;  restore,'C:\__Data\Datasave\2001_2009_median_new\c3_fgm_data_origin2001.sav'
;  tplot_restore,filenames='C:\__Data\Datasave\2001_2009_median_new\time_interval_BZgt0_duragt1hr.tplot'
;  get_data,'tbeg_BZgt0_duragt1hr',t,tbeg
;  get_data,'tend_BZgt0_duragt1hr',t,tend
;
;  store_data,'B_gse',data={x:t_c3fgm,y:temporary(B_gse)}
;  store_Data,'B_total',data={x:t_c3fgm,y:temporary(B_total)}
;  store_Data,'pos_gse',data={x:t_c3fgm,y:temporary(pos_gse)}
;  
;  store_Data,'density',data={x:t_c3cis,y:temporary(density)}
;  store_Data,'velocity_gse',data={x:t_c3cis,y:temporary(velocity_gse)}
;  store_Data,'temperature',data={x:t_c3cis,y:temporary(temperature)}
;  store_Data,'pressure',data={x:t_c3cis,y:temporary(pressure)}
;  
;;  tdeflag,'B_gse','remove_nan'
;;  tdeflag,'B_total','remove_nan'
;;  tdeflag,'pos_gse','remove_nan'
;;  
;;  tdeflag,'density','remove_nan'
;;  tdeflag,'velocity_gse','remove_nan'
;;  tdeflag,'temperature','remove_nan'
;;  tdeflag,'pressure','remove_nan'
;  
;
;  for ii=0,n_elements(tbeg)-1 do begin
;    
;    B_total_temp=tsample('B_total',[tbeg[ii],tend[ii]],times=t_c3fgm_temp)
;    B_gse_temp=tsample('B_gse',[tbeg[ii],tend[ii]],times=t_c3fgm_temp)
;    pos_gse_temp=tsample('pos_gse',[tbeg[ii],tend[ii]],times=t_c3fgm_temp)
;    
;    if is_array(B_total_temp) then begin
;      append_array,t_c3fgm,temporary(t_c3fgm_tmp)
;      append_array,B_total,temporary(B_total_tmp)
;      append_array,B_gse,temporary(B_gse_tmp)
;      append_array,pos_gse,temporary(pos_gse_tmp)
;    endif
;    
;    
;    density_temp=tsample('density',[tbeg[ii],tend[ii]],times=t_c3cis_temp)
;    velocity_gse_temp=tsample('velocity_gse',[tbeg[ii],tend[ii]],times=t_c3cis_temp)
;    temperature_temp=tsample('temperature',[tbeg[ii],tend[ii]],times=t_c3cis_temp)
;    pressure_temp=tsample('pressure',[tbeg[ii],tend[ii]],times=t_c3cis_temp)
;    
;     if is_array(density_tmp)  then begin
;      append_array,t_c3cis,temporary(t_c3cis_tmp)
;      append_array,density,temporary(density_tmp)
;      append_array,velocity_gse,temporary(velocity_gse_tmp)
;      append_array,temperature,temporary(temperature_tmp)
;      append_array,pressure,temporary(pressure_tmp)
;    endif
;    
;    toc
;  print,ii  
;  
;  
;  
;  endfor
;  
;  delete,'*'
;  
;  time_save_fgmcis=(systime(1)-start)/3600.0
;  print,time_save_fgmcis
;
;  save,time_save_fgmcis,t_c3fgm,t_c3cis,B_total,B_gse,pos_gse,density,velocity_gse,temperature,pressure,$
;    filename='C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_selected2001.sav',/compress
;
; 
;end  
  

;if is_array(density_tmp) and (t_c3cis_tmp[0] gt 0 )  then begin
;  ;      append_array,t_c3cis,t_c3cis_tmp
;  ;      append_array,density,density_tmp
;  ;      append_array,velocity_gse,velocity_gse_tmp
;  ;      append_array,temperature,temperature_tmp
;  ;      append_array,pressure,pressure_tmp
;  ;      ;t_c3cis=array_concat(t_c3cis_temp,t_c3cis)
;  ;      ;density=array_concat(density_temp,density)
;  ;;      velocity_gse=array_concat(velocity_gse_temp,velocity_gse)
;  ;;      temperature=array_concat(temperature_temp,temperature)
;  ;;      pressure=array_concat(pressure_temp,pressure)
;  ;    endif

 
pro selected_cluster_data
  
  Re=6371.0
  
  tplot_restore,filenames='C:\__Data\Datasave\2001_2009_median_new\time_interval_BZgt0_duragt1hr.tplot'
  get_data,'tbeg_BZgt0_duragt1hr',t,tbeg
  get_data,'tend_BZgt0_duragt1hr',t,tend

  
  for ii=0,n_elements(tbeg)-1 do begin
    tic
    year=time_string(tbeg[ii],pre=-5)
    date=time_string(tbeg[ii],pre=-3,format=2)
    date1=time_string(tend[ii],pre=-3,format=2)
    ;if strmid(date,4,2) eq '06'  then break
    ;if string(year) eq 2010 then break
    filename1=file_search('C:\__Data\Cluster\CP_FGM_SPIN\*'+year+'*.cdf')
    cdf2tplot,filename1[0],varformat=['B_mag__C3_CP_FGM_SPIN','B_vec_xyz_gse__C3_CP_FGM_SPIN','sc_pos_xyz_gse__C3_CP_FGM_SPIN']
    
    B_total_temp=tsample('B_mag__C3_CP_FGM_SPIN',[tbeg[ii],tend[ii]],times=t_c3fgm_temp)
    B_gse_temp=tsample('B_vec_xyz_gse__C3_CP_FGM_SPIN',[tbeg[ii],tend[ii]],times=t_c3fgm_temp)
    pos_gse_temp=tsample('sc_pos_xyz_gse__C3_CP_FGM_SPIN',[tbeg[ii],tend[ii]],times=t_c3fgm_temp)
   
    if is_array(B_gse_temp) then begin
;      t_c3fgm=array_concat(t_c3fgm_temp,t_c3fgm)
;      pos_gse=array_concat(pos_gse_temp,pos_gse)
;      B_gse=array_concat(B_gse_temp,B_gse)
;      B_total=array_concat(B_total_temp,B_total)
     
     append_Array,t_c3fgm,TEMPORARY(t_c3fgm_temp)
     append_Array,pos_gse,TEMPORARY(pos_gse_temp)
     append_Array,B_gse,TEMPORARY(B_gse_temp)
     append_Array,B_total,TEMPORARY(B_total_temp)
    endif
    
    if (strmid(date,6,2) ne strmid(date1,6,2)) then begin
      filename2_1=file_search('C:\__Data\Cluster\CIS\CSA\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*'+date+'*.cdf')
      filename2_2=file_search('C:\__Data\Cluster\CIS\CSA\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*'+date1+'*.cdf')
      filename2=[[filename2_1],[filename2_1]]
    endif else begin
      filename2=file_search('C:\__Data\Cluster\CIS\CSA\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*'+date+'*.cdf')
    endelse
      
  
    cdf2tplot,filename2,varformat=['density__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',$
      'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS','pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS']
    
    density_temp=tsample('density__C3_CP_CIS-HIA_ONBOARD_MOMENTS',[tbeg[ii],tend[ii]],times=t_c3cis_temp)
    velocity_gse_temp=tsample('velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',[tbeg[ii],tend[ii]],times=t_c3cis_temp)
    temperature_temp=tsample('temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS',[tbeg[ii],tend[ii]],times=t_c3cis_temp)
    pressure_temp=tsample('pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS',[tbeg[ii],tend[ii]],times=t_c3cis_temp)
    
    
    
    if is_array(density_temp) then begin
;      t_c3cis=array_concat(t_c3cis_temp,t_c3cis)
;      density=array_concat(density_temp,density)
;      velocity_gse=array_concat(velocity_gse_temp,velocity_gse)
;      temperature=array_concat(temperature_temp,temperature)
;      pressure=array_concat(pressure_temp,pressure)
      
      append_Array,t_c3cis,TEMPORARY(t_c3cis_temp)
      append_Array,density,TEMPORARY(density_temp)
      append_Array,velocity_gse,TEMPORARY(velocity_gse_temp)
      append_Array,temperature,TEMPORARY(temperature_temp)
      append_Array,pressure,TEMPORARY(pressure_temp)
    endif
     
    Delvar,'*'
    toc
  endfor
   
  
  
  store_Data,'B_total',data={x:t_c3fgm,y:B_total}
  store_Data,'B_gse',data={x:t_c3fgm,y:B_gse}
  store_Data,'pos_gse',data={x:t_c3fgm,y:pos_gse}
  store_Data,'density',data={x:t_c3cis,y:density}
  store_Data,'velocity_gse',data={x:t_c3cis,y:velocity_gse}
  store_Data,'temperature',data={x:t_c3cis,y:temperature}
  store_Data,'pressure',data={x:t_c3cis,y:pressure}
  
;  tplot_save,['B_total','B_gse','pos_gse','density','velocity_gse','temperature','pressure'],$
;    filename='C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_origin'
  
  save,B_total,B_gse,pos_gse,density,velocity_gse,temperature,pressure,$
  filename='C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_selected1.sav'
  
end  
  
  
  
;  filename2=file_search('C:\__Data\Cluster\CIS\CSA\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*.cdf')
;  for i=0,364 do begin
;   cdf2tplot,filename2[i],varformat=['density__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',$
;                        'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS','pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS']
;   
   
;   get_data,'density__C3_CP_CIS-HIA_ONBOARD_MOMENTS',t_c3cis_tmp,density_tmp
;   get_data,'velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',t_c3cis_tmp,velocity_gse_tmp
;   get_data,'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS',t_c3cis_tmp,temperature_tmp
;   get_data,'pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS',t_c3cis_tmp,pressure_tmp
;   t_c3cis=array_concat(t_c3cis_tmp,t_c3cis)
;   density=array_concat(density_tmp,density)
;   velocity_gse=array_concat(velocity_gse_tmp,velocity_gse)
;   temperature=array_concat(temperature_tmp,temperature)
;   pressure=array_concat(pressure_tmp,pressure)
;  endfor
;   t_c3cis[where(t_c3cis lt 0)]=!VALUES.F_NAN
;   
;   
;   
;;   cotrans,'B_gse','B_gsm',/gse2gsm
;;   cotrans,'velocity_gse','velocity_gsm',/gse2gsm
;   
;   store_data,'fgm_B_POS',data={x:t_c3fgm,y:[[B_gsm],[position]]}
;   tinterpol_mxn,{x:t_c3cis,y:pressure},{x:t_c3fgm,y:B_gse}


  