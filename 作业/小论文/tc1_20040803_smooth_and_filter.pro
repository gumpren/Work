pro tc1_20040803_smooth_and_filter
      filename='E:\OneDrive\Data\Double_star\T1_PP_FGM_20040803_V03.cdf'
      loadcdf,filename,'Epoch__T1_PP_FGM',time
      loadcdf,filename,'B_xyz_gse__T1_PP_FGM',B_xyz
  
      row=n_elements(time)
      Bgsm=dblarr(row,3)
  
      hour=dblarr(row)
      minute=dblarr(row)
      second=dblarr(row)
  
      Bx_m=dblarr(row)
      By_m=dblarr(row)
      Bz_m=dblarr(row)
  
      Bxgse=B_xyz[*,0]
      Bygse=B_xyz[*,1]
      Bzgse=B_xyz[*,2]

      for i=0L,row-1L do begin

        if (abs(Bxgse[i]) gt 1.0e4) then  Bxgse(i)=Bxgse[i-1]
        if (abs(Bygse[i]) gt 1.0e4) then  Bygse(i)=Bygse[i-1]
        if (abs(Bzgse[i]) gt 1.0e4) then  Bzgse(i)=Bzgse[i-1]
  
      endfor
 
;----------------------------------------------------------------------------------------------------
 
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
  
;---------------------------------------------------------------------------------------------------- 
  
      smooth_Bx=smooth(Bx_m[*],30,/edge_truncate,/NAN)
      smooth_By=smooth(By_m[*],30,/edge_truncate,/NAN)
      smooth_Bz=smooth(Bz_m[*],30,/edge_truncate,/NAN)
  
      Bx_wave=dblarr(row)
      By_wave=dblarr(row)
      Bz_wave=dblarr(row)
      B_wave=dblarr(row)
      Pc4_Pc5_wave_B=dblarr(row)
  
      for i=0,586 do begin
        Bx_wave(i)=Bx_m[i]-smooth_Bx[i]
        By_wave(i)=By_m[i]-smooth_By[i]
        Bz_wave(i)=Bz_m[i]-smooth_Bz[i]
      endfor
      
      B_wave=sqrt(Bx_wave^2+By_wave^2+Bz_wave^2)
;----------------------------------------------------------------------------------------------------
 
      deta=4.0
      f_Nyquist=1.0/(2.0*deta)*1000 ;mHz
      Pc4_Pc5_coeff=digital_filter(2.0/f_Nyquist,22.0/f_Nyquist,50,100)
      help,Pc4_Pc5_coeff[*]

      Pc4_Pc5_wave_Bx=convol(Bx_m[*],Pc4_Pc5_coeff[*],1)
      Pc4_Pc5_wave_By=convol(By_m[*],Pc4_Pc5_coeff[*],1)
      Pc4_Pc5_wave_Bz=convol(Bz_m[*],Pc4_Pc5_coeff[*],1)
      
      Pc4_Pc5_wave_B=sqrt(Pc4_Pc5_wave_Bx^2+Pc4_Pc5_wave_By^2+Pc4_Pc5_wave_Bz^2)
      
;----------------------------------------------------------------------------------------------------      
     
      entry_device=!d.name
      set_plot,'ps'
      device,/color,Bits_per_pixel=8.0
      TVLCT, r, g, b,/Get
      output_dir='E:\OneDrive\IDLworks\作业\小论文\'
      device,filename=output_dir+'tc1_FGM1_smooth_and_fliter.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
      !p.multi=[0,1,4,0,0]
      loadct,38
      device,decomposed=0
      
      
      plot,tm[*],Bx_m[*],position=[0.10,0.77,0.90,0.95],Background=255,color=0,xstyle=1 ,xtickformat='(a1)',ytitle='B (nT)',charsize=1.3
      oplot,tm[*],smooth_Bx[*],color=250
      oplot,tm[*],smooth_By[*],color=70
      oplot,tm[*],By_m[*],color=65
      oplot,tm[*],Bz_m[*],color=200
      oplot,tm[*],smooth_Bz[*],color=205
      
      xyouts,0.94,0.87,'Bx',color=250,charsize=0.8,alignment=0,/normal
      xyouts,0.94,0.84,'By',color=70,charsize=0.8,alignment=0,/normal
      xyouts,0.94,0.81,'Bz',color=200,charsize=0.8,alignment=0,/normal
      
;      plot,tm[*],Pc4_Pc5_wave_Bx[*],position=[0.1,0.5,0.9,0.7],Background=255,color=0,xstyle=1 ,yrange=[-20,10],ytitle='!4dB!Xx (nT)', charsize=1.3,xtickformat='(a1)'
;      oplot,tm[*],Bx_wave[*],color=210
;
;      plot,tm[*],Pc4_Pc5_wave_By[*],position=[0.1,0.3,0.9,0.5],Background=255,color=0,xstyle=1 ,yrange=[-20,15],ytitle='!4dB!Xy (nT)', xtickformat='(a1)',charsize=1.3
;      oplot,tm[*],By_wave[*],color=70

      plot,tm[*],Pc4_Pc5_wave_B[*],position=[0.1,0.59,0.9,0.77],Background=255,color=0,xstyle=1 ,xtitle='UT',ytitle='!4dB!X (nT)', charsize=1.3,$
         xticks=7,xtickv=[2.8333,2.9,3.0,3.1,3.2,3.3,3.4,3.5],xtickname=['02:50','02:54','03:00','03:06','03:12','03:18','03:24','03:30']
      oplot,tm[*],B_wave[*],color=90

      xyouts,0.20,0.92,'(a)',color=0,alignment=1.0,charsize=0.8,font=0,/normal
      xyouts,0.20,0.74,'(b)',color=0,charsize=0.8,alignment=1.0,font=0,/normal
      xyouts,0.94,0.70,'normal fliter',color=90,alignment=0.0,font=0,charsize=0.8,/normal
      xyouts,0.94,0.67,'digtal fliter',color=0,alignment=0.0,font=0,charsize=0.8,/normal
;      xyouts,0.20,0.47,'(c)',color=0,charsize=0.8,alignment=1.0,font=0,/normal
;      xyouts,0.20,0.27,'(d)',color=0,charsize=0.8,alignment=1.0,font=0,/normal

      device,/close_file
      set_plot,entry_device

    end