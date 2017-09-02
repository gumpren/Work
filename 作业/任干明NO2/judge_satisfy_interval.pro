pro judge_satisfy_interval,judge_value,condition,start_point,terminal_point

number=n_elements(judge_value)
index=where(judge_value gt condition[0] and judge_value le condition[1])
satisfy_number=n_elements(index)
satisfy_interval=fltarr(satisfy_number)-100
satisfy_interval(0)=index(0)
j=1
for i=1,satisfy_number-1 do begin
  if (index(i)-index(i-1) ne 1) then begin
    satisfy_interval(j)=index(i-1)
    satisfy_interval(j+1)=index(i)
    j= j+2
  endif
  satisfy_interval(j)=index(satisfy_number-1)
endfor

index0=where(satisfy_interval ge 0)
row=n_elements(index0)/2
start_point=fltarr(row)
terminal_point=fltarr(row)
for i=0,row-1 do begin
  start_point[i]=satisfy_interval[2*i]
  terminal_point[i]=satisfy_interval[2*i+1]+1
endfor
  
end