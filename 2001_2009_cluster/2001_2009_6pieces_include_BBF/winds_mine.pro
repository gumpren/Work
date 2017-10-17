PRO winds_mine
  ; create by gren
  ;Code to show a wind vector plot

  ;Open postscript file and select the color table
  SET_PLOT,'ps'
  DEVICE, FILE='winds_mine.ps', XSIZE=8.27, YSIZE=11.69,$
    XOFFSET=0.5, YOFFSET=0.5, /INCHES, /COLOR
  !P.COLOR=1
  !P.THICK=3.0
  !P.FONT=1
  !X.THICK=3.0
  !Y.THICK=3.0
  xsize=!D.X_VSIZE ;Paper x size
  ysize=!D.Y_VSIZE ;Paper y size
  xstart=(3000.)/xsize
  xfinish=(3000.+12000.)/xsize
  ystart=(3000.)/ysize
  yfinish=(3000.+12000.)/ysize
  !P.POSITION=[xstart, ystart, xfinish, yfinish]
  r = [255,0,255]
  g = [255,0,0]
  b = [255,0,0]
  TVLCT,r,g,b

  ;Get the data
  fid=NCDF_OPEN('ukmo.nc')
  varid=NCDF_VARID(fid,'u')
  NCDF_VARGET, fid, varid, u
  varid=NCDF_VARID(fid,'v')
  NCDF_VARGET, fid, varid, v
  NCDF_CLOSE, fid

  ;Set the data to be plotted
  lats=88.75-INDGEN(72)*2.5
  longs=1.875+3.75*INDGEN(96)
  ;Select 1000mb winds for plotting
  myu=u[*,*,0]
  myv=v[*,*,0]

  ;Set the map projection
  ;MAP_SET, 0.0, 0.0, LIMIT=[30.0,-20.0,70.0,20.0], /CYLINDRICAL, /NOBORDER

  ;Plot the vectors
  len=2.0
  ref_mag=10
  mytext=STRTRIM(STRING(ref_mag),2)+'ms!E-1!N'


  VECTOR, myu, myv, longs, lats, LENGTH=len, REF_MAG=ref_mag,$
    STRIDE=1, TYPE=2, HEAD_LEN=0.3, ANGLE=30, $
    REF_POS=[0.65, 0.05], REF_TEXT=mytext,$
    ALIGN=0.5, COLOR=1, /OVERPLOT, /NOERASE

  ;Add the continents
 ; MAP_CONTINENTS

  ;Add the axes
  myticklen=-0.01
  myticks=['20W', '10W', 'EQ','10E','20E']
  n=N_ELEMENTS(myticks)
  mytickvals=FINDGEN(n)/(n-1)
  AXIS, -20,30, XAXIS=0, XTITLE='Longitude', TICKLEN=myticklen,$
    XTICKS=n-1, XTICKNAME=myticks, XTICKV=mytickvals
  myticks(*)=' '
  AXIS, -20,70, XAXIS=1, XTITLE=' ', TICKLEN=myticklen,$
    XTICKS=n-1, XTICKNAME=myticks, XTICKV=mytickvals

  myticks=['30N','40N', '50N','60N','70N']
  n=N_ELEMENTS(myticks)
  mytickvals=FINDGEN(n)/(n-1)
  AXIS, -20,30, YAXIS=0, YTITLE='Latitude', TICKLEN=myticklen,$
    YTICKS=n-1, YTICKNAME=myticks, YTICKV=mytickvals
  myticks(*)=' '
  AXIS, 20,30, YAXIS=1, TICKLEN=myticklen,$
    YTICKS=n-1, YTICKNAME=myticks, YTICKV=mytickvals, /NOERASE


  ;Close the postscript file
  DEVICE, /CLOSE

  SPAWN, 'display winds.ps'

END