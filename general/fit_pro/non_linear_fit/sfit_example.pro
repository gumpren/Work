

pro SFIT_example
  compile_opt idl2
  ; Create a grid from zero to six radians in the X and Y directions:
  X = (FINDGEN(61)/10) # REPLICATE(1,61)
  Y = TRANSPOSE(X)
  ; Evaluate a function at each point:
  F = -SIN(2*X) + COS(Y/2)
  ; Compute a sixth-degree polynomial fit to the function data:
  result = SFIT(F, 6)
  ; Display the original function on the left and the fitted function
  ; on the right, using identical axis scaling:
  WINDOW, XSIZE = 800, YSIZE = 400
  ; Set up side-by-side plots:
  !P.MULTI = [0, 2, 1]
  DEVICE, DECOMPOSED=0
  ; Set background color to white:
  !P.BACKGROUND = 255
  ; Set plot color to black:
  !P.COLOR = 0
  SURFACE, F, X, Y, ZRANGE = [-3, 3], ZSTYLE = 1
  SURFACE, result, X, Y
end
