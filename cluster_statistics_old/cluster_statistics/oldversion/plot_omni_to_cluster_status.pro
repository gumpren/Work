
pro plot_omni_to_cluster_status
  start=systime(1)
  Re=6371
  nums=1.0

  root_dir='\2001_2009_median'
  restore,filepath('OMNI_2001_2009_Bz_Vxyz_p_AE_SYMH.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('C3_FGM_2001_2009_Bxyz_Positionxyz.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('time_need_omni_to_c3fgm_2001_2009.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('C3_CIS_2001_2009_n_vbxyz_p_t_need.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('eventimes_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)

  ;row=n_elements(t_omni)
  ;  t_omni=t_omni[0:n_elements(t_omni)/nums]
  ;  t_c3fgm=t_c3fgm[0:n_elements(t_c3fgm)/nums]
  ;  Bz_imf=Bz_imf[0:n_elements(Bz_imf)/nums]
  ;  p=p[0:n_elements(p)/nums]
  ;  Vx  =Vx[0:n_elements(Vx)/nums]

;  data=divide_bz(t_omni,Bz_imf,p,Vx)
 ; index=neighbor_time(t_c3fgm[t_need1],data.t1_omni)
  
  
  
;  t_need1=t_need1[where(t_need1 ne -1)]
;  t_need2=t_need2[where(t_need2 ne -1)]
;  t_need3=t_need3[where(t_need3 ne -1)]
;  t_need4=t_need4[where(t_need4 ne -1)]
;
;  eventimes1=return_eventimes(t_need1,x_pos,y_pos)
;  eventimes2=return_eventimes(t_need2,x_pos,y_pos)
;  eventimes3=return_eventimes(t_need3,x_pos,y_pos)
;  eventimes4=return_eventimes(t_need4,x_pos,y_pos)
;
;  savetime_event=(systime(1)-start)/60.0
;  
;  save,savetime_event,eventimes1,eventimes2,eventimes3,eventimes4,filename='eventimes.sav'
;  

 
  ;----------------------------------------------------------------------------------------------------
  xno=4 & x0=0.05 & x1=0.95 & detax=0.025
  ;dx=(x1-x0-detax*(xno-1))/xno
  dx=0.15
  yno=4


  entry_device=!d.name
  set_plot,'ps'
  device,/color,Bits_per_pixel=8.0
  TVLCT, r, g, b,/Get
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median\'
  device,filename=output_dir+'omni_FGM_state_2001_2009_gap0.833.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
  !p.multi=[0,xno,yno,0,0]
  loadct,39
  device,decomposed=0


  xval_B=findgen(7)*2
  xval_Vx=findgen(7)+2

  yval_B=fltarr(6,4)
  yval_p=fltarr(6,4)
  yval_Vx=fltarr(6,4)

  for i=0,5 do begin
    for j=0,3 do begin
      yval_B[i,j]=data_divided.bzt[i,j]/total(data_divided.bzt[*,j])
      yval_p[i,j]=data_divided.pt[i,j]/total(data_divided.pt[*,j])
      yval_Vx[i,j]=data_divided.vxt[i,j]/total(data_divided.vxt[*,j])
    endfor
  endfor


  PLOT, xval_B, yval_B[*,0], xtickv = xval_B, xticks = 6,yrange=[0,1],yticks=5,$
    ytickname=['0','20%','40%','60%','80%','100%'],position=[x0,0.35,x0+dx,0.48],xtickname = NAMES, /NODATA
  for i=0,5 do EX_BOX,xval_B[i],!y.CRANGE[0],xval_B[i]+2,yval_B[i,0],0
  PLOT, xval_B, yval_p[*,0],  xtickv = xval_B, xticks = 6,yrange=[0,1],yticks=5,$
    ytickname=['0','20%','40%','60%','80%','100%'], position=[x0,0.20,x0+dx,0.33],xtickname = NAMES, /NODATA
  for i=0,5 do EX_BOX,xval_B[i],!y.CRANGE[0],xval_B[i]+2,yval_p[i,0],0
  PLOT, xval_Vx, yval_Vx[*,0],  xstyle=1, xticks = 6, xtickv=[2,3,4,5,6,7,8],yrange=[0,1],yticks=5,$
    ytickname=['0','20%','40%','60%','80%','100%'], position=[x0,0.05,x0+dx,0.18],xtickname = NAMES, /NODATA
  for i=0,5 do EX_BOX,xval_Vx[i],!y.CRANGE[0],xval_Vx[i]+1,yval_Vx[i,0],0
  
  
  for j=1,3 do begin

    PLOT, xval_B, yval_B[*,j], /YNOZERO, xtickv = xval_B, xticks = 6,yrange=[0,1],ytickformat='(a1)', position=[x0+(detax+dx)*j,0.35,x0+dx+(detax+dx)*j,0.48],$
      xtickname = NAMES, /NODATA
    for i=0,5 do EX_BOX,xval_B[i],!y.CRANGE[0],xval_B[i]+2,yval_B[i,j],0

    PLOT, xval_B, yval_p[*,j], /YNOZERO, xtickv = xval_B, xticks = 6,yrange=[0,1],ytickformat='(a1)', position=[x0+(detax+dx)*j,0.20,x0+dx+(detax+dx)*j,0.33],$
      xtickname = NAMES, /NODATA
    for i=0,5 do EX_BOX,xval_B[i],!y.CRANGE[0],xval_B[i]+2,yval_p[i,j],0

    PLOT, xval_Vx, yval_Vx[*,j], /YNOZERO, xstyle=1, xticks = 6, xtickv=[2,3,4,5,6,7,8],yrange=[0,1],ytickformat='(a1)', position=[x0+(detax+dx)*j,0.05,x0+dx+(detax+dx)*j,0.18],$
      xtickname = NAMES, /NODATA
    for i=0,5 do EX_BOX,xval_Vx[i],!y.CRANGE[0],xval_Vx[i]+1,yval_Vx[i,j],0

  endfor
  
  
  
  maxtime1=max([max(eventimes1),max(eventimes2),max(eventimes3),max(eventimes4)])
  
  
  index1=where(eventimes1 eq 0)
  eventimes1[index1]=!values.f_nan
  index2=where(eventimes2 eq 0)
  eventimes2[index2]=!values.f_nan
  index3=where(eventimes3 eq 0)
  eventimes3[index3]=!values.f_nan
  index4=where(eventimes4 eq 0)
  eventimes4[index4]=!values.f_nan

  top_flux=450
  ncolors=250
  bottom=0
  cgloadct,39,bottom=0,ncolors=ncolors
  scaled1=calculate_colors(alog10(eventimes1),-1,alog10(top_flux),Bottom,Ncolors)
  scaled2=calculate_colors(alog10(eventimes2),-1,alog10(top_flux),Bottom,Ncolors)
  scaled3=calculate_colors(alog10(eventimes3),-1,alog10(top_flux),Bottom,Ncolors)
  scaled4=calculate_colors(alog10(eventimes4),-1,alog10(top_flux),Bottom,Ncolors)
; scaled1=calculate_colors(eventimes1,0,top_flux,Bottom,Ncolors)
; scaled2=calculate_colors(eventimes2,0,top_flux,Bottom,Ncolors)
; scaled3=calculate_colors(eventimes3,0,top_flux,Bottom,Ncolors)
; scaled4=calculate_colors(eventimes4,0,top_flux,Bottom,Ncolors) 
  
  scaled1[index1]=255
  scaled2[index2]=255
  scaled3[index3]=255
  scaled4[index4]=255

  tv,scaled1,x0,0.51,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled2,x0+dx+detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled3,x0+2*dx+2*detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled4,x0+3*dx+3*detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  
  loadct,39
  
  colorbar_new,position=[x0+4*dx+4*detax,0.51,x0+4*dx+5*detax,0.72],ticklen=-0.3,color=0,NCOLORS=256,$
    range=[0,top_flux],/vertical,/right,format='(i5.2)',title='times',charsize=1.0
  

  xl=findgen(10)
  yl=findgen(30)
  plot, xl, yl, /NOERASE,  xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yrange=[15,- 15],yticks=6,yminor=5,yticklen=0.05,$
    ytickv=[15,10,5,0,-5,-10,-15],position=[x0,0.51,x0+dx,0.51+2.8*dx],xtickname = NAMES, /NODATA
  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
    position=[x0+dx+detax,0.51,x0+2*dx+detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
    position=[x0+2*dx+2*detax,0.51,x0+3*dx+2*detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yticklen=0.05,ytickformat='(a1)',$
    position=[x0+3*dx+3*detax,0.51,x0+4*dx+3*detax,0.51+2.8*dx],xtickname = NAMES, /NODATA

  xyouts,0.125,0.97,'IMF Bz>0  dt>1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  xyouts,0.3,0.97,'IMF Bz>0  dt<1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  xyouts,0.475,0.97,'IMF Bz<0  dt>1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  xyouts,0.65,0.97,'IMF Bz< 0  dt>1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  
  xyouts,0.17,0.15,'|V!Dx!n|',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  xyouts,0.17,0.3,'P!Ddyn!n',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  xyouts,0.17,0.45,'|B!Dz!n|',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  
  xyouts,0.76,0.033,'(10!u2!n!xkm/s)',color=0,alignment=0.5,charsize=0.4,font=0,/normal
  xyouts,0.76,0.183,'(nPa)',color=0,alignment=0.5,charsize=0.4,font=0,/normal
  xyouts,0.76,0.333,'(nT)',color=0,alignment=0.5,charsize=0.4,font=0,/normal
 

  device,/close_file
  set_plot,entry_device
  
  stop

end