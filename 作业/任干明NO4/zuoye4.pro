Pro zuoye4
  openr,lun,filepath('TC1_20050824_Magnetic Field.TXT',root_dir='E:\OneDrive\IDLworks\Work\作业\任干明NO4'),/get_lun
  tc1Bdat=dBlarr(13,19494)
  readf,lun,tc1Bdat
  free_lun,lun
  
  Bxgse=tc1Bdat[8,*]
  Bygse=tc1Bdat[9,*]
  Bzgse=tc1Bdat[10,*]
;  B[j]=sqrt(Bxgse[j]^2+Bygse[j]^2+Bzgse[j]^2)
;  B=sqrt(Bxgse^2+Bygse^2+Bzgse^2)
  h=tc1Bdat[3,*]/(3600.0*1000)
  

  for j=1,19493 do Begin

    if (Bxgse[j] le -300) then Begin
      Bxgse(j)=Bxgse[j-1]
    endif

    if (Bygse[j] le -300) then Begin
      Bygse(j)=Bygse[j-1]
    endif

    if (Bzgse[j] le -300) then Begin
      Bzgse(j)=Bzgse[j-1]
    endif
    
  endfor

  
  B=dblarr(19494)
  gBgsm=dBlarr(3,19494)

  for i=0,19493 do Begin
    geopack_recalc,2005,236,tc1Bdat[0,i],tc1Bdat[1,i],tc1Bdat[2,i]
    geopack_conv_coord,Bxgse[i],Bygse[i],Bzgse[i],Bxgsm,Bygsm,Bzgsm,/from_gse,/to_gsm

    gBgsm(0,i)=Bxgsm
    gBgsm(1,i)=Bygsm
    gBgsm(2,i)=Bzgsm
    B[i]=sqrt(Bxgse[i]^2+Bygse[i]^2+Bzgse[i]^2)    
  endfor

  Bx=gBgsm[0,5375:6713]
  By=gBgsm[1,5375:6713]
  Bz=gBgsm[2,5375:6713]
  B1=B[5375:6713]
  ;---------------------------------------------------------------------------------------------
  ;Filter=original_data-smooth_data  (Background_value)

  smooth_Bx=smooth(Bx[*],30,/edge_truncate,/NAN)
  smooth_By=smooth(By[*],30,/edge_truncate,/NAN)
  smooth_Bz=smooth(Bz[*],30,/edge_truncate,/NAN)
  smooth_B1=smooth(B1[*],30,/edge_truncate,/NAN)
  ;   help,smooth_tc

  Bx_wave=fltarr(1339)
  By_wave=fltarr(1339)
  Bz_wave=fltarr(1339)
  B_wave=fltarr(1339)
  for i=0,1338 do Begin

    Bx_wave(i)=Bx[i]-smooth_Bx[i]
    By_wave(i)=By[i]-smooth_By[i]
    Bz_wave(i)=Bz[i]-smooth_Bz[i]
    B_wave(i)=B1[i]-smooth_B1[i]
  endfor
  
  dt=4.0  
  f_Nyquist=1.0/(2.0*dt)*1000 ;mHz
  
  un=abs(FFT(B_wave[0:1338]))
  f=dblarr(669)
  su=dblarr(669)
  ts=4.0
  fs=1/ts
  
  for j=0,668  do begin
    f(j)=j/1339.0*fs*1000 
    su(j)=2*1339.0*un[j]*un[j]/fs
  endfor
  
  entry_device=!d.name
  set_plot,'ps'
  device,/color,Bits_per_pixel=8
  TVLCT, r, g, B, /Get
  output_dir='E:\OneDrive\IDLworks\浣��\浠诲共��O4\'
  device,filename=output_dir+'fft_wavelet1.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
  !p.multi=[0,1,4,0,0]
  loadct,38
  device,decomposed=0
  
  plot,f[*],su[*],background=255,color=0,xticklen=0.04,yticklen=0.04,$
       position=[0.10,0.75,0.90,0.95],thick=1.0,charsize=1.1,xstyle=1,ystyle=1,$
       xrange=[0.0,f_Nyquist],ylog=1,xtitle='!8f!X (mHz)',ytitle='S!Dpdy!n (nPa!U2!n/Hz)'

  loadct,33
  time=h[5375:6713]
 
  
  wbx=WAVELET(Bx_wave[*],dt,pad=2,period=period,coi=coi,signif=signif,/verb,j=j)
  wby=WAVELET(By_wave[*],dt,pad=2,period=period,coi=coi,signif=signif,/verb,j=j)
  wbz=WAVELET(Bz_wave[*],dt,pad=2,period=period,coi=coi,signif=signif,/verb,j=j)

;  spetrum=alog10(abs(wbx)^2)
;  max_s=max(spetrum[*,*])
;  min_s=min(spetrum[*,*])
;  delta_s=max_s-min_s

  f0=1.0/period*1000
  Nlevels=N_ELEMENTS(period)
  
  CONTOUR,ABS(wbx)^2,time[*],period[*],position=[0.1,0.5,0.9,0.69],xticklen=-0.02,yticklen=-0.02,$
    ystyle=1,yrange=[100.0,500.0],xtickformat='(a1)',xstyle=1,xrange=[6.0,7.5],zstyle=1,$
    zrange=[-5,max(ABS(wbx)^2)],background=0,color=0,nlevels=Nlevels,/fill,$
    ytitle='Bx_Period(s)',charsize=1.2;,c_color=indgen(Nlevels)+180,

  CONTOUR,ABS(wby)^2,time[*],period[*],position=[0.1,0.3,0.9,0.49],xticklen=-0.02,yticklen=-0.02,$
    ystyle=1,yrange=[100.0,500.0],xtickformat='(a1)',xstyle=1,xrange=[6.0,7.5],zstyle=1,$
    zrange=[-5,max(ABS(wby)^2)],background=0,color=0,nlevels=Nlevels,/fill,$
    ytitle='By_Period(s)',charsize=1.2;,c_color=indgen(Nlevels)+180,

  CONTOUR,ABS(wbz)^2,time[*],period[*],position=[0.1,0.1,0.9,0.29],xticklen=-0.02,yticklen=-0.02,$
    ystyle=1,yrange=[100.0,500.0],xstyle=1,xrange=[6.0,7.5],zstyle=1,$
    zrange=[-5,max(ABS(wbz)^2)],background=0,color=0,nlevels=Nlevels,/fill,$
    ytitle='Bz_Period(s)',charsize=1.2;,c_color=indgen(Nlevels)+180,

  
  colorbar_new,position=[0.93,0.1,0.94,0.27],ticklen=-0.3,color=0,NCOLORS=256,$
    range=[-5,max(ABS(wbz)^2)],/vertical,/right,format='(f7.2)',title='nPa!U2!n',charsize=1.5
  
  colorbar_new,position=[0.93,0.3,0.94,0.47],ticklen=-0.3,color=0,NCOLORS=256,$
    range=[-5,max(ABS(wby)^2)],/vertical,/right,format='(f7.2)',title='nPa!U2!n',charsize=1.5
    
  colorbar_new,position=[0.93,0.5,0.94,0.67],ticklen=-0.3,color=0,NCOLORS=256,$
    range=[-5,max(ABS(wbx)^2)],/vertical,/right,format='(f7.2)',title='nPa!U2!n',charsize=1.5
  
  device,/close_file
  set_plot,entry_device
  
 end