pro EX_BOX, X0, Y0, X1, Y1, color
  POLYFILL, [X0, X0, X1, X1], [Y0, Y1, Y1, Y0], COL = color
END

pro c1_2003_fgm

A=FLTARR(6)
PT=FLTARR(6)
VXT=FLTARR(6)
filename0=file_search('D:\__Data\OMNI\*.cdf')
 for j=0,0 do begin 
  filename=filename0[j]
  ;file_search(strcompress('D:\__Data\OMNI\*'+strmid(strcompress(string(i,format='("0",i2)'),/remove_all),1,/reverse_offset)+'01_v01.cdf',/remove_all))
  loadcdf,filename,'Epoch',time
  loadcdf,filename,'BZ_GSM',B_z
  loadcdf,filename,'Vx',Vx_gse
  loadcdf,filename,'Vy',Vy_gse
  loadcdf,filename,'Vz',Vz_gse
  loadcdf,filename,'Pressure',p

  
  row=n_elements(time)
 
  V_gsm=dblarr(3,row)
  Vx=dblarr(row)

  for i=0,row-1L do begin
    if(abs(B_z[i])    gt 1.0e3)  then B_z[i]=B_z[i-1]
    if(abs(Vx_gse[i]) gt 1.0e4)  then Vx_gse[i]=Vx_gse[i-1]
    if(abs(Vy_gse[i]) gt 1.0e4)  then Vy_gse[i]=Vy_gse[i-1]
    if(abs(Vz_gse[i]) gt 1.0e4)  then Vz_gse[i]=Vz_gse[i-1]
    if(abs(p[i]) gt 50.0)  then p[i]=p[i-1]
  endfor


  ;-----------geopack-----------------------------------------------------------------------------------------

  for i=0L,row-1L do begin

    CDF_EPOCH,time[i],yr,mo,dy,hr,mn,sc,milli,/BREAKDOWN
    
    doy=julday(mo,dy,yr)-julday(01,01,yr)+1
    geopack_recalc,yr,doy,hr,mn,sc
    geopack_conv_coord,Vx_gse[i],Vy_gse[i],Vy_gse[i],Vx_gsm,Vy_gsm,Vz_gsm,/from_gse,/to_gsm
    V_gsm[0,i]=Vx_gsm
    V_gsm[1,i]=Vy_gsm
    V_gsm[2,i]=Vz_gsm

  endfor
    
    Vx=V_gsm[0,*]
;-----------plot-----------------------------------------------------------------------------------------

;    a=dblarr(6)
;    for i=0,5 do begin 
;      a[i]=0 
;    endfor
    for i=0,row-1L do begin
      if (abs(B_z[i]) gt 0.0 and abs(B_z[i]) le 2.0)  then a[0]++
      if (abs(B_z[i]) gt 2.0 and abs(B_z[i]) le 4.0)  then a[1]++
      if (abs(B_z[i]) gt 4.0 and abs(B_z[i]) le 6.0)  then a[2]++
      if (abs(B_z[i]) gt 6.0 and abs(B_z[i]) le 8.0)  then a[3]++
      if (abs(B_z[i]) gt 8.0 and abs(B_z[i]) le 10.0)  then a[4]++
      if (abs(B_z[i]) gt 10.0 )  then a[5]++
    endfor
 
;    pt=dblarr(6)
;    for i=0,5 do pt[i]=0
    for i=0,row-1L do begin
      if (abs(p[i]) gt 0.0 and abs(p[i]) le 2.0)  then pt[0]++
      if (abs(p[i]) gt 2.0 and abs(p[i]) le 4.0)  then pt[1]++
      if (abs(p[i]) gt 4.0 and abs(p[i]) le 6.0)  then pt[2]++
      if (abs(p[i]) gt 6.0 and abs(p[i]) le 8.0)  then pt[3]++
      if (abs(p[i]) gt 8.0 and abs(p[i]) le 10.0)  then pt[4]++
      if (abs(p[i]) gt 10.0 )  then pt[5]++
    endfor
    
;    Vxt=dblarr(6)
;    for i=0,5 do Vxt[i]=0
    for i=0,row-1L do begin
      if (abs(Vx[i]) gt 200.0 and abs(Vx[i]) le 300.0)  then Vxt[0]++
      if (abs(Vx[i]) gt 300.0 and abs(Vx[i]) le 400.0)  then Vxt[1]++
      if (abs(Vx[i]) gt 400.0 and abs(Vx[i]) le 500.0)  then Vxt[2]++
      if (abs(Vx[i]) gt 500.0 and abs(Vx[i]) le 600.0)  then Vxt[3]++
      if (abs(Vx[i]) gt 600.0 and abs(Vx[i]) le 700.0)  then Vxt[4]++
      if (abs(Vx[i]) gt 700.0 )  then Vxt[5]++
    endfor
   
     
  endfor
    
    xno=4 & x0=0.05 & x1=0.95 & detax=0.025 
    dx=(x1-x0-detax*(xno-1))/xno
    yno=4
    
    entry_device=!d.name
    set_plot,'ps'
    device,/color,Bits_per_pixel=8.0
    TVLCT, r, g, b,/Get
    output_dir='E:\OneDrive\IDLworks\cluster1_2003\'
    device,filename=output_dir+'omni_FGM_stat2.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
    !p.multi=[0,xno,yno,0,0]
    loadct,39
    device,decomposed=0
    
    
    xval_B=findgen(7)*2
    yval_B=a/total(a)
    yval_p=pt/total(pt)
    xval_Vx=findgen(7)+2
    yval_Vx=Vxt/total(vxt)
    
    PLOT, xval_B, yval_B, /YNOZERO, xtickv = xval_B, xticks = 6,yrange=[0,1], position=[x0,0.35,x0+dx,0.48],$
       xtickname = NAMES, /NODATA
    for i=0,5 do EX_BOX,xval_B[i],!y.CRANGE[0],xval_B[i]+2,yval_B[i],0
    
    PLOT, xval_B, yval_p, /YNOZERO, xtickv = xval_B, xticks = 6,yrange=[0,1], position=[x0,0.20,x0+dx,0.33],$
       xtickname = NAMES, /NODATA    
    for i=0,5 do EX_BOX,xval_B[i],!y.CRANGE[0],xval_B[i]+2,yval_p[i],128
    
    PLOT, xval_Vx, yval_Vx, /YNOZERO, xstyle=1, xticks = 6, xtickv=[2,3,4,5,6,7,8],yrange=[0,1], position=[x0,0.05,x0+dx,0.18],$
      xtickname = NAMES, /NODATA
    for i=0,5 do EX_BOX,xval_Vx[i],!y.CRANGE[0],xval_Vx[i]+1,yval_Vx[i],200
    
    
    device,/close_file
    set_plot,entry_device

end