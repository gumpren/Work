;; =============================================
; example:non-linear least squares fit to a function with an arbitrary number of parameters
;
;; =============================================



;; =============================================
; In this example, we fit a function of the form:
; f(x)=a[0] * exp(a[1]*x) + a[2] + a[3] * sin(x)
; 定义X自变量 A为参数[a[0],a[1],a[2]]
; 返回函数和对各个参数的偏导数
;; =============================================

FUNCTION myfunct, X, A
  ; First, define a return function for LMFIT:
  bx = A[0]*EXP(A[1]*X)
  RETURN,[ [bx+A[2]+A[3]*SIN(X)], [EXP(A[1]*X)], [bx*X], $
    [1.0] ,[SIN(X)] ]
END



;+
; :Name:
;  lmfit_example
; :Description:
;    Describe the procedure.
;    曲线函数拟合
; :Categories:
;    my_idl_lib fit_pro non_linear_fit
;
;
;
;
; :Returns:
;
; :Author: yangjian-BUAA
;-
; :Bugs:
;
; :Examples:
;
;  written at 13:10:45 2017-1-18
;  Email:yangjian615@buaa.edu.cn
;
; :History:
;   Modification History::
;       2017-1-18  -   Written by Jian Yang
;
;
;
PRO lmfit_example
  ; Compute the fit to the function we have just defined. First,
  ; define the independent and dependent variables:
  X = FINDGEN(40)/20.0
  Y = 8.8 * EXP(-9.9 * X) + 11.11 + 4.9 * SIN(X)
  measure_errors = 0.05 * Y
  
  ; Provide an initial guess for the function's parameters:
  A = [10.0, -0.1, 2.0, 4.0]
  fita = [1,1,1,1]
  
  ; Plot the initial data, with error bars:
  PLOTERR, X, Y, measure_errors
  coefs = LMFIT(X, Y, A, MEASURE_ERRORS=measure_errors, /DOUBLE, $
    FITA = fita, FUNCTION_NAME = 'myfunct')
  ; Overplot the fitted data:
  cgOPLOT, X, coefs,COLOR='red'
END