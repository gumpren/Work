  function identify_plasma_sheet,xgsm,ygsm,zgsm,form
   if n_elements(form) eq 0 then form=1
  ; if( reform(abs(zgsm))  le 6.0) then begin
  ; index1=where((xgsm le -10.0) and (abs(ygsm) le 15.0) and (abs(zgsm) le 6.0))
  ; endif else begin
   index1=where(((xgsm le -10.0) and (abs(ygsm) le 15.0) and (abs(zgsm) le 6.0)) or ((xgsm le -10.0) and  sqrt(ygsm^2+zgsm^2) le 10.0 and (abs(zgsm) gt 6.0)))
  ; endelse
   index2=where((xgsm le -10.0) and (abs(ygsm) le 15.0) and (abs(zgsm) le 0.5))
  ; index=index1 or index2
   index3=where((xgsm ge 0.0) and (xgsm le 15.0) and (abs(ygsm) le 15.0) and (abs(zgsm) le 0.5) and (sqrt(ygsm^2+xgsm^2) ge 5.0))
   case form of
     1:return,index1
     2:return,index2
     3:return,index3
   endcase

    
 end 
 