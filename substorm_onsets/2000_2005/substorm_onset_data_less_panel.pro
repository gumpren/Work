pro substorm_onset_data_less_panel
  start=systime(1)
  root_Dir='C:\__Data\Datasave\substorm_onsets\2000_2005\'
  output_dir='E:\OneDrive\IDLworks\PS\substorm_onsets\2000_2005\'
  restore,root_dir+'substorm_onset_numbers_under_IMF_bz_lasttime_divided_by_10minutes_add_time_after_150_minutes_remove_duplicate_points_revised_tbeg0_add_AE_AU_AL.sav'
  
  onset_t_less=list(length=10)
  onset_mlt_less=list(length=10)
  onset_maglat_less=list(length=10)
  onset_last_time_less=list(length=10)
  AE_max_less=list(length=10)
  AU_max_less=list(length=10)
  AL_min_less=list(length=10)
 
  
  j_row=[1,3,5,8,14,16,18,20,23,29]
  j=0
  for i=0,29 do begin
    onset_t_temp=onset_t[i]
    onset_mlt_temp=onset_mlt[i]
    onset_maglat_temp=onset_maglat[i]
    onset_last_time_temp=onset_last_time[i]
    AE_max_temp=AE_max[i]
    AU_max_temp=AU_max[i]
    AL_min_temp=AL_min[i]
    
    append_Array,onset_t_less1,reform(onset_t_temp,(size(onset_t_temp))[1])
    append_Array,onset_mlt_less1,reform(onset_mlt_temp,(size(onset_mlt_temp))[1])
    append_Array,onset_maglat_less1,reform(onset_maglat_temp,(size(onset_maglat_temp))[1])
    append_Array,onset_last_time_less1,reform(onset_last_time_temp,(size(onset_last_time_temp))[1])
    append_Array,AE_max_less1,reform(AE_max_temp,(size(AE_max_temp))[1])
    append_Array,AU_max_less1,reform(AU_max_temp,(size(AU_max_temp))[1])
    append_Array,AL_min_less1,reform(AL_min_temp,(size(AL_min_temp))[1])
    
    if i eq j_row[j]  then begin
      onset_t_less[j]=onset_t_less1
      onset_mlt_less[j]=onset_mlt_less1
      onset_maglat_less[j]=onset_maglat_less1
      onset_last_time_less[j]=onset_last_time_less1
      AE_max_less[j]=AE_max_less1
      AU_max_less[j]=AU_max_less1
      AL_min_less[j]=AL_min_less1
      
      undefine,onset_t_less1,onset_mlt_less1,onset_maglat_less1,onset_last_time_less1,AE_max_less1,AU_max_less1,AL_min_less1
      j++
      print,i
    endif
   ; aa1[i]=n_elements(onset_t_less1)
  endfor

  save,onset_t_less,onset_mlt_less,onset_maglat_less,onset_last_time_less,AE_max_less,AU_max_less,AL_min_less,$
       filename=root_dir+'substorm_onset_data_less_panel.sav'

  stop




end