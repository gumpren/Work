;
;Function return_vari,variable,index,x_pos,y_pos,eventimes
;  event_vari=dblarr(10,30)   
;  for ii=-20,-11 do begin 
;    for jj=-15,14 do begin
;      variable[where(~finite(variable))]=0; 
;      for kk=0,n_elements(index)-1 do begin  
;        app=calposition((x_pos[index])[kk],(y_pos[index])[kk],ii,jj) 
;        if(eventimes[ii+20,jj+15] ne 0)  then  event_vari[ii+20,jj+15]=event_vari[ii+20,jj+15]+(variable[kk])*app/eventimes[ii+20,jj+15]
;      endfor
;    endfor
;  endfor
;  
;  return,event_vari
;
;end

Function return_vari,variable,index,x_pos,y_pos   ;there is a position mistake when the gap is 0.67 or 5.0/7.0
  ;variable[where(~finite(variable))]=0
  event_vari=fltarr(432)
 ; eventimes=reform(eventimes,300,1)
  ii=-20 & jj=-15
  for kk=0,431 do begin
   index_ps=where((x_pos[index] ge ii) and (x_pos[index] lt ii+5.0/6.0) and (y_pos[index] ge jj) and (y_pos[index] lt jj+5.0/6.0))
   if((index_ps[0] ne -1)) then  event_vari[kk]=median(variable[index_ps]);/eventimes[kk]
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
 