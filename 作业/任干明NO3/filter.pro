Pro filter


  openr,lun,filepath('TC1_20050824_Magnetic Field.TXT',root_dir='E:\OneDrive\IDLworks\作业\任干明NO3'),/get_lun
  tc1Bdat=dBlarr(13,19494)
  readf,lun,tc1Bdat
  free_lun,lun

  Bxgse=tc1Bdat[8,*]
  Bygse=tc1Bdat[9,*]
  Bzgse=tc1Bdat[10,*]
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

  gBgsm=dBlarr(3,19494)

  for i=0,19493 do Begin

   geopack_recalc,2005,236,tc1Bdat[0,i],tc1Bdat[1,i],tc1Bdat[2,i]
   geopack_conv_coord,Bxgse[i],Bygse[i],Bzgse[i],Bxgsm,Bygsm,Bzgsm,/from_gse,/to_gsm


   gBgsm(0,i)=Bxgsm
   gBgsm(1,i)=Bygsm
   gBgsm(2,i)=Bzgsm

  endfor
    
   Bx=gBgsm[0,5375:6713]
   By=gBgsm[1,5375:6713]
   Bz=gBgsm[2,5375:6713]

;---------------------------------------------------------------------------------------------
;Filter=original_data-smooth_data  (Background_value)

   smooth_Bx=smooth(Bx[*],30,/edge_truncate,/NAN)
   smooth_By=smooth(By[*],30,/edge_truncate,/NAN)
   smooth_Bz=smooth(Bz[*],30,/edge_truncate,/NAN)
   
;   help,smooth_tc

   Bx_wave=fltarr(1339)
   By_wave=fltarr(1339)
   Bz_wave=fltarr(1339)
   
   for i=0,1338 do Begin

   Bx_wave(i)=Bx[i]-smooth_Bx[i]
   By_wave(i)=By[i]-smooth_By[i]
   Bz_wave(i)=Bz[i]-smooth_Bz[i]

   endfor

;----------------------------------------------------------------------------------------------
;Filter through the function of digital_filter
   deta=4.0  ;Sampling time interval in seconds
   f_Nyquist=1.0/(2.0*deta)*1000 ;mHz
   Pc4_Pc5_coeff=digital_filter(2.0/f_Nyquist,22.0/f_Nyquist,50,150)

   help,Pc4_Pc5_coeff[*]

   h1=h[5375:6713]

   Pc4_Pc5_wave_Bx=convol(Bx[*],Pc4_Pc5_coeff[*],1)
   Pc4_Pc5_wave_By=convol(By[*],Pc4_Pc5_coeff[*],1)
   Pc4_Pc5_wave_Bz=convol(Bz[*],Pc4_Pc5_coeff[*],1)

; help,wave

   entry_device=!d.name
   set_plot,'ps'
   device,/color,Bits_per_pixel=8
   TVLCT, r, g, B, /Get
   output_dir='E:\OneDrive\IDLworks\作业\任干明NO3\'
   device,filename=output_dir+'smooth_filter.ps',xsize=5.5,ysize=6.5,$
      xoffset=1,yoffset=2,/inches,/encapsulated
    !p.multi=[0,1,4,0,0]
   loadct,38
   device,decomposed=0

   plot,h1[*],Bx[*],position=[0.1,0.7,0.9,0.9],Background=255,color=0,xstyle=1,xrange=[6.0,7.5],yrange=[-50,150],xtickformat='(a1)',ytitle='B (nT)',charsize=1.3
   oplot,h1[*],smooth_Bx[*],color=250
   oplot,h1[*],smooth_By[*],color=70
   oplot,h1[*],By[*],color=65
   oplot,h1[*],Bz[*],color=200
   oplot,h1[*],smooth_Bz[*],color=205
   
   xyouts,0.96,0.83,'Bx',color=250,charsize=0.8,alignment=1.0,/normal
   xyouts,0.96,0.80,'By',color=70,charsize=0.8,alignment=1.0,/normal
   xyouts,0.96,0.77,'Bz',color=200,charsize=0.8,alignment=1.0,/normal

   plot,h1[*],Pc4_Pc5_wave_Bx[*],position=[0.1,0.5,0.9,0.7],Background=255,color=0,xstyle=1,xrange=[6.0,7.5],yrange=[-20,10],ytitle='!4dB!Xx (nT)',xticks=3,xtickv=[6.2,6.5,7.0,7.5],xtickname=['00:00','06:00','12:00','18:00'], charsize=1.3
   oplot,h1[*],Bx_wave[*],color=210
   
   plot,h1[*],Pc4_Pc5_wave_By[*],position=[0.1,0.3,0.9,0.5],Background=255,color=0,xstyle=1,xrange=[6.0,7.5],yrange=[-20,15],ytitle='!4dB!Xy (nT)', xtickformat='(a1)',charsize=1.3
   oplot,h1[*],By_wave[*],color=70
   
   plot,h1[*],Pc4_Pc5_wave_Bz[*],position=[0.1,0.1,0.9,0.3],Background=255,color=0,xstyle=1,xrange=[6.0,7.5],xtitle='UT',ytitle='!4dB!Xz (nT)', charsize=1.3
   oplot,h1[*],Bz_wave[*],color=90
   




   xyouts,0.20,0.87,'(a)',color=0,alignment=1.0,charsize=0.8,font=0,/normal
   xyouts,0.20,0.67,'(b)',color=0,charsize=0.8,alignment=1.0,font=0,/normal
   xyouts,0.20,0.47,'(c)',color=0,charsize=0.8,alignment=1.0,font=0,/normal
   xyouts,0.20,0.27,'(d)',color=0,charsize=0.8,alignment=1.0,font=0,/normal


   device,/close_file
   set_plot,entry_device


end