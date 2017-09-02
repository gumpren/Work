function return_vari_event,x_pos,y_pos,variable
   event_vari=fltarr(432)
  ; eventimes=reform(eventimes,300,1)
  ii=-20 & jj=-15
  for kk=0,431 do begin
    index_ps=where((x_pos ge ii) and (x_pos lt ii+5.0/6.0) and (y_pos ge jj) and (y_pos lt jj+5.0/6.0))
    if((index_ps[0] ne -1)) then begin
      if (n_elements(variable) eq 0) then begin
       event_vari[kk]=n_elements(index_ps)
      endif else begin
       event_vari[kk]=median(variable[index_ps]) ;/eventimes[kk]
      endelse
    endif
    
    ii=ii+5.0/6.0
    if(ii ge -10) then begin
      ii=-20
      jj=jj+5.0/6.0
    endif
    ; help,(variable[index_1])
    ; print,index_ps
  endfor
  event_vari=reform(event_vari,12,36)
  return,event_vari
  
  
 
end