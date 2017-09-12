pro selected_cluster_data_yearly
    start=systime(1)
    Re=6371.0
    jj=0
    restore,'C:\__Data\Datasave\2001_2009_median_new\time_interval_divided_by_Bz.sav'
  
    for kk=0 ,0 do begin
      case kk  of
        0:begin
        tbeg=t_beg.tbeg1
        tend=t_end.tend1
      end
      1:begin
      tbeg=t_beg.tbeg2
      tend=t_end.tend2
    end
    2:begin
    tbeg=t_beg.tbeg3
    tend=t_end.tend3
  end
  3:begin
  tbeg=t_beg.tbeg4
  tend=t_end.tend4
  end
  endcase
  names=['_BZgt0_duragt1hr','_BZgt0_durale1hr','_BZle0_duragt1hr','_BZle0_durale1hr']
  
  a=time_string(tbeg,pre=-5)
  b=time_string(tend,pre=-5)
  index=where(a eq b)
  
  
  for ii=0,8 do begin
    year='200'+strcompress(ii+1,/remove)
  
  
    filename1=file_search('C:\__Data\Cluster\CP_FGM_SPIN\*__'+year+'*.cdf')
    cdf2tplot,filename1,varformat= $
      ['B_mag__C3_CP_FGM_SPIN','B_vec_xyz_gse__C3_CP_FGM_SPIN','sc_pos_xyz_gse__C3_CP_FGM_SPIN']
  
  
    filename2=file_search('C:\__Data\Cluster\CIS\C3_CP_CIS-HIA_ONBOARD_MOMENTS\*__'+year+'*.cdf')
    cdf2tplot,filename2,varformat=['density__C3_CP_CIS-HIA_ONBOARD_MOMENTS','velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',$
      'temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS','pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS']
  
  
    index=strfilter(time_string(tend,pre=-5),year,count=count,/index)
  
    for jj=index[0],index[count-1] do begin
      tic
      B_total_temp=tsample('B_mag__C3_CP_FGM_SPIN',[tbeg[jj],tend[jj]],times=t_c3fgm_temp)
      B_gse_temp=tsample('B_vec_xyz_gse__C3_CP_FGM_SPIN',[tbeg[jj],tend[jj]],times=t_c3fgm_temp)
      pos_gse_temp=tsample('sc_pos_xyz_gse__C3_CP_FGM_SPIN',[tbeg[jj],tend[jj]],times=t_c3fgm_temp)
  
      if is_array(B_gse_temp) then begin
        append_Array,t_c3fgm,TEMPORARY(t_c3fgm_temp)
        append_Array,pos_gse,TEMPORARY(pos_gse_temp)
        append_Array,B_gse,TEMPORARY(B_gse_temp)
        append_Array,B_total,TEMPORARY(B_total_temp)
      endif
  
  
      density_temp=tsample('density__C3_CP_CIS-HIA_ONBOARD_MOMENTS',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
      velocity_gse_temp=tsample('velocity_gse__C3_CP_CIS-HIA_ONBOARD_MOMENTS',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
      temperature_temp=tsample('temperature__C3_CP_CIS-HIA_ONBOARD_MOMENTS',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
      pressure_temp=tsample('pressure__C3_CP_CIS-HIA_ONBOARD_MOMENTS',[tbeg[jj],tend[jj]],times=t_c3cis_temp)
  
      if is_array(density_temp) then begin
        append_Array,t_c3cis,TEMPORARY(t_c3cis_temp)
        append_Array,density,TEMPORARY(density_temp)
        append_Array,velocity_gse,TEMPORARY(velocity_gse_temp)
        append_Array,temperature,TEMPORARY(temperature_temp)
        append_Array,pressure,TEMPORARY(pressure_temp)
      endif
  
  
      print,jj
      toc
    endfor
  
    append_Array,t_c3fgm1,TEMPORARY(t_c3fgm)
    append_Array,pos_gse1,TEMPORARY(pos_gse)
    append_Array,B_gse1,TEMPORARY(B_gse)
    append_Array,B_total1,TEMPORARY(B_total)
  
    append_Array,t_c3cis1,TEMPORARY(t_c3cis)
    append_Array,density1,TEMPORARY(density)
    append_Array,velocity_gse1,TEMPORARY(velocity_gse)
    append_Array,temperature1,TEMPORARY(temperature)
    append_Array,pressure1,TEMPORARY(pressure)
  
    del_data,'*'
    print,ii
  
  endfor
  
  
  save_time_c3fgmcis=(systime(1)-start)/3600.0
  print,'save_time ',save_time_c3fgmcis,' hour'
  
  save_time_c3fgmcis=strcompress(save_time_c3fgmcis,/remove)+' hours'
  
  save,save_time_c3fgmcis,t_c3fgm1,t_c3cis1,B_total1,B_gse1,pos_gse1,density1,velocity_gse1,temperature1,pressure1,$
    filename='C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_selected_'+names[kk]+'_yearly.sav'
  
  ;t_c3fgm1=!null
  ;t_c3cis1=!null
  ;B_total1=!null
  ;B_gse1=!null
  ;pos_gse1=!null
  ;density1=!null
  ;velocity_gse1=!null
  ;temperature1=!null
  ;pressure1=!null
  
  undefine,t_c3fgm1,t_c3cis1,B_total1,B_gse1,pos_gse1,density1,velocity_gse1,temperature1,pressure1
  endfor
  
    stop
end
  
  
  ;  store_Data,'B_total',data={x:t_c3fgm,y:B_total}
  ;  store_Data,'B_gse',data={x:t_c3fgm,y:B_gse}
  ;  store_Data,'pos_gse',data={x:t_c3fgm,y:pos_gse}
  ;  store_Data,'density',data={x:t_c3cis,y:density}
  ;  store_Data,'velocity_gse',data={x:t_c3cis,y:velocity_gse}
  ;  store_Data,'temperature',data={x:t_c3cis,y:temperature}
  ;  store_Data,'pressure',data={x:t_c3cis,y:pressure}
  ;
  ;  tplot_save,['B_total','B_gse','pos_gse','density','velocity_gse','temperature','pressure'],$
  ;    filename='C:\__Data\Datasave\2001_2009_median_new\c3_fgmcis_data_origin'
