pro test_file

;  ; Set up variables for the plot. Normally, these values would be
;  ; passed into the program as positional and keyword parameters.
;  x = cgScaleVector(Randomn(-3L, 100000)*2, -10, 10)
;  y = cgScaleVector(Randomn(-5L, 100000)*5, 0, 100)
;  xrange = [Min(x), Max(x)]
;  yrange = [Min(y), Max(y)]
;  xbinsize = 0.25
;  ybinsize = 3.00
;
;  ; Open a display window.
;  cgDisplay
;
;  ; Create the density plot by binning the data into a 2D histogram.
;  density = Hist_2D(x, y, Min1=xrange[0], Max1=xrange[1], Bin1=xbinsize, $
;    Min2=yrange[0], Max2=yrange[1], Bin2=ybinsize)
;
;  maxDensity = Ceil(Max(density)/1e2) * 1e2
;  scaledDensity = BytScl(density, Min=0, Max=maxDensity)
;
;  ; Load the color table for the display. All zero values will be gray.
;  cgLoadCT, 33
;  TVLCT, cgColor('gray', /Triple), 0
;  TVLCT, r, g, b, /Get
;  palette = [ [r], [g], [b] ]
;
;  ; Display the density plot.
;  cgImage, scaledDensity, XRange=xrange, YRange=yrange, /Axes, Palette=palette, $
;    XTitle='Concentration of X', YTitle='Concentration of Y', $
;    Position=[0.125, 0.125, 0.9, 0.8]
;
;  thick = (!D.Name EQ 'PS') ? 6 : 2
;  cgContour, density, LEVELS=maxDensity*[0.25, 0.5, 0.75], /OnImage, $
;    C_Colors=['Tan','Tan', 'Brown'], C_Annotation=['Low', 'Avg', 'High'], $
;    C_Thick=thick, C_CharThick=thick
;
;  ; Display a color bar.
;  cgColorbar, Position=[0.125, 0.875, 0.9, 0.925], Title='Density', $
;    Range=[0, maxDensity], NColors=254, Bottom=1, OOB_Low='gray', $
;    TLocation='Top'
;    
  
  
    figurename='D:\KSCloud\IDL\test_figure.png'
;  cgps_open,figurename,xsize=6,ysize=6.0,xoffset=1,yoffset=2,/inches,/encapsulated
  ;soil_colors = ['purple', 'dodger blue', 'dark green', 'lime green', $
  ;  'green yellow', 'yellow', 'hot pink', 'crimson']
  ;TVLCT, cgColor(soil_colors, /Triple), 1
  ;cgloadct,39;,Bottom=0,Ncolors=3;,CLIP=[50,240]
  Bottom=0 & Ncolors=250
  cgLoadCT, 33,  Bottom=Bottom,NColors=Ncolors;, /Brewer, /Reverse
;  TVLCT, cgColor('white', /Triple), 0
;  TVLCT, r, g, b, /Get
;  palette = [ [r], [g], [b] ]
  pho_num=2
  x0=0.09 & y0=0.08 & x1=0.98 & y1=0.98 & dx=0.78 & delx=0.03 & dely=0.006 & dy=(y1-y0-(pho_num-1)*dely)/pho_num
  Xticks=2
  Xminor=4
  Charsize=1.5
  Charthick=2.0
  Ticklen=0.2
  Xticklen=0.06
  Yticklen=0.06
  dyticklen=0.02

  cdf_file='D:\KSCloud\Data\Themis\tha_l2_esa_20070614_v01.cdf'
  loadcdf,filename,'time_tags__C1_CP_FGM_SPIN',time
  loadcdf,filename,'B_vec_xyz_gse__C1_CP_FGM_SPIN',Bgse
  ;data=rbsp_read_emfisis_l3_mag(cdf_file,trange=[12,21],/Bgsm)
  ;data=shot_time_FFT(data.time_tag,data.Bgsm[*,0],nopfft=512,steplength=50)
  image_color=tv_color(data.POWSPEC,/log,/positive,Bottom=1,Ncolors=10,image_range=[1e-2,1e2])
;  data=cgtv(data.POWSPEC,/log,Bottom=1,Ncolors=10,image_range=[1e-2,1e2],position=[x0,y0,x0+dx,y0+dy])
 scaledpowspec= BytScl(alog10(data.POWSPEC),Min=-2,Max=2,/nan)
 axis_format = {XTicks:4, xminor: 3,xtickv:[6,7,8,9,10],XTickname:['Cow', 'Pig', 'Dog', 'Cat', 'Owl'],yTicks:4, yminor: 5,yTickname:['Cow', 'Pig', 'Dog', 'Cat', 'Owl']} 
  cgimage,scaledpowspec,stretch='linear',xrange=[6,10],axkeyword=axis_format,$
    position=[x0,y0,x0+dx,y0+dy],/axes,/normal,Bottom=Bottom,Ncolors=Ncolors,missing_index=0,missing_color='grey'
;  cgplot,indgen(10),indgen(10),/xstyle,/ystyle,xrange=[5,10],yrange=[min(data.freqline),max(data.freqline)],$
;    position=[x0,y0,x0+dx,y0+dy],color='black',/nodata,/noerase,/normal

;  labels = ['< 0','0-50', '50-100', '100-150', '150-200', '200-250', $
;    '250-300', '300-350', '350-400', '>400']
;  cgDCBar, NColors=10, Bottom=0, Color='black', $
;    Position=[0.05, 0.88, 0.95, 0.92], Rotate=-45, $
;    Labels=labels, Charsize=charsize, $
;    Title='Surface Latent Heat Flux (watts/meter$\up2$)'
    
    cgColorbar, Position=[0.125, 0.675, 0.9, 0.7], Title='Density', $
        Range=[-2, 2], Bottom=Bottom+1,Ncolors=Ncolors, OOB_Low='grey', $ insert_gaps
        TLocation='Top'
        
        
   makepng,figurename 
;  cgps_close
end

