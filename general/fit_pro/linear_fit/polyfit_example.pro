;+
; :Name:
;  POLYFIT_example
; :Description:
;    Describe the procedure.
;    一元多次线性拟合
; :Categories:
;   my_idl_lib fit_pro linear_fit
; :Params:
;    x
;    y
;    Degree  拟合次数默认为2
;
; :Keywords:
;    measure_errors
;    plot_vis
;
; :Returns:
;
; :Author: yangjian-BUAA
;-
; :Bugs:
;
; :Examples:
;    .r POLYFIT_example
;  written at 17:08:13 2017-1-18
;  Email:yangjian615@buaa.edu.cn
;
; :History:
;   Modification History::
;       2017-1-18  -   Written by Jian Yang
;
;
;


pro POLYFIT_example,x,y,Degree,measure_errors=measure_errors,plot_vis=plot_vis

  compile_opt idl2
  
  
  if undefined(Degree) then Degree=2 ;默认一元二次拟合
  ; Compute the second degree polynomial fit to the data:
  result = POLY_FIT(X, Y, Degree, MEASURE_ERRORS=measure_errors, $
    SIGMA=sigma)
  ; Print the coefficients:
  PRINT, 'Coefficients: ', result
  PRINT, 'Standard errors: ', sigma
  
  
  ;; =============================================
  ; plot
  ;; =============================================
  if KEYWORD_SET(plot_vis) then BEGIN
    p1= PLOT(X,Y, '*r',TITLE='POLYFIT')
    
    yi=result[0]+result[1]*X
    str_name = 'Y='+STRTRIM(STRING(result[0], FORMAT = '(F12.2)'),2)+STRTRIM(STRING(result[1], FORMAT = '(F+12.2)'), 2)+'X'
    for index = 2L, N_ELEMENTS(result)-1 do begin
      yi=yi+result[index]*X^index
      str_name=str_name+STRTRIM(STRING(result[index], FORMAT = '(F+12.2)'), 2)+'X!u'+STRTRIM(STRING(index),2)+'!N'
    endfor
    help,str_name,yi
    
    
    p2 = PLOT(x, yi, /OVERPLOT, NAME = str_name)
    l = LEGEND(TARGET =p2, POSITION=[0.15,0.85],FONT_SIZE = 12, /NORMAL, TRANSPARENCY = 100, SHADOW = 0,HORIZONTAL_ALIGNMENT=0)
    
    
  endif
  
end

;; =============================================
; Example for test POLYFIT
; 一元多次线性拟合
; In this example, we use X and Y data corresponding to the known polynomial
;  f (x) = 0.25 - x + x^2.
;; =============================================



; Define an 11-element vector of independent variable data:
X = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
; Define an 11-element vector of dependent variable data:
Y = [0.25, 0.16, 0.09, 0.04, 0.01, 0.00, 0.01, 0.04, 0.09, $
  0.16, 0.25]
  
; Define a vector of measurement errors:
measure_errors = REPLICATE(0.01, 11)

;拟合次数
Degree=2

POLYFIT_example,x,y,Degree,measure_errors=measure_errors,/plot_vis



end