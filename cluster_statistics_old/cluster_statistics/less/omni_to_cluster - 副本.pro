
pro EX_BOX, X0, Y0, X1, Y1, color
  POLYFILL, [X0, X0, X1, X1], [Y0, Y1, Y1, Y0], COL = color
END

pro omni_to_cluster

  a=dblarr(6,4)
  pt=dblarr(6,4)
  vxt=dblarr(6,4)
    
  restore,filepath('OMNI_2001_Bz_Vxyz_p.sav',root_dir='C:\Users\云风')
  print,time_omni[0]
  restore,filepath('C3_FGM_2001_Bxyz_Positionxyz.sav',root_dir='C:\Users\云风')
  print,time_c3fgm[0]
  
  
  filename0=file_search('D:\__Data\OMNI\*.cdf')
  for j=0,11 do begin
    filename=filename0[0]
    yymmdd=strmid(filename,29,8)
    time_base=time_double(yymmdd+'/00:00:00')
    omnidata=loadcdf_all_variable(filename,g_attributes=g_attributes,atts=atts,var_structure=var_structure,_extra=extra_)

    time_new=omnidata.Epoch
    B_z=omnidata.BZ_GSM
    Vx_gse=omnidata.Vx
    Vy_gse=omnidata.Vy
    Vz_gse=omnidata.Vz
    p=omnidata.Pressure
    
   ; t=time_base+findgen(n_elements(time_new))*60.0
    index=where(abs(Vx_gse) le 10000.0 and abs(Vy_gse) le 10000.0 and abs(Vz_gse) le 10000.0)
    store_data,'Vgse',data={x:time_new[index],y:[[Vx_gse[index]],[Vy_gse[index]],[Vz_gse[index]]]}
    tinterpol,'Vgse',time_new,/overwrite,/nearest_neighbor
    cotrans,'Vgse','Vgsm',/gse2gsm
    get_data,'Vgsm',t,Vgsm;data=data
    ;V_gse=create_struct('x',time_double('20010101/00:00:00')+findgen(44640)*60.0,'y',[[Vx_gse],[Vy_gse],[Vz_gse]])
;    row=n_elements(time_new)
;    V_gsm=dblarr(3,row)
;    Vx=dblarr(row)
;
    if (j eq 0) then time=time_new else time=[time,time_new]

;-----------geopack-----------------------------------------------------------------------------------------
    
    ;sub_GSE2GSM,V_gse,V_gsm
    Vx=Vgsm[*,0]

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

  ;-----------status_of_Bz----------------------啊啊啊-------------------------------------------------------------------


  filename2=file_search('D:\__Data\Cluster\CLuster\CP_FGM_SPIN\'+'*'+yymmdd+'*.cdf')
  for j=0,0 do begin
    filenamea=filename2[j]
    c3data=loadcdf_all_variable(filenamea,g_attributes=g_attributes,atts=atts,var_structure=var_structure,_extra=extra_)
    time1_new=c3data.time_tags__C3_CP_FGM_SPIN
    scposition=c3data.sc_pos_xyz_gse__C3_CP_FGM_SPIN
    
    row=n_elements(time1_new)
    x_sc=scposition[*,0]
    y_sc=scposition[*,1]
    z_sc=scposition[*,2]
    pos_gsm=dblarr(row,3)
    
    index=where(abs(x_sc) le 1.0e9 and abs(y_sc) le 1.0e9 and abs(z_sc) le 1.0e9)
    store_data,'pos_gse',data={x:time1_new[index],y:[[x_sc[index]],[y_sc[index]],[z_sc[index]]]}
    tinterpol,'pos_gse',time1_new,/overwrite,/nearest_neighbor
    cotrans,'pos_gse','pos_gsm',/gse2gsm
    get_data,'pos_gsm',t,pos_gsm;data=data
    
  ;  if (j eq 0) then time1=time1_new else time1=[time1,time1_new]

  
    for k=0,row-1L do begin
      for ii=-10,9 do begin
        for jj=-10,9 do begin
          if  (x_sc[k] gt 2*ii*Re) and (x_sc[k] le 2*(ii+1)*Re) and (y_sc[k] gt 2*jj*Re) and (y_sc[k] le 2*(jj+1)*Re) then eventimes[ii+10,jj+10]++
        endfor
      endfor
    endfor
  endfor
  
  etimes=create_struct('time',time_base,'etimes',eventimes)
  output_file='D:\__Data\Cluster\CLuster\CP_FGM_SPIN\eventimes00.cdf'
  ;makecdf_base_TDAS,'20010101/00:00:00','D:\__Data\Cluster\CLuster\CP_FGM_SPIN\eventimes.cdf',etimes
  makecdf,etimes,filename=output_file,status=status, /overwrite

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