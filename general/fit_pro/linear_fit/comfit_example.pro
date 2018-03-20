;+
; :Name:
;  COMFIT_example
; :Description:
;    Describe the procedure.
;    COMFIT_example 可以拟合六种梯度扩展最小方差法近似公式中的任意一种
;
; :Categories:
;    my_idl_lib fit_pro linear_fit
; :Params:
;    x
;    y
;
; :Keywords:
;    measure_errors
;    _EXTRA :   COMFIT Keywords
;          /EXPONENTIAL y=a0a1^X+a2
;          /GEOMETRIC   y=a0X^a1+a2
;          /GOMPERTZ    y=a0a1^(a2X)+a3
;          /HYPERBOLIC  y=1/(a0+a1x)
;          /LOGISTIC    y=1/(a0a1^x+a2)
;          /LOGSQUARE   y=a0+a1*log(x)+a2*log(x)^2
;
; :Returns:
;
; :Author: yangjian-BUAA
;-
; :Bugs:
;
; :Examples: .r COMFIT_example
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
pro COMFIT_example,x,y,A,_EXTRA = EXTRA_KEYWORDS
  compile_opt idl2
  
  ; Compute the model parameters, A and B, and print the coeff:
  ;Results in a vector containing the model parameters a0, a1, a2, etc.
  
  
  
  Catch, theError
  IF theError NE 0 THEN BEGIN
    Catch, /Cancel
    void = cgErrorMsg()
    RETURN
  ENDIF
  coeff = COMFIT(X, Y, A,_EXTRA = EXTRA_KEYWORDS)
  
  a0=coeff[0]& a1=coeff[1]&  a2=coeff[2]
  
  p1= PLOT(x, y, '*r',TITLE='COMFIT')
  
  if ~undefined(EXTRA_KEYWORDS) then begin
  
    case (STRUPCASE(tag_names_r(EXTRA_KEYWORDS))) of
      'EXPONENTIAL': begin
        y1 = a0*a1^x+a2
        str_name = 'Y=' + STRTRIM(STRING(coeff[0], FORMAT = '(F12.2)'), 2)+'*('+$
          STRTRIM(STRING(coeff[1], FORMAT = '(F12.2)'), 2)+')!uX!n'+$
          STRTRIM(STRING(coeff[2], FORMAT = '(F+12.2)'), 2)
      end
      'GEOMETRIC': begin
        y1 = a0*x^a1+a2
        str_name = 'Y=' + STRTRIM(STRING(coeff[0], FORMAT = '(F12.2)'), 2)+'*(X)!u'+$
          STRTRIM(STRING(coeff[1], FORMAT = '(F12.2)'), 2)+$
          STRTRIM(STRING(coeff[2], FORMAT = '(F+12.2)'), 2)+''
      end
      'GOMPERTZ': begin
        a3=coeff[3]
        y1 = a0*a1^x+a2
        str_name = 'Y=' + STRTRIM(STRING(coeff[0], FORMAT = '(F12.2)'), 2)+'*('+$
          STRTRIM(STRING(coeff[1], FORMAT = '(F12.2)'), 2)+')!uX!n'+$
          STRTRIM(STRING(coeff[2], FORMAT = '(F+12.2)'), 2)
      end
      'LOGSQUARE': begin
        y1=a0+a1*alog(x)+a2*alog(x)^2
        str_name = 'Y=' + STRTRIM(STRING(coeff[0], FORMAT = '(F12.2)'), 2)+'+'+$
          STRTRIM(STRING(coeff[1], FORMAT = '(F12.2)'), 2)+'*log(x)'+$
          STRTRIM(STRING(coeff[2], FORMAT = '(F+12.2)'), 2)+'*log(x)^2'
      end
    endcase
  endif
  
  
  p2 = PLOT(x, y1, /OVERPLOT, NAME = str_name)
  l = LEGEND(TARGET =p2, POSITION=[0.15,0.85],FONT_SIZE = 12, /NORMAL, TRANSPARENCY = 100, SHADOW = 0,HORIZONTAL_ALIGNMENT=0)
  
  
end

;; =============================================
; Example for test COMFIT
;; =============================================

; Define two n-element vectors of paired data:
X = [ 2.27, 15.01, 34.74, 36.01, 43.65, 50.02, 53.84, 58.30, $
  62.12, 64.66, 71.66, 79.94, 85.67, 114.95]
Y = [ 5.16, 22.63, 34.36, 34.92, 37.98, 40.22, 41.46, 42.81, $
  43.91, 44.62, 46.44, 48.43, 49.70, 55.31]
; Define a 3-element vector of initial estimates for the logsquare
; model:
A = [1.5, 1.5, 1.5]
; Compute the model parameters of the logsquare model, A[0], A[1],
; & A[2]:

;; Define a 4-element vector of initial estimates for the logsquare
;; model:
;A = [1.5, 1.5, 1.5,1.5]
;COMFIT_example,x,y,A,/GOMPERTZ

COMFIT_example,x,y,A,/LOGSQUARE






end