FUNCTION svdfit_funct, X ,M
  RETURN,[ [1.0], [SIN(2*X)/X], [COS(4.*X)^2.] ]
END

;+
; :Name:
;  svdfit_example
; :Description:
;    Describe the procedure.
;    The SVDFIT function performs a least squares fit with optional error estimates. 
;    Either a user-supplied function written in the IDL language or a built-in polynomial can be used to fit the data.
;    
; :Categories:
;
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
;  written at 18:22:56 2017-2-8
;  Email:yangjian615@buaa.edu.cn
;
; :History:
;   Modification History::
;       2017-2-8  -   Written by Jian Yang
;
;
;
PRO svdfit_example
  ; Provide an array of coefficients:
  C = [7.77, 8.88, -9.99]
  X = FINDGEN(100)/15.0 + 0.1
  Y = C[0] + C[1] * SIN(2*X)/X + C[2] * COS(4.*X)^2.
  ; Set uncertainties to 5%:
  measure_errors = 0.05 * Y
  ; Provide an initial guess:
  A=[1,1,1]
  result_a = SVDFIT(X, Y, A=A, MEASURE_ERRORS=measure_errors, $
    FUNCTION_NAME='svdfit_funct', SIGMA=SIGMA, YFIT=YFIT)
  ; Plot the results:
  PLOT, X, YFIT
  FOR I = 0, N_ELEMENTS(A)-1 DO $
    PRINT, I, result_a[I], SIGMA[I], C[I],$
    FORMAT = $
    '(" result_a ( ",I1," ) = ",F7.4," +- ",F7.4," VS. ",F7.4)'
END