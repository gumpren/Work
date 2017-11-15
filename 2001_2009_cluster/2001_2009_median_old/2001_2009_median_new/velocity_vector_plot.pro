; docformat = 'rst'
;+
; This is an example program to demontrate how to create a velocity vector plot
; with Coyote Graphics routines.
;
; :Categories:
;    Graphics
;
; :Examples:
;    Save the program as "velocity_vector_plot.pro" and run it like this::
;       IDL> .RUN velocity_vector_plot
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
;        Written, 23 January 2013 by David W. Fanning.
;        Modified to use updated cgMapVector object, 3 July 2013. DWF.
;
; :Copyright:
;     Copyright (c) 2013, Fanning Software Consulting, Inc.
;-
PRO Velocity_Vector_Plot


  ; Do this in decomposed color.
  cgSetColorState, 1, Current=currentColorState

  ; Read the data.
  lat_file = 'F:\___Download\lat.dat'
  lon_file = 'F:\___Download\lon.dat'
  u_file = 'F:\___Download\u.dat'
  v_file = 'F:\___Download\v.dat'

  n_lat = 46 ; given
  n_lon = 72 ; given
  lat = fltarr(n_lat)
  lon = fltarr(n_lon)
  u = fltarr(n_lon, n_lat)
  v = fltarr(n_lon, n_lat)

  OpenR, id, lat_file,/Get_Lun
  ReadF, id, lat
  Free_Lun, id

  OpenR, id, lon_file, /Get_Lun
  ReadF, id, lon
  Free_Lun, id

  OpenR, id, u_file, /Get_Lun
  ReadF, id, u
  Free_Lun, id

  OpenR, id, v_file, /Get_Lun
  ReadF, id, v
  Free_Lun, id

  ; Wrap the data.
  lon = [lon, lon[0]]
  u = [u,u[0,*]]
  v = [v,v[0,*]]

  ; Calculate max wind speed and reference vector value.
  wspd = sqrt(u^2 + v^2)
  maxSpeed = Max(wspd)
  Print, 'Maximum Wind Speed (m/sec): ', maxSpeed
  referenceVec = Round(maxSpeed*0.65)
  Print, 'Reference Wind Speed (m/sec): ', referenceVec

  ; Properties for the plots
  n_levels = 12
  cgLoadct, 4, /BREWER, NCOLORS=12
  speeds = Indgen(n_levels)*2 ; m/s
  lons = Rebin(lon, n_lon+1, n_lat)
  lats = Rebin(Reform(lat,1,n_lat), n_lon+1, n_lat)
  hsize = (!D.Name NE 'PS') ? 5 : 8

  ; Graphics window.
  cgDisplay

  ; North contour plot.
  ;pos = cgAspect(1.0, Margin=0.05) - [0.05, 0, 0.05, 0]
;  mapNorth = Obj_New('cgMap', 'Polar Stereographic', Limit=[0, -180, 90, 180], $
;    Position=pos, /NoBorder)
;  mapNorth -> Draw
;  cgContour, wspd, lon, lat>0, /Fill, Levels=speeds, /Outline, $
;    Label=0, /Overplot, C_Colors=Indgen(12), Map=mapNorth
;
;  ; Plot annotations.
;  cgMap_Continents, Color='charcoal', Map=mapNorth
;  cgMap_Grid, LatDel=30, LonDel=60, LineStyle=0, Color='charcoal', Map=mapNorth

  ; Plot north wind vectors.
  indices = Where((lats GE 0) AND (lats LT 85), count)
  cgDrawVectors, u[indices], v[indices], lons[indices], lats[indices], $
    VecColor='red', /Overplot, Fraction=0.10, ReferenceVector=referenceVec, $
    Length=0.1, /Solid, /Ordered, MapCoord=mapNorth

  ; Draw reference arrow and legend.
  cgArrow, pos[0], 0.95, pos[0]+0.1, 0.95, /Normal, Color='red', /Solid
  x = (pos[0] + pos[0]+0.1) / 2.0
  y = 0.95 - ((2.0*!D.Y_CH_SIZE)/!D.Y_Size)
  cgText, x, y, String(referenceVec, Format='(i0)') + ' (m/sec)', /Normal, $
    Color='red', Alignment=0.5

  cgColorBar, Divisions=10, Range=[2,22], OOB_Low=0B, OOB_High=11B, $
    NColors=10, BOTTOM=1, /Vertical, Position=[0.90, 0.2, 0.92, 0.8], $
    Tlocation='Right', /Discrete, Title='Wind Speed (m/sec)', OOB_Factor=2

  ; Restore the color state.
  cgSetColorState, currentColorState

  ; Clean up
  Obj_Destroy, mapNorth

END ;*****************************************************************

; This main program shows how to call the program and produce
; various types of output.

; Display the contour plot in a graphics window.
velocity_vector_Plot

; Display the contour plot in a resizeable graphics window.
cgWindow, 'Velocity_Vector_Plot', WBackground='White', $
  WTitle='Velocity Vector Plot in a Resizeable Graphics Window'

; Create a PostScript file.
cgPS_Open, 'velocity_vector_plot.ps'
Velocity_Vector_Plot
cgPS_Close

; Create a PNG file with a width of 600 pixels.
cgPS2Raster, 'velocity_vector_plot.ps', /PNG, Width=600

END