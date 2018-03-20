;+
; :Name:
;  GAUSSFIT_example
; :Description:
;    Describe the procedure.
;    The GAUSSFIT function computes a non-linear least-squares fit to a function f (x) with from three to six unknown parameters.
;      f (x) is a linear combination of a Gaussian and a quadratic;
;     the number of terms is controlled by the keyword parameter NTERMS.
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
;  written at 18:17:07 2017-2-8
;  Email:yangjian615@buaa.edu.cn
;
; :History:
;   Modification History::
;       2017-2-8  -   Written by Jian Yang
;
;
;
pro GAUSSFIT_example
  compile_opt idl2
  ; Define the independent variable.
  n = 101
  x = (FINDGEN(n)-(n/2))/4
  ; Define the coefficients.
  a = [4.0, 1.0, 2.0, 1.0, 0.25, 0.01]
  print, 'Expect: ', a
  z = (x - a[1])/a[2] ; Gaussian variable
  seed = 123321 ; Pick a starting seed value
  
  for nterms=3,6 do begin
    ; Define the dependent variables. Start with random noise.
    y = 0.4*RANDOMN(seed, n)
    ; Use a switch statement so we fall through to each term.
    switch nterms of
      6: y = y + a[5]*x^2
      5: y = y + a[4]*x
      4: y = y + a[3]
      3: y = y + a[0]*exp(-z^2/2)
    endswitch
    ; Fit the data to the function, storing coefficients in
    ; coeff:
    yfit = GAUSSFIT(x, y, coeff, NTERMS=nterms)
    print, 'Result: ', coeff[0:nterms-1]
    ; Plot the original data and the fitted curve:
    p1 = PLOT(x, y, TITLE='nterms='+STRTRIM(nterms,2), $
      LAYOUT=[4,1,nterms-2], CURRENT=(nterms gt 3), $
      DIMENSIONS=[800,200], MARGIN=[0.1,0.2,0.1,0.2])
    p2 = PLOT(x, yfit, THICK=2, /OVERPLOT)
  endfor
  
end
