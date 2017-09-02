pro mva
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


;-----------------------------------------------------------------------------------------------------

  D=Bgsm[*,*]

  Minmum_Variable_Analysis,D,n,lamda,A

  maxm=-A[*,0]
  inte=-A[*,1]
  minm=-A[*,2]

  print,'max/int',lamda[0]/lamda[1]

  print,'int/min',lamda[1]/lamda[2]

  

  bm=dblarr(n)
  bl=dblarr(n)
  bn=dblarr(n)


  for i=0L,n-1 do begin


    bl(i)=dot_multiply(D[*,i],maxm)
    bm(i)=dot_multiply(D[*,i],inte)
    bn(i)=dot_multiply(D[*,i],minm)
 
  endfor

  

;-----------------------------------------------------------------------------------------------------

  entry_device=!d.name
  set_plot,'ps'
  device,/color,Bits_per_pixel=8.0
  TVLCT, r, g, b,/Get
  output_dir='E:\OneDrive\IDLworks\作业\小论文\'
  device,filename=output_dir+'mva.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
 ; !p.multi=[0,1,4,0,0]
  loadct,40
  device,decomposed=0

  plot,tm[*],bl[*],background=255,color=0,xticklen=0.04,yticklen=-0.02,$
    thick=1.0,charsize=1.1, xstyle=1,ystyle=1,xtitle='UT',ytitle='B(nT)'
   
;    xticks=7,xtickv=[2.8333,2.9,3.0,3.1,3.2,3.3,3.4,3.5],$
;    xtickname=['02:50','02:54','03:00','03:06','03:12','03:18','03:24','03:30']
  
  device,/close_file
  set_plot,entry_device
  
  
 end
 