pro tc1_20040803_fft_and_wavelet
    filename='E:\OneDrive\Data\Double_star\T1_PP_FGM_20040803_V03.cdf'
    loadcdf,filename,'Epoch__T1_PP_FGM',time
    loadcdf,filename,'B_xyz_gse__T1_PP_FGM',B_xyz
    
    row=n_elements(time)
    Bxgse=B_xyz[*,0]
    Bygse=B_xyz[*,1]
    Bzgse=B_xyz[*,2]
    
    B_m=dblarr(row)
    Bgsm=dblarr(row,3)
    
    hour=dblarr(row)
    minute=dblarr(row)
    second=dblarr(row)
    
    
    for i=0,row-1L do begin 
      if(abs(Bxgse[i]) gt 1.0e4)  then Bxgse[i]=Bxgse[i-1]
      if(abs(Bygse[i]) gt 1.0e4)  then Bygse[i]=Bygse[i-1]
      if(abs(Bzgse[i]) gt 1.0e4)  then Bzgse[i]=Bzgse[i-1]
    endfor
    
;-----------geopack-----------------------------------------------------------------------------------------

    for i=0L,row-1L do begin

      CDF_EPOCH,time[i],yr,mo,dy,hr,mn,sc,milli,/BREAKDOWN

      hour(i)=hr+mn/60.0+sc/3600.0+milli/3.6e6
      minute(i)=mn+sc/60.0+milli/6.0e5
      second(i)=sc+milli/5.0e3

      doy=julday(8,3,2004)-julday(1,1,2004)+1
      geopack_recalc,2004,doy,hr,mn,sc
      geopack_conv_coord,Bxgse[i],Bygse[i],Bzgse[i],Bxgsm,Bygsm,Bzgsm,/from_gse,/to_gsm

      Bgsm[i,0]=Bxgsm
      Bgsm[i,1]=Bygsm
      Bgsm[i,2]=Bzgsm

    endfor
    
    index=where(hour gt 2.8333 and hour le 3.50)
    Bx_m=Bgsm[index,0]
    By_m=Bgsm[index,1]
    Bz_m=Bgsm[index,2]
    tm=hour[index]
    B_m=sqrt(Bx_m^2+By_m^2+Bz_m^2)
    
 ;------------smooth----------------------------------------------------------------------------------------

    smooth_Bx=smooth(Bx_m[*],30,/edge_truncate,/NAN)
    smooth_By=smooth(By_m[*],30,/edge_truncate,/NAN)
    smooth_Bz=smooth(Bz_m[*],30,/edge_truncate,/NAN)
    smooth_B=smooth(B_m[*],30,/edge_truncate,/NAN)
   
    Bx_wave=dblarr(row)
    By_wave=dblarr(row)
    Bz_wave=dblarr(row)
    B_wave=dblarr(587)
    
    for i=0,586 do begin
      Bx_wave(i)=Bx_m[i]-smooth_Bx[i]
      By_wave(i)=By_m[i]-smooth_By[i]
      Bz_wave(i)=Bz_m[i]-smooth_Bz[i]
      B_wave(i)=B_m[i]-smooth_B[i]
    endfor
    

;---------FFT-------------------------------------------------------------------------------------------
 
 
 
    dt=4.0
    f_Nyquist=1.0/(2.0*dt)*1000 ;mHz

    un=abs(FFT(B_wave))
    f=dblarr(293)
    su=dblarr(293)
    ts=4.0
    fs=1/ts

    for j=0,292  do begin
      f(j)=j/587.0*fs*1000
      su(j)=2*587.0*un[j]*un[j]/fs
    endfor

;-----------------------------------------------------------------------------------------------------

    entry_device=!d.name
    set_plot,'ps'
    device,/color,Bits_per_pixel=8.0
    TVLCT, r, g, b,/Get
    output_dir='E:\OneDrive\IDLworks\作业\小论文\'
    device,filename=output_dir+'tc1_FGM1_fft_and_wavelet.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
    !p.multi=[0,1,4,0,0]
    loadct,40
    device,decomposed=0
    
    plot,f[*],su[*],background=255,color=0,xticklen=0.04,yticklen=-0.02,$
      position=[0.10,0.75,0.90,0.95],thick=1.0,charsize=1.1,xstyle=1,ystyle=1,$
      xrange=[0.0,f_Nyquist],ylog=1,xtitle='!8f!X (mHz)',ytitle='S!Dpdy!n (nPa!U2!n/Hz)'

    loadct,33


    wbx=WAVELET(Bx_wave[*],dt,pad=2,period=period,coi=coi,signif=signif,/verb,j=j)
    wby=WAVELET(By_wave[*],dt,pad=2,period=period,coi=coi,signif=signif,/verb,j=j)
    wbz=WAVELET(Bz_wave[*],dt,pad=2,period=period,coi=coi,signif=signif,/verb,j=j)
   ; wb=sqrt(wbx^2+wby^2+wbz^2)
    wb=WAVELET(B_wave[*],dt,pad=2,period=period,coi=coi,signif=signif,/verb,j=j)


    f0=1.0/period*1000
    Nlevels=N_ELEMENTS(period)

    CONTOUR,ABS(wb)^2,tm[*],f0[*],position=[0.1,0.5,0.9,0.69],xticklen=-0.02,yticklen=-0.02,$
      ystyle=1,xstyle=1,zstyle=1,yrange=[0,40],$
      zrange=[-5,max(ABS(wb)^2)],background=0,color=0,nlevels=Nlevels,/fill,$
      ytitle='B_Period(s)',charsize=1.2

    colorbar_new,position=[0.93,0.5,0.94,0.69],ticklen=-0.3,color=0,NCOLORS=256,$
      range=[-5,max(ABS(wb)^2)],/vertical,/right,format='(f7.2)',title='nPa!U2!n',charsize=1.5


    device,/close_file
    set_plot,entry_device

  end   