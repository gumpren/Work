;Function neighbor_time,t1,t2,detat         ;version 3
;  if N_ELEMENTS(detat) eq 0 then detat=2.0d/60
;  index = -1
;  n1 = n_elements(t1)
;  n2 = n_elements(t2)
;  If(n1 Eq 0 Or n2 Eq 0) Then Return, index
;  in_arr2 = bytarr(n1)
;  
;  FOR j = 0l, n1-1 DO BEGIN
;    ok = where(abs(t2-t1[j]) lt detat)
;    IF(ok(0) NE -1) THEN BEGIN
;      in_arr2[j] = 1b
;    ENDIF
;  ENDFOR
;  index=where(in_arr2 eq 1)
; RETURN, index
;end

Function neighbor_time,t1,t2,detat                   ;version 2   
  if N_ELEMENTS(detat) eq 0 then detat=2.0d/60
  t2_new=t2
  index1=0
  t_need=0
  for i = 0L, N_ELEMENTS(t1)-1 do begin

    dt=abs(t2_new-t1[i])
    indext=where(dt lt detat) 
   
    if( n_elements(indext) ne 1) then indext=indext[0] ;to make indext an one element array
    if(indext ne -1) then begin
      t2_new=t2_new[indext:n_elements(t2_new)-1]    ;to start finding index in indext, decreasing calculation amount especially in big t2 
      
      index1=indext+index1
      
      ;  if(indext eq -1) then continue
      if (i eq 0)  then begin
        t_need=index1
      endif else begin
        t_need=[t_need,index1]
      endelse
     endif 
   
  endfor
  
     tindex=where(abs(t1-t2[(t_need[0])]) le detat)
     if tindex eq -1  then t_need=t_need[1:n_elements(t_need)-1];to void t_need[0]=0 being excluded
     
;     if t_need[0] eq 0  then t_need[0]=-50   ;to void t_need[0]=0 being excluded
;     t_need=t_need[where(t_need ne 0)]                                             former wrong version
;     if t_need[0] eq -50 then t_need[0]=0   ;to void t_need[0]=0 being excluded
       
  return,t_need
end


; Function neighbor_time,t1,t2,detat              version 1
;  if N_ELEMENTS(detat) eq 0 then detat=2.0d/60
;
;  for i = 0L, N_ELEMENTS(t1)-1 do begin
;    dt=abs(t2-t1[i])
;    indext=where(dt lt detat)
;   ; if(indext ne -1) then t2=t2[indext:n_elements(t2)-1]
;
;    if (i eq 0)  then begin
;      t_need=indext
;    endif else begin
;      t_need=[t_need,indext]
;    endelse
;
;  endfor
;
;  return,t_need
;end