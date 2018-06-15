Pro substorm_onset_numbers_under_IMF_bz_lasttime_divided_by_10minutes
  
  root_Dir='C:\__Data\Datasave\substorm_onsets\2000_2005\'
  output_dir='E:\OneDrive\IDLworks\PS\substorm_onsets\2000_2005\'
  restore,root_dir+'substorm_onsets_location.sav'
  restore,root_dir+'time_interval_divided_by_Bz_2000_2010_yearly_normal_10minute_per_point_add_time_after_150_minutes.sav'
  names=strarr(30)
  for kk=0,29 do begin
    if kk le 14 then begin
      bz='_BZgt0_'
      te=strcompress((kk+1)*10,/remove)
    endif else begin
      bz='_BZle0_'
      te=strcompress((kk+1-15)*10,/remove)
    endelse

    if kk lt 1 then tb='00'+strcompress(kk*10,/remove)
    if kk ge 1 and kk lt 10 then tb='0'+strcompress(kk*10,/remove)
    if kk ge 10 and kk le 14  then tb=strcompress(kk*10,/remove)

    if kk ge 15 and kk lt 15+1 then tb='00'+strcompress((kk-15)*10,/remove)
    if kk ge 15+1 and kk lt 15+10 then tb='0'+strcompress((kk-15)*10,/remove)
    if kk ge 15+10 and kk le 15+14 then tb=strcompress((kk-15)*10,/remove)

    names[kk]=bz+tb+'_'+te
  endfor
  
  
  
  
  
  for ii=0,5 do begin   ;2000_2005
    year='200'+strcompress(ii,/remove)  
    index_target=strfilter(time_string(onset_time,pre=-5),year,count=count_target,/index)
    
    for jj=0,count_target-1 do begin
      for kk=0,29 do begin
        tbeg=t_beg[jj]
        tend=t_end[jj]
        index_terval=strfilter(time_string(tend,pre=-5),year,count=count_terval,/index)
        indexx=where(onset_time[index_target[jj]] gt tbeg[index_terval] and onset_time[index_target[jj]] lt tend[index_terval])
        
        if indexx ne -1 then break 
                
      endfor
      
      if indexx ne -1 then stop
      
    endfor

    
    
    
  
 
  endfor
  
  stop
  
  
  
  
  
  
  
  
  
  

  for kk=29,0,-1 do begin     ;
    tbeg=t_beg[kk]
    tend=t_end[kk]

    for ii=0,5 do begin   ;2000_2005
      year='200'+strcompress(ii,/remove)
      
      index_target=strfilter(time_string(onset_time,pre=-5),year,count=count,/index)
      index_terval=strfilter(time_string(tend,pre=-5),year,count=count,/index)

      for jj=0,count-1 do begin
        tic

        B_total_temp=tsample('B_total_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
        B_gsm_temp=tsample('B_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
        pos_gsm_temp=tsample('pos_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3fgm_temp)
        ;attention!!!selcet bbf  change this tplot variable

        if is_array(B_gsm_temp) then begin
          t_last_temp=(t_c3fgm_temp-tbeg[(index_terval[jj])])/60.0;+last_time_beg[kk]
          append_Array,t_last,TEMPORARY(t_last_temp)
          append_Array,t_c3fgm,TEMPORARY(t_c3fgm_temp)
          append_Array,pos_gsm,TEMPORARY(pos_gsm_temp)
          append_Array,B_gsm,TEMPORARY(B_gsm_temp)
          append_Array,B_total,TEMPORARY(B_total_temp)

        endif


        density_temp=tsample('density_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
        velocity_gsm_temp=tsample('velocity_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
        temperature_temp=tsample('temperature_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
        pressure_temp=tsample('pressure_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)
        Beta_temp=tsample('Beta_clip_deflag_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3cis_temp)

        if is_array(density_temp) then begin
          append_Array,t_c3cis,TEMPORARY(t_c3cis_temp)
          append_Array,density,TEMPORARY(density_temp)
          append_Array,velocity_gsm,TEMPORARY(velocity_gsm_temp)
          append_Array,temperature,TEMPORARY(temperature_temp)
          append_Array,pressure,TEMPORARY(pressure_temp)
          append_Array,Beta,TEMPORARY(Beta_temp)
        endif

        E_gsm_temp=tsample('E_gsm_interp',[tbeg[(index_terval[jj])],tend[(index_terval[jj])]],times=t_c3efw_temp)
        if is_array(E_gsm_temp) then begin
          append_Array,t_c3efw,TEMPORARY(t_c3efw_temp)
          append_Array,E_gsm,TEMPORARY(E_gsm_temp)
        endif

        print,jj
        toc

      endfor

      print,(systime(1)-start)/60.
      print,'break1'

      if is_array(t_last) then begin

        append_Array,t_last1,TEMPORARY(t_last)
        append_Array,t_c3fgm1,TEMPORARY(t_c3fgm)
        append_Array,pos_gsm1,TEMPORARY(pos_gsm)
        append_Array,B_gsm1,TEMPORARY(B_gsm)
        append_Array,B_total1,TEMPORARY(B_total)

        append_Array,t_c3cis1,TEMPORARY(t_c3cis)
        append_Array,density1,TEMPORARY(density)
        append_Array,velocity_gsm1,TEMPORARY(velocity_gsm)
        append_Array,temperature1,TEMPORARY(temperature)
        append_Array,pressure1,TEMPORARY(pressure)
        append_Array,Beta1,TEMPORARY(Beta)

        append_Array,t_c3efw1,TEMPORARY(t_c3efw)
        append_Array,E_gsm1,TEMPORARY(E_gsm)

      endif
      del_data,'*'
      print,ii

    endfor

    if is_array(t_c3cis1) then begin
      save,t_c3cis1,t_last1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,Beta1,E_gsm1,$;$
        filename=root_dir+'c3_fgmcisefw_data_selected_10minute_per_point_add_time_after_150_minutes'+names[kk]+'.sav'

      undefine,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,beta1
      undefine,E_gsm1,t_last1,t_last_ture1;,tt_bbf_save
    endif
    print,(systime(1)-start)/60.
    print,jj
  endfor

  save_time_c3fgmcis=(systime(1)-start)/3600.0
  print,'save_time ',save_time_c3fgmcis,' hour'

  stop








end
