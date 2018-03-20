;+
; :Name:
;  REGRESS_examle
; :Description:
;    Describe the procedure.
;    REGRESS function performs a multiple linear regression fit 
;    多元线性回归
;    
; :Categories:
;   my_idl_lib fit_pro linear_fit
; :Params:
;    x
;    y
;
; :Keywords:
;    MEASURE_ERRORS
;    plot_vis
;
; :Returns:
;
; :Author: yangjian-BUAA
;-
; :Bugs:
;
; :Examples:
;  .r REGRESS_examle
;
;  written at 15:33:08 2017-1-18
;  Email:yangjian615@buaa.edu.cn
;
; :History:
;   Modification History::
;       2017-1-18  -   Written by Jian Yang
;
;
;
pro REGRESS_examle,x,y,MEASURE_ERRORS=measure_errors,plot_vis=plot_vis
  compile_opt idl2
  
  
  ; Compute the fit, and print the results:
  result = REGRESS(X, Y, SIGMA=sigma, CONST=const, $
    MEASURE_ERRORS=measure_errors)
  PRINT, 'Constant: ', const
  PRINT, 'Coefficients: ', result[*]
  PRINT, 'Standard errors: ', sigma
  
  
  ;; =============================================
  ; plot
  ;; =============================================
  if KEYWORD_SET(plot_vis) then BEGIN
    p1= PLOT(X,Y, '*r',TITLE='REGRESS_multi')
    
    yi=const+result[0]*x[0,*]
    str_name = 'yi='+STRTRIM(STRING(const, FORMAT = '(F12.2)'),2)+STRTRIM(STRING(result[0], FORMAT = '(F+12.2)'), 2)+'x0'
    for index = 1L, N_ELEMENTS(result)-1 do begin
      yi=yi+result[index]*x[index,*]
      str_name=str_name+STRTRIM(STRING(result[index], FORMAT = '(F+12.2)'), 2)+'x'+STRTRIM(STRING(index),2)
    endfor
    help,str_name,yi
    
    
    p2 = PLOT(x, yi, /OVERPLOT, NAME = str_name)
    l = LEGEND(TARGET =p2, POSITION=[0.15,0.85],FONT_SIZE = 12, /NORMAL, TRANSPARENCY = 100, SHADOW = 0,HORIZONTAL_ALIGNMENT=0)
    
    
  endif
end

;; =============================================
; Example for test REGRESS
; yi = const + a0x0, i + a1x1, i + ... + aNterms-1xNterms-1, i
;
;; =============================================
; Create two vectors of independent variable data:
X1 = [1.0, 2.0, 4.0, 8.0, 16.0, 32.0]
X2 = [0.0, 1.0, 2.0, 3.0, 4.0, 5.0]
; Combine into a 2x6 array
X = [TRANSPOSE(X1), TRANSPOSE(X2)]

Y = 5 + 3*X1 - 4*X2

; Create a vector of dependent variable data:
; Assume Gaussian measurement errors for each point:
measure_errors = REPLICATE(0.5, N_ELEMENTS(Y))

REGRESS_examle,x,y,measure_errors=measure_errors,/plot_vis





end