; docformat = 'rst'
;+
; This is an example program to demonstrate how to create a StreamFunction plot
; with Greek symbols using Coyote Graphics routines.
;
; :Categories:
;    Graphics
;    
; :Examples:
;    Save the program as "streamfunction_plot.pro" and run it like this::
;       IDL> .RUN streamfunction_plot
;       
; :Author:
;    FANNING SOFTWARE CONSULTING::
;       David W. Fanning 
;       1645 Sheely Drive
;       Fort Collins, CO 80526 USA
;       Phone: 970-221-0438
;       E-mail: david@idlcoyote.com
;       Coyote's Guide to IDL Programming: http://www.idlcoyote.com
;
; :History:
;     Change History::
;        Written, 15 February 2013 by David W. Fanning.
;
; :Copyright:
;     Copyright (c) 2013, Fanning Software Consulting, Inc.
;-
PRO StreamFunction_Plot
 
   ; Set up variables for the plot. Normally, these values would be 
   ; passed into the program as positional and keyword parameters.
    nlevels = 13
    x = (0.1 * Findgen(100) - 4.95) # (Fltarr(100)+1)
    y = (Fltarr(100)+1) # (0.1 * Findgen(100) - 4.95)
    r = SQRT(x^2 + y^2)
    psi = (r*r - 1/(r*r)) * Sin(2*ATan(y,x)) + 10 * ALog(r) / !PI
    
    ; Open a graphics window.
    cgDisplay, 700, 800
    
    ; Calculate contour levels.
    levels = [Min(psi), cgScaleVector(Findgen(nlevels), -6, 6)]

    ; Load plot colors.
    cgLoadct, 2, NColors=nlevels, Bottom=1, /Brewer
    TVLCT, cgColor('charcoal', /Triple), 0
    TVLCT, cgColor('gray', /Triple), nlevels
    
    ; Draw the contour plot. Maintain a square aspect.
    cgContour, psi, x, y, Levels=levels, /Fill, /Outline, Label=3, $
        C_Colors=Indgen(nlevels+1), Aspect=1.0, $
        Position=[0.125, 0.125, 0.9, 0.8], XTitle='X', YTitle='Y'
        
    ; Draw and label the unit circle.
    theta = 2 * !PI * Findgen(100)/100
    thick = (!D.Name EQ 'PS') ? 4 : 2
    cgPlotS,  Cos(theta), Sin(theta), Color='red', Thick=thick
    cgText, 2, 1.75, 'Unit Circle', Color='red', CharSize=cgDefCharsize()*1.25
    cgArrow, 0.7100, 0.5700, 0.5771, 0.5175, /Normal, Color='red', /Solid, Thick=thick
    
    ; Add plot annotation.
    cgText, -3, -4, Alignment=0.5, 'U$\subO$=1, $\gamma$=20', Charsize=cgDefCharsize()*1.25
    
    ; Add a colorbar.
    cgColorbar, NColors=nlevels-2, Bottom=1, OOB_Low=0B, OOB_High=Byte(nlevels), $
        Divisions=10, /Discrete, Range=[-6, 6], Position=[0.2, 0.875, 0.8, 0.905], $
        Title='$\phi$ = U$\subO$(r$\up2$-1/r$\up2$)sin2$\theta$+($\gamma$/2$\pi$)log(r)', $
        TLocation='top', TCharSize=cgDefCharsize()*1.25, Format='(i0)'
       
END ;*****************************************************************

; This main program shows how to call the program and produce
; various types of output.

  ; Display the plot in a graphics window.
  StreamFunction_Plot
  
  ; Display the plot in a resizeable graphics window.
  cgWindow, 'StreamFunction_Plot', WXSize=700, WYSize=800, WAspect=1.0, $
    WTitle='StreamFunction Plot in a Resizeable Graphics Window'
  
  ; Create a PostScript file.
  cgPS_Open, 'streamfunction_plot.ps'
  StreamFunction_Plot
  cgPS_Close
  
  ; Create a PNG file.
  cgPS2Raster, 'streamfunction_plot.ps', /PNG

END