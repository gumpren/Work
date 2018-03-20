pro polynomial_fit,x,y1,y2,Degree,measure_errors=measure_errors,plot_vis=plot_vis,pos=pos,_extra=opt_plot

  compile_opt idl2
    
  if undefined(Degree) then Degree=2 ;默认一元二次拟合
  ; Compute the second degree polynomial fit to the data:
  result1 = POLY_FIT(X, Y1, Degree, MEASURE_ERRORS=measure_errors, $
    SIGMA=sigma)
  result2 = POLY_FIT(X, Y2, Degree, MEASURE_ERRORS=measure_errors, $
    SIGMA=sigma)
  ; Print the coefficients:
;  PRINT, 'Coefficients: ', result1
;  PRINT, 'Standard errors: ', sigma
  cgdisplay
  ;; =============================================
  ; plot
  ;; =============================================
  if KEYWORD_SET(plot_vis) then BEGIN
    cgPLOT,X,Y1,psym=2,position=pos,_extra=opt_plot;,yticks=2,ytickv=

    yi1=result1[0]+result1[1]*X
    str_name = 'Y='+STRTRIM(STRING(result1[0], FORMAT = '(F12.2)'),2)+STRTRIM(STRING(result1[1], FORMAT = '(F+12.2)'), 2)+'X'
    for index = 2L, N_ELEMENTS(result1)-1 do begin
      yi1=yi1+result1[index]*X^index
      str_name=str_name+STRTRIM(STRING(result1[index], FORMAT = '(F+12.2)'), 2)+'X!u'+STRTRIM(STRING(index),2)+'!N'
    endfor
    help,str_name,yi1

    ;cgPLOT,x, yi1,position=pos,_extra=opt_plot, /OVERPLOT
    ;  l = LEGEND(TARGET =p2, POSITION=[0.15,0.85],FONT_SIZE = 12, /NORMAL, TRANSPARENCY = 100, SHADOW = 0,HORIZONTAL_ALIGNMENT=0)
    
    
    
    cgPLOT,X,Y2,psym=4,color='red',position=pos,_extra=opt_plot,/overplot

    yi2=result2[0]+result2[1]*X
    str_name = 'Y='+STRTRIM(STRING(result2[0], FORMAT = '(F12.2)'),2)+STRTRIM(STRING(result2[1], FORMAT = '(F+12.2)'), 2)+'X'
    for index = 2L, N_ELEMENTS(result2)-1 do begin
      yi2=yi2+result2[index]*X^index
      str_name=str_name+STRTRIM(STRING(result2[index], FORMAT = '(F+12.2)'), 2)+'X!u'+STRTRIM(STRING(index),2)+'!N'
    endfor
    help,str_name,yi2

   ; cgPLOT,x, yi2,color='red', position=pos,_extra=opt_plot,/OVERPLOT


    

  endif

end
