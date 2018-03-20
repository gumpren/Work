
;+
; :Name:
;  LADFIT_example
; :Description:
;    Describe the procedure.
;    ;用robust最小方差法拟合线性函数
; :Categories:
;  my_idl_lib fit_pro linear_fit
; :Params:
;    x
;    y
;
; :Keywords:
;    _EXTRA   LADFIT Keywords
;
; :Returns:
;
; :Author: yangjian-BUAA
;-
; :Bugs:
;   使用LadFit首先需要对X进行升序排列
; :Examples: .r LADFIT_example
;
;  written at 13:33:13 2017-1-18
;  Email:yangjian615@buaa.edu.cn
;
; :History:
;   Modification History::
;       2017-1-18  -   Written by Jian Yang
;
;
;
pro LADFIT_example,x,y,_EXTRA = EXTRA_KEYWORDS
  compile_opt idl2

  ; Sort the X values into ascending order, and sort the Y values to
  ; match the new order of the elements in X:
  XX = X[SORT(X)]
  YY = Y[SORT(X)]
  ; Compute the model parameters, A and B:
  coeff=LADFIT(XX, YY,_EXTRA = EXTRA_KEYWORDS)
  
  p1= PLOT(XX, YY, '*r',TITLE='Ladfit')
  
  y1 = coeff[0] + coeff[1] * XX
  str_name = 'y = ' + STRTRIM(STRING(coeff[0], FORMAT = '(F12.2)'), 2)+ $
    STRTRIM(STRING(coeff[1], FORMAT = '(F+12.2)'), 2) + 'X'
    
  p2 = PLOT(XX, y1, /OVERPLOT, NAME = str_name)
  l = LEGEND(TARGET =p2, POSITION=[0.15,0.85],FONT_SIZE = 12, /NORMAL, TRANSPARENCY = 100, SHADOW = 0,HORIZONTAL_ALIGNMENT=0)
  
  
  PRINT, coeff
  
  ;Calculate correlate coefficient.
  r = CORRELATE(XX, YY)
  str_name2 = 'R = ' + STRTRIM(STRING(r, FORMAT = '(F12.4)'), 2)
  t = TEXT(0.15, 0.75, str_name2, FONT_SIZE = 12, /NORMAL)
  
  
end

;; =============================================
; Example for test LADFIT
;; =============================================

; Define two n-element vectors of paired data:
X = [-3.20, 4.49, -1.66, 0.64, -2.43, -0.89, -0.12, 1.41, $
  2.95, 2.18, 3.72, 5.26]
Y = [-7.14, -1.30, -4.26, -1.90, -6.19, -3.98, -2.87, -1.66, $
  -0.78, -2.61, 0.31, 1.74]
; Define an n-element vector of Poisson measurement errors:
LADFIT_example,x,y,_EXTRA = EXTRA_KEYWORDS



end