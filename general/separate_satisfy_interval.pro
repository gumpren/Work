pro separate_satisfy_interval,judge_value,start_point,terminal_point

  number=n_elements(judge_value)
  
  satisfy_interval=dblarr(number)-1.0e10
  satisfy_interval(0)=judge_value(0)
  j=1
  for i=1,number-1 do begin
    if (judge_value(i)-judge_value(i-1) gt 5.0) then begin
      satisfy_interval(j)=judge_value(i-1)
      satisfy_interval(j+1)=judge_value(i)
      j= j+2
    endif
    satisfy_interval(j)=judge_value(number-1)
  endfor
  
  judge_value0=where(satisfy_interval ge 0)
  row=n_elements(judge_value0)/2
  start_point=dblarr(row)
  terminal_point=dblarr(row)
  for i=0,row-1 do begin
    start_point[i]=satisfy_interval[2*i]
  ;  terminal_point[i]=satisfy_interval[2*i+1]+1
    terminal_point[i]=satisfy_interval[2*i+1]
  endfor 

end