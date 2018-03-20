;+
; :Name:
;  CRVLENGTH_EXAMPLE
; :Description:
;     COMPUTES the length of a curve with a tabular representation
;     计算曲线长度
; :Categories:
;    my_idl_lib fit_pro linear_fit
; :Params:
;    x
;    y
;
;
;
; :Returns:
;
; :Author: yangjian-BUAA
;-
; :Bugs:
;
; :Examples: .r CRVLENGTH_EXAMPLE
;
;  written at 17:44:51 2017-2-8
;  Email:yangjian615@buaa.edu.cn
;
; :History:
;   Modification History::
;       2017-2-8  -   Written by Jian Yang
;
;
;
pro CRVLENGTH_EXAMPLE,x,y
  compile_opt idl2
  ;Compute the length of the curve:
  result = CRVLENGTH(x, y)
  dPrint, result
end




;; =============================================
; Example for test CRVLENGTH
;; =============================================
;
;Define a 21-element vector of X-values:
x = [-2.00, -1.50, -1.00, -0.50, 0.00, 0.50, 1.00, 1.50, 2.00, $
  2.50,  3.00,  3.50,  4.00, 4.50, 5.00, 5.50, 6.00, 6.50, $
  7.00,  7.50,  8.00]
;Define a 21-element vector of Y-values:
y = [-2.99, -2.37, -1.64, -0.84, 0.00, 0.84, 1.64, 2.37, 2.99, $
  3.48,  3.86,  4.14,  4.33, 4.49, 4.65, 4.85, 5.13, 5.51, $
  6.02,  6.64,  7.37]
;Compute the length of the curve:

Dprint,'================================================='
Dprint,'========== CRVLENGTH ============================'

CRVLENGTH_EXAMPLE,x,y



end