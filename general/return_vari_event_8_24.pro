function return_vari_event_8_24,x_pos,y_pos,variable,reverse_gap,type
  if n_elements(type) eq 0 then type=1
  event_vari=fltarr(192*reverse_gap^2)
  ; eventimes=reform(eventimes,300,1)
  ii=-18 & jj=-12
  for kk=0,192*reverse_gap^2-1 do begin
    index_ps=where((x_pos ge ii) and (x_pos lt ii+1/reverse_gap) and (y_pos ge jj) and (y_pos lt jj+1/reverse_gap))
    if((index_ps[0] ne -1)) then begin
      if (variable eq []) then begin
        event_vari[kk]=n_elements(index_ps)
      endif else begin
        case type of
          1: event_vari[kk]=median(variable[index_ps])
          2: event_vari[kk]=mean(variable[index_ps])
        endcase

      endelse
    endif

    ii=ii+1/reverse_gap
    if(ii ge -10) then begin
      ii=-18
      jj=jj+1/reverse_gap
    endif
    ; help,(variable[index_1])
    ; print,index_ps
  endfor
  event_vari=reform(event_vari,8*reverse_gap,24*reverse_gap)
  return,event_vari



end