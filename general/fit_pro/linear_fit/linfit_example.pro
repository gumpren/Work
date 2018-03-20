;+
; :Name:
;  LINFIT_example
; :Description:
;    Describe the procedure.
;    LINFIT_example 一元线性拟合 minimizing the chi-square error statistic 最小卡方误差统计法
; :Categories:
;    my_idl_lib fit_pro linear_fit
; :Params:
;    x
;    y
;
; :Keywords:
;    measure_errors
;    _EXTRA :   LINFIT Keywords
; :Returns:
;
; :Author: yangjian-BUAA
;-
; :Bugs:
;
; :Examples: .r LINFIT_example
;
;  written at 13:01:30 2017-1-18
;  Email:yangjian615@buaa.edu.cn
;
; :History:
;   Modification History::
;       2017-1-18  -   Written by Jian Yang
;
;
;
pro LINFIT_example,x,y,measure_errors=measure_errors,_EXTRA = EXTRA_KEYWORDS
  compile_opt idl2
  
  ; Compute the model parameters, A and B, and print the coeff:
  coeff = LINFIT(X, Y, MEASURE_ERRORS=measure_errors,_EXTRA = EXTRA_KEYWORDS)
  
  
  
  p1= PLOT(x, y, '*r',TITLE='Linfit')
  
  y1 = coeff[0] + coeff[1] * x
  str_name = 'y = ' + STRTRIM(STRING(coeff[0], FORMAT = '(F12.2)'), 2)+ $
    STRTRIM(STRING(coeff[1], FORMAT = '(F+12.2)'), 2) + 'x'
    
  p2 = PLOT(x, y1, /OVERPLOT, NAME = str_name)
  l = LEGEND(TARGET =p2, POSITION=[0.15,0.85],FONT_SIZE = 12, /NORMAL, TRANSPARENCY = 100, SHADOW = 0,HORIZONTAL_ALIGNMENT=0)
  
  
  PRINT, coeff
  
  ;Calculate correlate coefficient.
  r = CORRELATE(x, y)
  str_name2 = 'R = ' + STRTRIM(STRING(r, FORMAT = '(F12.4)'), 2)
  t = TEXT(0.15, 0.75, str_name2, FONT_SIZE = 12, /NORMAL)
  
end

;; =============================================
; Example for test LINFIT
;; =============================================

; Define two n-element vectors of paired data:
X = [-3.20, 4.49, -1.66, 0.64, -2.43, -0.89, -0.12, 1.41, $
  2.95, 2.18, 3.72, 5.26]
Y = [-7.14, -1.30, -4.26, -1.90, -6.19, -3.98, -2.87, -1.66, $
  -0.78, -2.61, 0.31, 1.74]
; Define an n-element vector of Poisson measurement errors:
  
measure_errors= SQRT(ABS(Y))
LINFIT_example,x,y,measure_errors=measure_errors


end