

;Function return_eventimes,index,x_pos,y_pos
;  eventimes=dblarr(10,30)
;  for ii=-20,-11 do begin
;    for jj=-15,14 do begin
;      for kk=0,n_elements(index)-1 do begin
;        eventimes[ii+20,jj+15]=eventimes[ii+20,jj+15]+calposition((x_pos[index])[kk],(y_pos[index])[kk],ii,jj)
;      endfor 
;    endfor
;  endfor
;  return,eventimes
;
;end


Function return_eventimes,index,x_pos,y_pos
  ;variable[where(~finite(variable))]=0
  event_times=fltarr(432)

  ii=-20 & jj=-15
  for kk=0,431 do begin
    index_ps=where((x_pos[index] ge ii) and (x_pos[index] lt ii+5.0/6.0) and (y_pos[index] ge jj) and (y_pos[index] lt jj+5.0/6.0))
    if((index_ps[0] ne -1) ) then  event_times[kk]=n_elements(index_ps);/eventimes[kk]
    ii=ii+5.0/6.0
    if(ii ge -10) then begin
      ii=-20
      jj=jj+5.0/6.0
    endif
  endfor
  event_times=reform(event_times,12,36)
  return,event_times
  print,index_ps
end






;;for
;Function return_eventimes,index,x_pos,y_pos,z_pos
;
;  eventimes=fltarr(10,20)
;
;  for ii=-10,-1 do begin
;    for jj=-10,9 do begin
;      for kk=0,n_elements(index)-1l do begin
;        if  (abs((z_pos[index])[kk]) lt 5.0) and ((x_pos[index])[kk] gt 2*ii) and ((x_pos[index])[kk] le 2*(ii+1)) and ((y_pos[index])[kk] gt 2*jj) and ((y_pos[index])[kk] le 2*(jj+1)) then eventimes[ii+10,jj+10]++
;      endfor
;    endfor
;  endfor
;
;  return,eventimes
;
; end