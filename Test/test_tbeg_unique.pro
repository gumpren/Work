pro test_tbeg_unique
   restore,  'C:\__Data\Datasave\2001_2009_10minute_per_point\'    + $                                                       + $
      'time_interval_divided_by_Bz_yearly_normal_10minute_per_point_add_time_after_150_minutes.sav'
   
;   for i=0,29 do begin
;    append_array,tbeg,t_beg[i]
;    
;   endfor
   
   tbeg=[t_beg[13],t_beg[14]]
   
   aa=uniq(tbeg)
   stop




end