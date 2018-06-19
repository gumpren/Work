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




  ;
  ;  for ii=0,5 do begin   ;2000_2005
  ;    year='200'+strcompress(ii,/remove)
  ;    index_target=strfilter(time_string(onset_time,pre=-5),year,count=count_target,/index)
  ;
  ;    for jj=0,count_target-1 do begin
  ;      for kk=0,29 do begin
  ;        tbeg=t_beg[kk]
  ;        tend=t_end[kk]
  ;        index_terval=strfilter(time_string(tend,pre=-5),year,count=count_terval,/index)
  ;        indexx=where(onset_time[index_target[jj]] gt tbeg[index_terval] and onset_time[index_target[jj]] lt tend[index_terval])
  ;
  ;        if indexx ne -1 then break
  ;
  ;      endfor
  ;
  ;      if indexx ne -1 then stop
  ;
  ;    endfor
  ;
  ;
  ;
  ;
  ;
  ;
  ;  endfor
  ;
  ;  stop

  onset_t=list(length=30)
  onset_last_time=list(length=30)
  t_last_beg=list(length=30)
  for ii = 0, 29 do begin
    if (ii ge 0) and (ii le 14)  then t_last_beg[ii]=(ii*10)
    if (ii ge 15) and (ii le 29)  then t_last_beg[ii]=((ii-15)*10)
  endfor


  for ii=29,0,-1 do begin     ;
    tbeg=t_beg[ii]
    tend=t_end[ii]

    for jj=0,5 do begin   ;2000_2005
      year='200'+strcompress(jj,/remove)
      
      index_target=strfilter(time_string(onset_time,pre=-5),year,count=count_target,/index)
      index_terval=strfilter(time_string(tend,pre=-5),year,count=count_interval,/index)
      
      for kk =0, count_target-1 do begin
       indexx=where(onset_time[index_target[kk]] gt tbeg[index_terval]+t_last_beg[ii]   $
                and onset_time[index_target[kk]] lt tend[index_terval])
       if (indexx ne -1) then  begin
        append_array,onset_t1,onset_time[index_target[kk]]
        append_array,onset_last_time1,onset_time[index_target[kk]]-(tbeg[index_terval])[indexx]
        
       endif
      endfor


      for jj=0,count-1 do begin
        
          append_Array,B_total,TEMPORARY(B_total_temp)
   
      endfor

      print,(systime(1)-start)/60.
      print,'break1'

      append_Array,E_gsm1,TEMPORARY(E_gsm)

      del_data,'*'
      print,ii

    endfor

    save,t_c3cis1,t_last1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,Beta1,E_gsm1,$;$
      filename=root_dir+'c3_fgmcisefw_data_selected_10minute_per_point_add_time_after_150_minutes'+names[ii]+'.sav'

    undefine,t_c3cis1,B_total1,B_gsm1,pos_gsm1,density1,velocity_gsm1,temperature1,pressure1,beta1
    undefine,E_gsm1,t_last1,t_last_ture1;,tt_bbf_save
  
    print,(systime(1)-start)/60.
    print,jj
  endfor

  save_time_c3fgmcis=(systime(1)-start)/3600.0
  print,'save_time ',save_time_c3fgmcis,' hour'

  stop



end
