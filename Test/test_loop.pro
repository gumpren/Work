pro test_loop
 aa=findgen(42)
 for jj=0,41 do begin
  if (jj le 10 or (jj ge 21 and jj le 31)) then begin;( jj ge 0 and jj le 10) and
     aa[jj]=0
  endif else begin
     aa[jj]=1
    
  endelse
 endfor
 
  
 stop
 
end