;+
; :Author: dell
;-
;+
; :Description:
;    Describe the procedure.
;
; :Params:
;    flux
;    bottom_flux
;    top_flux
;    Bottom
;    Ncolors
;   小于零赋值为0，或者nan值也赋值为零
;
;
; :Author: dell
;-
function calculate_colors,flux,bottom_flux,top_flux,Bottom,Ncolors
  compile_opt idl2
  n=size(flux)
  row=n[1] & column=n[2]
  image_colors=fltarr(row,column)
  ;Bottom=Bottom & Ncolors=Ncolors

  for i=0l,row-1L do begin
    for j=0l,column-1 do begin
      if (flux[i,j] le 0 or FINITE(flux[i,j],/NAN) eq 1) then begin
        image_colors[i,j]=byte(0)
      endif
      if (flux[i,j] lt Bottom_flux and flux[i,j] gt 0) then begin
        image_colors[i,j]=byte(1)
      endif
      if (flux[i,j] gt top_flux) then begin
        image_colors[i,j]=byte(Bottom+Ncolors)
      endif
      if (flux[i,j] ge bottom_flux and flux[i,j] le top_flux) then begin
        image_colors[i,j]=byte(Bottom+Ncolors*(flux[i,j]-bottom_flux)/(top_flux-bottom_flux))
      endif
    endfor
  endfor
  return,image_colors
end
