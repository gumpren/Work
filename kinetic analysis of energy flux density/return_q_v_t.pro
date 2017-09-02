Function return_Q_v_T,variable,Vx,T   ;there is a position mistake when the gap is 0.67 or 5.0/7.0

  event_vari=fltarr(120)
  ii=-400 & jj=10
  for kk=0,119 do begin
    index=where((Vx ge ii) and (Vx lt ii+200.0) and (T ge jj) and (T lt jj+5.0))
    if((index[0] ne -1)) then  event_vari[kk]=median(variable[index]);/eventimes[kk]
    ii=ii+200.0
    if(ii ge 1600.0) then begin
      ii=-200
      jj=jj+5.0
    endif
    ; help,(variable[index_1])
    ; print,index_ps
  endfor
  event_vari=reform(event_vari,10,12)
  return,event_vari
end
