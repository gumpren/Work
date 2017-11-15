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


pro cgplot_vector_5minute_per_point
    
    Re=6371.0
    reverse_gap=5.0/5.0
    save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
    ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
    root_dir='C:\__Data\Datasave\2001_2009_5minute_per_point\'
    output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_5minute_per_point\'
    title_char='velocity_vector_5minute_per_point';
    
    restore,filename=root_dir+'event_data'+save_str+'_list_5minute_per_point_full.sav'
    
    n_lon=10
    n_lat=30
    
    u=event_vx[0]
    v=event_vy[0]
    
    lon=linspace(-20,-11,10*reverse_gap)
    lat=linspace(-15,14,30*reverse_gap)
    
    
    ;wrap the data
    lon = [lon, lon[0]]
    u = [u,u[0,*]]
    v = [v,v[0,*]]
    
    ; Do this in decomposed color.
    cgSetColorState, 1, Current=currentColorState
  
    ; Read the data.

  
    ; Calculate max wind speed and reference vector value.
    wspd = sqrt(u^2 + v^2)
    maxSpeed = Max(wspd)
    Print, 'Maximum Wind Speed (m/sec): ', maxSpeed
    referenceVec = Round(maxSpeed*0.15)
    Print, 'Reference Wind Speed (m/sec): ', referenceVec
    
    
    
     ;Properties for the plots

    cgLoadct, 4, /BREWER, NCOLORS=12
    
    lons = Rebin(lon, n_lon+1, n_lat)
    lats = Rebin(Reform(lat,1,n_lat), n_lon+1, n_lat)
    hsize = (!D.Name NE 'PS') ? 5 : 8
  
    ; Graphics window.
    cgDisplay
  
   
    ; Plot annotations
  
    ; Plot north wind vectors.
;    indices = Where((lats GE 0) AND (lats LT 85), count)
    cgDrawVectors, u, v, lons , lats, $
      VecColor='red', /Overplot, Fraction=0.10, ReferenceVector=referenceVec, $
      Length=0.1, /Solid, /Ordered
  
    ; Draw reference arrow and legend.
    cgArrow, pos[0], 0.95, pos[0]+0.1, 0.95, /Normal, Color='red', /Solid
    x = (pos[0] + pos[0]+0.1) / 2.0
    y = 0.95 - ((2.0*!D.Y_CH_SIZE)/!D.Y_Size)
    cgText, x, y, String(referenceVec, Format='(i0)') + ' (m/sec)', /Normal, $
      Color='red', Alignment=0.5
 
  
    ; Restore the color state.
    cgSetColorState, currentColorState
  

;*****************************************************************

;    ; This main program shows how to call the program and produce
;    ; various types of output.
;    
;  
;    ; Display the contour plot in a resizeable graphics window.
;    cgWindow, 'Velocity_Vector_Plot', WBackground='White', $
;      WTitle='Velocity Vector Plot in a Resizeable Graphics Window'
;    
;    ; Create a PostScript file.
;    cgPS_Open, 'velocity_vector_plot.ps'
;    Velocity_Vector_Plot
;    cgPS_Close
;    
;    ; Create a PNG file with a width of 600 pixels.
;    cgPS2Raster, 'velocity_vector_plot.ps', /PNG, Width=600

  
  
  

end