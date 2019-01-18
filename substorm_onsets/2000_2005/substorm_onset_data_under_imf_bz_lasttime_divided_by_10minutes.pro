Pro substorm_onset_data_under_IMF_bz_lasttime_divided_by_10minutes
  
  start=systime(1)
  root_Dir='C:\__Data\Datasave\substorm_onsets\2000_2005\'
  output_dir='E:\OneDrive\IDLworks\PS\substorm_onsets\2000_2005\'
  restore,root_dir+'substorm_onsets_location_modified_timing.sav'
  restore,root_dir+'time_interval_divided_by_Bz_2000_2010_yearly_normal_10minute_per_point_add_time_after_150_minutes_remove_duplicate_points_revised_tbeg0.sav'
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
  
  ; remove dupilacte onset time
;  tindex=uniq(onset_time)
;  onset_time=onset_time[tindex]
;  mltime=mltime[tindex]
;  maglat=maglat[tindex]
  
      
  onset_t=list(length=30)
  onset_last_time=list(length=30)
  t_last_beg=list(length=30)
  onset_mlt=list(length=30)
  onset_maglat=list(length=30)
  AE_max=list(length=30)
  AU_max=list(length=30)
  AL_min=list(length=30)


  for ii = 0, 29 do begin
    if (ii ge 0)  and (ii le 14)   then t_last_beg[ii]=(ii*10)
    if (ii ge 15) and (ii le 29 )  then t_last_beg[ii]=((ii-15)*10)
  endfor
   
;  onset_list=list(length=n_elements(onset_time))
;  for i=0,n_elements(onset_time)-1 do begin
;    onset_list[i]=onset_time[i]
;  endfor
;  
;  onset_list.remove,2752
;  
;  gapt=dblarr(n_elements(onset_list)-1)
;  for i=0,n_elements(onset_list)-2 do begin
;    gapt[i]=(onset_list[i+1]-onset_list[i])/60.0
;  endfor

  
;    for ii=0,5 do begin   ;2000_2005
;      year='200'+ strcompress(ii,/remove)
;      index_target=strfilter(time_string(onset_time,pre=-5),year,count=count_target,/index)
;  
;      for jj=0,count_target-1 do begin
;        for kk=0,29 do begin
;          tbeg=t_beg[kk]
;          tend=t_end[kk]
;          index_terval=strfilter(time_string(tend,pre=-5),year,count=count_terval,/index)
;          indexx=where(onset_time[index_target[jj]] gt tbeg[index_terval]+t_last_beg[ii]*60.0 and onset_time[index_target[jj]] lt tend[index_terval])
;  
;          if indexx ne -1 then stop
;  
;        endfor
;  
;        if indexx ne -1 then stop
;  
;      endfor
;  
;  
;  
;  
;  
;  
;    endfor
;  
;    stop
  


  total=0
  for ii=29,0,-1 do begin     ;
    tbeg=t_beg[ii]
    tend=t_end[ii]
    
    for jj=0,5 do begin   ;2000_2005
      year='200'+strcompress(jj,/remove)
      
      index_target=strfilter(time_string(onset_time,pre=-5),year,count=count_target,/index)
      index_terval=strfilter(time_string(tend,pre=-5),year,count=count_interval,/index)
      
      for kk =0, count_target-1 do begin
       indexx=where(onset_time[index_target[kk]] gt tbeg[index_terval]+t_last_beg[ii]*60.0   $
                and onset_time[index_target[kk]] le tend[index_terval])
       if (indexx[0] ne -1) then  begin
         tb=onset_time[index_target[kk]]
         tb_str=time_string(tb,precision=-4,format=2)
         
         if kk lt count_target-1 then begin
          te=min([onset_time[index_target[kk]]+2*60*60,onset_time[index_target[kk+1]]]); 2 hours long but no interaction with next substorm
         endif else begin
          te=onset_time[index_target[kk]]+2*60*60
         endelse  
         te_str=time_string(te,precision=-4,format=2)
         
         filename1=file_search('C:\__Data\OMNI\*'+tb_str+'*.cdf')
         filename2=file_search('C:\__Data\OMNI\*'+te_str+'*.cdf')
         if ( (filename1 eq filename2) eq 1b) then begin
           filename=filename1
         endif else begin
           filename=[filename1,filename2]
         endelse
         cdf2tplot,filename,varformat=['BZ_GSM','AE_INDEX','AL_INDEX','AU_INDEX']
         AE_temp=tsample('AE_INDEX',[tb,te],times=t_omni_temp)
         AU_temp=tsample('AU_INDEX',[tb,te],times=t_omni_temp)      
         AL_temp=tsample('AL_INDEX',[tb,te],times=t_omni_temp)

        
        total=total+1
        append_array,onset_t1,onset_time[index_target[kk]]
        append_array,onset_last_time1,onset_time[index_target[kk]]-(tbeg[index_terval])[indexx[0]] 
        append_array,onset_mlt1,mltime[index_target[kk]]
        append_Array,onset_maglat1,maglat[index_target[kk]]  
        append_array,AE_max1,max(AE_temp)  
        append_array,AU_max1,max(AU_temp)
        append_array,AL_min1,min(AL_temp)  
     ;   if total eq 40 then stop
       endif
      endfor
    ;  stop
      
    endfor
    
    onset_t[ii]=onset_t1
    onset_last_time[ii]=onset_last_time1
    onset_mlt[ii]=onset_mlt1
    onset_maglat[ii]=onset_maglat1
    AE_max[ii]=AE_max1
    AU_max[ii]=AU_max1
    AL_min[ii]=AL_min1
    undefine,onset_t1,onset_last_time1,onset_mlt1,onset_maglat1,AE_max1,AU,_max1,AL_min1
  
    
    
  endfor
  
  print,(systime(1)-start)/60.0
   stop
  
  at=0
  for ii=0,29 do begin
    ad=n_elements(onset_t[ii])
    at=at+ad
  endfor

 ;  stop
  
  save,onset_t,onset_mlt,onset_maglat,onset_last_time,AE_max,AU_max,AL_min,filename=root_dir+   $
  'substorm_onset_numbers_under_IMF_bz_lasttime_divided_by_10minutes_add_time_after_150_minutes_remove_duplicate_points_revised_tbeg0_add_AE_AU_AL.sav'
  save_time_c3fgmcis=(systime(1)-start)/3600.0
  print,'save_time ',save_time_c3fgmcis,' hour'
  
  stop
  
  
end
