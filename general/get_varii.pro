function get_varii,vari,log=log
   if ~keyword_set(log) then log=0
   if (log ne 0) then begin
     varilt0=where(vari lt 0)
     if(varilt0[0] eq -1) then begin
      vari=alog10(vari)
     endif else begin
      vari1=-vari[varilt0]
      vari2=vari[where(vari gt 0)]
      vari=[-alog10(vari1),alog10(vari2)]
     endelse
     
   endif else begin
     vari=vari
   endelse
   return,vari
end