
pro omni_2003

  a=dblarr(6,4)
  pt=dblarr(6,4)
  vxt=dblarr(6,4)

  filename0=file_search('D:\__Data\OMNI\*.cdf')
  for j=0,11 do begin
    filename=filename0[j]
    ;file_search(strcompress('D:\__Data\OMNI\*'+strmid(strcompress(string(i,format='("0",i2)'),/remove_all),1,/reverse_offset)+'01_v01.cdf',/remove_all))
    
       
    loadcdf,filename,'Epoch',time_new
    loadcdf,filename,'BZ_GSM',B_z
    loadcdf,filename,'Vx',Vx_gse
    loadcdf,filename,'Vy',Vy_gse
    loadcdf,filename,'Vz',Vz_gse
    loadcdf,filename,'Pressure',p
    
    row=n_elements(data.epoch)
    V_gsm=dblarr(3,row)
    Vx=dblarr(row)

    if (j eq 0) then time=time_new else time=[time,time_new]


    for i=0,row-1L do begin
      if(abs(B_z[i])    gt 1.0e3)  then B_z[i]=B_z[i-1]
      if(abs(Vx_gse[i]) gt 1.0e4)  then Vx_gse[i]=Vx_gse[i-1]
      if(abs(Vy_gse[i]) gt 1.0e4)  then Vy_gse[i]=Vy_gse[i-1]
      if(abs(Vz_gse[i]) gt 1.0e4)  then Vz_gse[i]=Vz_gse[i-1]
      if(abs(p[i]) gt 50.0)  then p[i]=p[i-1]
    endfor

    ;-----------geopack-----------------------------------------------------------------------------------------

    for i=0L,row-1L do begin
      CDF_EPOCH,time_new[i],yr,mo,dy,hr,mn,sc,milli,/BREAKDOWN
      doy=julday(mo,dy,yr)-julday(01,01,yr)+1

      geopack_recalc,yr,doy,hr,mn,sc
      geopack_conv_coord,Vx_gse[i],Vy_gse[i],Vy_gse[i],Vx_gsm,Vy_gsm,Vz_gsm,/from_gse,/to_gsm
      V_gsm[0,i]=Vx_gsm
      V_gsm[1,i]=Vy_gsm
      V_gsm[2,i]=Vz_gsm
    endfor

    Vx=V_gsm[0,*]

    data=divide_bz(row,B_z,p,Vx,a,pt,vxt)
    ;    Bz11=dblarr(n_elements(data_new.Bz1))
    ;    Bz21=dblarr(n_elements(data_new.Bz2))
    ;    Bz31=dblarr(n_elements(data_new.Bz3))
    ;    Bz41=dblarr(n_elements(data_new.Bz4))
    ;    row_1=dblarr(n_elements(data_new.row_))
    ;    a1=dblarr(n_elements(data_new.a))
    ;    pt1=dblarr(n_elements(data_new.pt))
    ;    vxt1=dblarr(n_elements(data_new.vxt))

    if (j eq 0) then begin
      Bz11=data.Bz1
      Bz21=data.Bz2
      Bz31=data.Bz3
      Bz41=data.Bz4
      ;      row_1=data.row_
      ;      a1=data.a
      ;      pt1=data.pt
      ;      vxt1=data.vxt
    endif else begin
      Bz11=[Bz11,data.Bz1]
      Bz21=[Bz21,data.Bz2]
      Bz31=[Bz31,data.Bz3]
      Bz41=[Bz41,data.Bz4]
      ;      row_1=[row_1,data_new.row_]
      ;      a1=[a1,data_new.a]
      ;      pt1=[pt1,data_new.pt]
      ;      vxt1=[vxt1,data_new.vxt]
    endelse
    data1=create_struct('Bz11',Bz11,'Bz21',Bz21,'Bz31',Bz31,'Bz41',Bz41)

    ; print,data.row_
    ; print,n_elements(data.Bz1)
    ; print,time[200]-time[199]


  endfor

  brow1=n_elements(Bz11)
  brow2=n_elements(Bz21)
  brow3=n_elements(Bz31)
  brow4=n_elements(Bz41)
  ; allrow=n_elements(time)

  eventimes=dblarr(20,20)
  Re=6371

  ;-----------status_of_Bz----------------------�����------------------------------------------------------------------

  filename2=file_search('D:\__Data\Cluster\CLuster\CP_FGM_SPIN\*.cdf')
  for j=0,0 do begin
    filename=filename2[j]
    loadcdf,filename,'time_tags__C3_CP_FGM_SPIN',time1_new
    loadcdf,filename,'sc_pos_xyz_gse__C3_CP_FGM_SPIN',scposition

    row=n_elements(time1_new)
    x_sc=scposition[*,0]
    y_sc=scposition[*,1]
    z_sc=scposition[*,2]
    pos_gsm=dblarr(row,3)

    if (j eq 0) then time1=time1_new else time1=[time1,time1_new]

    for i=0,row-1L do begin
      if (abs(x_sc[i]) gt 1.0e9) then x_sc[i]=x_sc[i-1]
      if (abs(y_sc[i]) gt 1.0e9) then y_sc[i]=y_sc[i-1]
      if (abs(z_sc[i]) gt 1.0e9) then z_sc[i]=z_sc[i-1]
    endfor

    for i=0L,row-1L do begin
      CDF_EPOCH,time1_new[i],yr,mo,dy,hr,mn,sc,milli,/BREAKDOWN
      doy=julday(mo,dy,yr)-julday(01,01,yr)+1

      geopack_recalc,yr,doy,hr,mn,sc
      geopack_conv_coord,x_sc[i],y_sc[i],z_sc[i],xp_gsm,yp_gsm,zp_gsm,/from_gse,/to_gsm
      pos_gsm[i,0]=xp_gsm
      pos_gsm[i,1]=yp_gsm
      pos_gsm[i,2]=zp_gsm
    endfor

    for k=0,row-1L do begin
      for ii=-10,9 do begin
        for jj=-10,9 do begin
          if  (x_sc[k] gt 2*ii*Re) and (x_sc[k] le 2*(ii+1)*Re) and (y_sc[k] gt 2*jj*Re) and (y_sc[k] le 2*(jj+1)*Re) then eventimes[ii+10,jj+10]++
        endfor
      endfor
    endfor
  endfor


  ;----------------------------------------------------------------------------------------------------
  xno=4 & x0=0.05 & x1=0.95 & detax=0.025
  dx=(x1-x0-detax*(xno-1))/xno
  yno=4

  entry_device=!d.name
  set_plot,'ps'
  device,/color,Bits_per_pixel=8.0
  TVLCT, r, g, b,/Get
  output_dir='E:\OneDrive\IDLworks\cluster_statistics\ps\'
  device,filename=output_dir+'omni_FGM_state1.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
  !p.multi=[0,xno,yno,0,0]
  loadct,39
  device,decomposed=0


  xval_B=findgen(7)*2
  xval_Vx=findgen(7)+2

  yval_B=dblarr(6,4)
  yval_p=dblarr(6,4)
  yval_Vx=dblarr(6,4)

  for i=0,5 do begin
    for j=0,3 do begin
      yval_B[i,j]=data.a[i,j]/total(data.a[*,j])
      yval_p[i,j]=data.pt[i,j]/total(data.pt[*,j])
      yval_Vx[i,j]=data.vxt[i,j]/total(data.vxt[*,j])
    endfor
  endfor

  for j=0,3 do begin

    PLOT, xval_B, yval_B[*,j], /YNOZERO, xtickv = xval_B, xticks = 6,yrange=[0,1], position=[x0+(detax+dx)*j,0.35,x0+dx+(detax+dx)*j,0.48],$
      xtickname = NAMES, /NODATA
    for i=0,5 do EX_BOX,xval_B[i],!y.CRANGE[0],xval_B[i]+2,yval_B[i,j],0

    PLOT, xval_B, yval_p[*,j], /YNOZERO, xtickv = xval_B, xticks = 6,yrange=[0,1], position=[x0+(detax+dx)*j,0.20,x0+dx+(detax+dx)*j,0.33],$
      xtickname = NAMES, /NODATA
    for i=0,5 do EX_BOX,xval_B[i],!y.CRANGE[0],xval_B[i]+2,yval_p[i,j],128

    PLOT, xval_Vx, yval_Vx[*,j], /YNOZERO, xstyle=1, xticks = 6, xtickv=[2,3,4,5,6,7,8],yrange=[0,1], position=[x0+(detax+dx)*j,0.05,x0+dx+(detax+dx)*j,0.18],$
      xtickname = NAMES, /NODATA
    for i=0,5 do EX_BOX,xval_Vx[i],!y.CRANGE[0],xval_Vx[i]+1,yval_Vx[i,j],200

  endfor
  
  loadct,25
  
  scaled=bytscl(eventimes,min=10000,max=80000,top=250,/nan)
  tv,scaled,x0,0.50,xsize=dx,ysize=dx,/normal
  
  
  device,/close_file
  set_plot,entry_device

end