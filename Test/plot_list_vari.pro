PRO PLOT_LIST_VARI
  root_Dir='C:\__Data\Datasave\substorm_onsets\2000_2005\'
  restore,root_dir+'substorm_onset_numbers_under_IMF_bz_lasttime_divided_by_10minutes_add_time_after_150_minutes_remove_duplicate_points_revised_tbeg0_add_AE_AU_AL.sav'

  for i=0,29 do begin
    cgdisplay
    window,i
    cgplot,onset_mlt[i],ytitle=strcompress(i)
    
    
  endfor
  stop



END