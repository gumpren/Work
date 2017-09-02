pro tc1_20040803_geopack

  filename='E:\OneDrive\Data\Double_star\T1_PP_FGM_20040803_V03.cdf'
  loadcdf,filename,'Epoch__T1_PP_FGM',time
  loadcdf,filename,'B_xyz_gse__T1_PP_FGM',B_xyz
  
  row=n_elements(time)
  
  hour=fltarr(row)
  minute=fltarr(row) 
  second=fltarr(row)
  gBgsm=dBlarr(3,row)
  Bx_m=dblarr(row)
  By_m=dblarr(row)
  Bz_m=dblarr(row)
  Bx_e=dblarr(row)
  By_e=dblarr(row)
  Bz_e=dblarr(row) 
  tm=dblarr(row)
  Bxgse=B_xyz[*,0]
  Bygse=B_xyz[*,1]
  Bzgse=B_xyz[*,2]

 
  
  for i=0L,row-1L do begin
    
    if (abs(Bxgse[i]) gt 1.0e4) then  Bxgse(i)=Bxgse[i-1]
    if (abs(Bygse[i]) gt 1.0e4) then  Bygse(i)=Bygse[i-1]
    if (abs(Bzgse[i]) gt 1.0e4) then  Bzgse(i)=Bzgse[i-1]

    
    CDF_EPOCH,time[i],yr,mo,dy,hr,mn,sc,milli,/BREAKDOWN
    
    hour(i)=hr+mn/60.0+sc/3600.0+milli/3.6e6
    minute(i)=mn+sc/60.0+milli/6.0e5
    second(i)=sc+milli/5.0e3
    
    doy=julday(8,3,2004)-julday(1,1,2004)+1
    geopack_recalc,2004,doy,hr,mn,sc
    geopack_conv_coord,Bxgse[i],Bygse[i],Bzgse[i],Bxgsm,Bygsm,Bzgsm,/from_gse,/to_gsm

    gBgsm(0,i)=Bxgsm
    gBgsm(1,i)=Bygsm
    gBgsm(2,i)=Bzgsm
    
    
  endfor
  ;----------------------------------------------------------------------------------------------------
 
 
   index=where(hour gt 2.83333 and hour le 3.50 )

   Bx_m=gbgsm[0,index]
   BY_m=gbgsm[1,index]
   BZ_m=gbgsm[2,index]
   tm=hour[index]
   Bx_e=Bxgse[index]
   BY_e=Bygse[index]
   BZ_e=Bzgse[index]

  

;  for i=0,row-1L do begin
;     print,Bxgse(i)-gBgsm(0,i)
;  endfor

 ;----------------------------------------------------------------------------------------------------
 
  entry_device=!d.name
  set_plot,'ps'
  device,/color,Bits_per_pixel=8
  TVlct,r,g,b,/Get
  output_dir='E:\OneDrive\IDLworks\作业\小论文\'
  device,filename=output_dir+'tc1_FGM1.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
  !p.multi=[0,1,5,0,0]
  loadct,40
  device,decomposed=0
  
  plot,tm[*],Bx_m[*],position=[0.10,0.77,0.90,0.95],background=255,color=0,xticklen=0.04,yticklen=0.02,$
      thick=1.0,charsize=1.1,xstyle=1,ystyle=1,yrange=[-30,10];,xtickformat='(a1)'
  oplot,tm[*],Bx_e[*],color=0,linestyle=1
  oplot,tm[*],By_m[*],color=60
  oplot,tm[*],By_e[*],color=60,linestyle=1
  oplot,tm[*],Bz_m[*],color=150
  oplot,tm[*],Bz_e[*],color=150,linestyle=1
  
  xyouts,0.92,0.93,'Bx',alignment=0.0,charsize=0.8,color=0,font=0,/normal
  ;xyouts,0.92,0.90,'Bx_gse',alignment=0.0,charsize=0.8,color=0,font=0,linestyle=1,/normal
  xyouts,0.92,0.90,'By',alignment=0.0,charsize=0.8,color=60,font=0,/normal
  xyouts,0.92,0.87,'Bz',alignment=0.0,charsize=0.8,color=150,font=0,/normal
       
  device,/close_file
  set_plot,entry_device
  
;  index1=where(hour gt 3.0 and hour le 3.02 )
;  Bx_e=Bxgse[index1]
;  print,Bx_e
 
  
 
 
 end 