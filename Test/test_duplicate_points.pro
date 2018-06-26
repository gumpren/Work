pro test_duplicate_points
  strr='_add_time_after_150_minutes_remove_duplicate_points'
  ; strr=''
  restore,'C:\__Data\Datasave\2001_2009_10minute_per_point\'+    $
    'time_interval_divided_by_Bz_yearly_normal_10minute_per_point'+strr+'.sav'
  g=0
  tbeg=t_beg[g]
  tend=t_end[g]

  tt=0
  indexx=where(tend-tbeg eq 10*60)
  for i=0,n_elements(tbeg)-1 do begin
    indexx=where(tend[i]-tbeg[i] eq 10*60)
    if indexx ne -1 then begin
      tt=tt+1
      ;stop
    endif

  endfor


  a=0
  b=0
  for i=0,n_elements(tbeg)-1 do begin
    indexx=where(tbeg[i] eq tbeg)
    if n_elements(indexx) gt 1  then begin
      b=b+1                                                      ; b eq duplicate begin
      if is_equal(tend[indexx[0]],tend[indexx[1]]) then begin
        a=a+1    ; a eq duplicate points
        ;stop
      endif
      ;stop
    endif
  endfor
  print,'g  ',g
  print,'b  ',b
  print,'a  ',a

  stop


end