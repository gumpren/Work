pro plot_velocity_massflux_energyflux
  
  root_dir='\2001_2009_median'
  restore,filepath('OMNI_2001_2009_Bz_Vxyz_p_AE_SYMH.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('C3_FGM_2001_2009_Bxyz_Positionxyz.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('time_need_omni_to_c3fgm_2001_2009.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('C3_CIS_2001_2009_n_vbxyz_p_t_need.sav',root_dir='C:\__Data\Datasave'+root_dir)
  
  restore,filepath('event_n_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('event_vxy_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('Qk_Qt_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('event_qk_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('event_qt_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)

  xno=4 & x0=0.05 & x1=0.95 & detax=0.025
  dx=0.15
  yno=1

  ;  ;——————————————————————————————————————plot velocity distributions————————————————————————————————————————
  ;
  ;  entry_device=!d.name
  ;  set_plot,'ps'
  ;  device,/color,Bits_per_pixel=8.0
  ;  TVLCT, r, g, b,/Get
  ;  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median\'
  ;  device,filename=output_dir+'velocity_2001_2009_median.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
  ;  !p.multi=[0,4,1,0,0]
  ;  loadct,39
  ;  device,decomposed=0
  ;
  ;  index1=where(event_vy1 eq 0)
  ;  event_vy1[index1]=!values.f_nan
  ;  index2=where(event_vy2 eq 0)
  ;  event_vy2[index2]=!values.f_nan
  ;  index3=where(event_vy3 eq 0)
  ;  event_vy3[index3]=!values.f_nan
  ;  index4=where(event_vy4 eq 0)
  ;  event_vy4[index4]=!values.f_nan
  ;
  ;  top_flux=50.0
  ;  bottom_flux=-50.0
  ;
  ;  ncolors=200
  ;  bottom=0
  ;  title='Vy(km/s)'
  ;  cgloadct,33,bottom=0,ncolors=ncolors
  ;  scaled1=calculate_colors(event_vy1,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled2=calculate_colors(event_vy2,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled3=calculate_colors(event_vy3,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled4=calculate_colors(event_vy4,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled1[index1]=255
  ;  scaled2[index2]=255
  ;  scaled3[index3]=255
  ;  scaled4[index4]=255
  ;
  ;  tv,scaled1,x0,0.07,xsize=dx,ysize=2.8*dx,/normal
  ;  tv,scaled2,x0+dx+detax,0.07,xsize=dx,ysize=2.8*dx,/normal
  ;  tv,scaled3,x0+2*dx+2*detax,0.07,xsize=dx,ysize=2.8*dx,/normal
  ;  tv,scaled4,x0+3*dx+3*detax,0.07,xsize=dx,ysize=2.8*dx,/normal
  ;
  ;  loadct,39
  ;
  ;  colorbar_new,position=[x0+4*dx+4*detax,0.07,x0+4*dx+5*detax,0.28],ticklen=-0.3,color=0,NCOLORS=256,$
  ;    range=[bottom_flux,top_flux],/vertical,/right,format='(f7.3)',title=title,charsize=1.0,/log
  ;
  ;  xl=findgen(10)
  ;  yl=findgen(30)
  ;  plot, xl, yl, /NOERASE,  xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yrange=[15,- 15],yticks=6,yminor=5,yticklen=0.05,$
  ;    ytickv=[15,10,5,0,-5,-10,-15],position=[x0,0.07,x0+dx,0.07+2.8*dx],xtickname = NAMES, /NODATA
  ;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
  ;    position=[x0+dx+detax,0.07,x0+2*dx+detax,0.07+2.8*dx],xtickname = NAMES, /NODATA
  ;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
  ;    position=[x0+2*dx+2*detax,0.07,x0+3*dx+2*detax,0.07+2.8*dx],xtickname = NAMES, /NODATA
  ;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yticklen=0.05,ytickformat='(a1)',$
  ;    position=[x0+3*dx+3*detax,0.07,x0+4*dx+3*detax,0.07+2.8*dx],xtickname = NAMES, /NODATA
  ;
  ;
  ;
  ;
  ;  index1=where(event_vx1 eq 0)
  ;  event_vx1[index1]=!values.f_nan
  ;  index2=where(event_vx2 eq 0)
  ;  event_vx2[index2]=!values.f_nan
  ;  index3=where(event_vx3 eq 0)
  ;  event_vx3[index3]=!values.f_nan
  ;  index4=where(event_vx4 eq 0)
  ;  event_vx4[index4]=!values.f_nan
  ;
  ;  top_flux=50.0
  ;  bottom_flux=-50.0
  ;
  ;  ncolors=200
  ;  bottom=0
  ;  title='Vx(km/s)'
  ;  cgloadct,33,bottom=0,ncolors=ncolors
  ;  scaled1=calculate_colors(event_vx1,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled2=calculate_colors(event_vx2,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled3=calculate_colors(event_vx3,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled4=calculate_colors(event_vx4,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled1[index1]=255
  ;  scaled2[index2]=255
  ;  scaled3[index3]=255
  ;  scaled4[index4]=255
  ;
  ;  tv,scaled1,x0,0.51,xsize=dx,ysize=2.8*dx,/normal
  ;  tv,scaled2,x0+dx+detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  ;  tv,scaled3,x0+2*dx+2*detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  ;  tv,scaled4,x0+3*dx+3*detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  ;
  ;  loadct,39
  ;
  ;  colorbar_new,position=[x0+4*dx+4*detax,0.51,x0+4*dx+5*detax,0.72],ticklen=-0.3,color=0,NCOLORS=256,$
  ;    range=[bottom_flux,top_flux],/vertical,/right,format='(f7.3)',title=title,charsize=1.0,/log
  ;
  ;  xl=findgen(10)
  ;  yl=findgen(30)
  ;  plot, xl, yl, /NOERASE,  xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yrange=[15,- 15],yticks=6,yminor=5,yticklen=0.05,$
  ;    ytickv=[15,10,5,0,-5,-10,-15],position=[x0,0.51,x0+dx,0.51+2.8*dx],xtickname = NAMES, /NODATA
  ;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
  ;    position=[x0+dx+detax,0.51,x0+2*dx+detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
  ;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
  ;    position=[x0+2*dx+2*detax,0.51,x0+3*dx+2*detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
  ;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yticklen=0.05,ytickformat='(a1)',$
  ;    position=[x0+3*dx+3*detax,0.51,x0+4*dx+3*detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
  ;
  ;  xyouts,0.125,0.97,'IMF Bz>0  dt>1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  ;  xyouts,0.3,0.97,'IMF Bz>0  dt<1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  ;  xyouts,0.475,0.97,'IMF Bz<0  dt>1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  ;  xyouts,0.65,0.97,'IMF Bz< 0  dt<1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  ;
  ;  device,/close_file
  ;  set_plot,entry_device

  ;  ;—————————————————————————————————————plot mass flux distribution——————————————————————————————————————
  ;
  ;  event_massfluxx1=event_n1*event_vx1
  ;  event_massfluxx2=event_n2*event_vx2
  ;  event_massfluxx3=event_n3*event_vx3
  ;  event_massfluxx4=event_n4*event_vx4
  ;
  ;  event_massfluxy1=event_n1*event_vy1
  ;  event_massfluxy2=event_n2*event_vy2
  ;  event_massfluxy3=event_n3*event_vy3
  ;  event_massfluxy4=event_n4*event_vy4
  ;
  ;
  ;  entry_device=!d.name
  ;  set_plot,'ps'
  ;  device,/color,Bits_per_pixel=8.0
  ;  TVLCT, r, g, b,/Get
  ;  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median\'
  ;  device,filename=output_dir+'massflux_2001_2009_median.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
  ;  !p.multi=[0,4,1,0,0]
  ;  loadct,39
  ;  device,decomposed=0
  ;
  ;  index1=where(event_massfluxy1 eq 0)
  ;  event_massfluxy1[index1]=!values.f_nan
  ;  index2=where(event_massfluxy2 eq 0)
  ;  event_massfluxy2[index2]=!values.f_nan
  ;  index3=where(event_massfluxy3 eq 0)
  ;  event_massfluxy3[index3]=!values.f_nan
  ;  index4=where(event_massfluxy4 eq 0)
  ;  event_massfluxy4[index4]=!values.f_nan
  ;
  ;  top_flux=20.0
  ;  bottom_flux=-10.0
  ;
  ;  ncolors=200
  ;  bottom=20
  ;  title='Mass flux Y direction(kg*km/s)'
  ;  cgloadct,33,bottom=0,ncolors=ncolors
  ;  scaled1=calculate_colors(event_massfluxy1,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled2=calculate_colors(event_massfluxy2,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled3=calculate_colors(event_massfluxy3,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled4=calculate_colors(event_massfluxy4,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled1[index1]=255
  ;  scaled2[index2]=255
  ;  scaled3[index3]=255
  ;  scaled4[index4]=255
  ;
  ;  tv,scaled1,x0,0.07,xsize=dx,ysize=2.8*dx,/normal
  ;  tv,scaled2,x0+dx+detax,0.07,xsize=dx,ysize=2.8*dx,/normal
  ;  tv,scaled3,x0+2*dx+2*detax,0.07,xsize=dx,ysize=2.8*dx,/normal
  ;  tv,scaled4,x0+3*dx+3*detax,0.07,xsize=dx,ysize=2.8*dx,/normal
  ;
  ;  loadct,39
  ;
  ;  colorbar_new,position=[x0+4*dx+4*detax,0.07,x0+4*dx+5*detax,0.28],ticklen=-0.3,color=0,NCOLORS=256,$
  ;    range=[bottom_flux,top_flux],/vertical,/right,format='(f7.3)',title=title,charsize=1.0,/log
  ;
  ;  xl=findgen(10)
  ;  yl=findgen(30)
  ;  plot, xl, yl, /NOERASE,  xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yrange=[15,- 15],yticks=6,yminor=5,yticklen=0.05,$
  ;    ytickv=[15,10,5,0,-5,-10,-15],position=[x0,0.07,x0+dx,0.07+2.8*dx],xtickname = NAMES, /NODATA
  ;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
  ;    position=[x0+dx+detax,0.07,x0+2*dx+detax,0.07+2.8*dx],xtickname = NAMES, /NODATA
  ;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
  ;    position=[x0+2*dx+2*detax,0.07,x0+3*dx+2*detax,0.07+2.8*dx],xtickname = NAMES, /NODATA
  ;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yticklen=0.05,ytickformat='(a1)',$
  ;    position=[x0+3*dx+3*detax,0.07,x0+4*dx+3*detax,0.07+2.8*dx],xtickname = NAMES, /NODATA
  ;
  ;
  ;
  ;
  ;  index1=where(event_massfluxx1 eq 0)
  ;  event_massfluxx1[index1]=!values.f_nan
  ;  index2=where(event_massfluxx2 eq 0)
  ;  event_massfluxx2[index2]=!values.f_nan
  ;  index3=where(event_massfluxx3 eq 0)
  ;  event_massfluxx3[index3]=!values.f_nan
  ;  index4=where(event_massfluxx4 eq 0)
  ;  event_massfluxx4[index4]=!values.f_nan
  ;
  ;  top_flux=20.0
  ;  bottom_flux=-10.0
  ;
  ;  ncolors=200
  ;  bottom=20
  ;  title='Mass flux X direction(kg*km/s)'
  ;  cgloadct,33,bottom=0,ncolors=ncolors
  ;  scaled1=calculate_colors(event_massfluxx1,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled2=calculate_colors(event_massfluxx2,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled3=calculate_colors(event_massfluxx3,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled4=calculate_colors(event_massfluxx4,bottom_flux,top_flux,Bottom,Ncolors)
  ;  scaled1[index1]=255
  ;  scaled2[index2]=255
  ;  scaled3[index3]=255
  ;  scaled4[index4]=255
  ;
  ;  tv,scaled1,x0,0.51,xsize=dx,ysize=2.8*dx,/normal
  ;  tv,scaled2,x0+dx+detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  ;  tv,scaled3,x0+2*dx+2*detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  ;  tv,scaled4,x0+3*dx+3*detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  ;
  ;  loadct,39
  ;
  ;  colorbar_new,position=[x0+4*dx+4*detax,0.51,x0+4*dx+5*detax,0.72],ticklen=-0.3,color=0,NCOLORS=256,$
  ;    range=[bottom_flux,top_flux],/vertical,/right,format='(f7.3)',title=title,charsize=1.0,/log
  ;
  ;  xl=findgen(10)
  ;  yl=findgen(30)
  ;  plot, xl, yl, /NOERASE,  xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yrange=[15,- 15],yticks=6,yminor=5,yticklen=0.05,$
  ;    ytickv=[15,10,5,0,-5,-10,-15],position=[x0,0.51,x0+dx,0.51+2.8*dx],xtickname = NAMES, /NODATA
  ;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
  ;    position=[x0+dx+detax,0.51,x0+2*dx+detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
  ;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
  ;    position=[x0+2*dx+2*detax,0.51,x0+3*dx+2*detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
  ;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yticklen=0.05,ytickformat='(a1)',$
  ;    position=[x0+3*dx+3*detax,0.51,x0+4*dx+3*detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
  ;
  ;  xyouts,0.125,0.97,'IMF Bz>0  dt>1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  ;  xyouts,0.3,0.97,'IMF Bz>0  dt<1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  ;  xyouts,0.475,0.97,'IMF Bz<0  dt>1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  ;  xyouts,0.65,0.97,'IMF Bz< 0  dt<1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  ;
  ;  device,/close_file
  ;  set_plot,entry_device

; ;—————————————————————————————————————plot kinetic energy flux distribution——————————————————————————————————————
;  
;    entry_device=!d.name
;    set_plot,'ps'
;    device,/color,Bits_per_pixel=8.0
;    TVLCT, r, g, b,/Get
;    output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median\'
;    device,filename=output_dir+'kinetic_energy_flux_2001_2009_median_gap0.833.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
;    !p.multi=[0,4,1,0,0]
;    loadct,39
;    device,decomposed=0
;  
;    index1=where(event_qky1 eq 0)
;    event_qky1[index1]=!values.f_nan
;    index2=where(event_qky2 eq 0)
;    event_qky2[index2]=!values.f_nan
;    index3=where(event_qky3 eq 0)
;    event_qky3[index3]=!values.f_nan
;    index4=where(event_qky4 eq 0)
;    event_qky4[index4]=!values.f_nan
;  
;    top_flux=0.01
;    bottom_flux=-0.01
;  
;    ncolors=250
;    bottom=0
;    title='kinetic energy flux Y components(10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
;    cgloadct,39,bottom=0,ncolors=ncolors
;    scaled1=calculate_colors(alog10(event_qky1),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;    scaled2=calculate_colors(alog10(event_qky2),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;    scaled3=calculate_colors(alog10(event_qky3),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;    scaled4=calculate_colors(alog10(event_qky4),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;    scaled1[index1]=255
;    scaled2[index2]=255
;    scaled3[index3]=255
;    scaled4[index4]=255
;  
;    tv,scaled1,x0,0.07,xsize=dx,ysize=2.8*dx,/normal
;    tv,scaled2,x0+dx+detax,0.07,xsize=dx,ysize=2.8*dx,/normal
;    tv,scaled3,x0+2*dx+2*detax,0.07,xsize=dx,ysize=2.8*dx,/normal
;    tv,scaled4,x0+3*dx+3*detax,0.07,xsize=dx,ysize=2.8*dx,/normal
;  
;    loadct,39
;  
;    colorbar_new,position=[x0+4*dx+4*detax,0.07,x0+4*dx+5*detax,0.28],ticklen=-0.3,color=0,NCOLORS=256,$
;      range=[bottom_flux,top_flux],/vertical,/right,format='(f7.3)',title=title,charsize=1.0,/log
;  
;    xl=findgen(10)
;    yl=findgen(30)
;    plot, xl, yl, /NOERASE,  xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yrange=[15,- 15],yticks=6,yminor=5,yticklen=0.05,$
;      ytickv=[15,10,5,0,-5,-10,-15],position=[x0,0.07,x0+dx,0.07+2.8*dx],xtickname = NAMES, /NODATA
;    plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
;      position=[x0+dx+detax,0.07,x0+2*dx+detax,0.07+2.8*dx],xtickname = NAMES, /NODATA
;    plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
;      position=[x0+2*dx+2*detax,0.07,x0+3*dx+2*detax,0.07+2.8*dx],xtickname = NAMES, /NODATA
;    plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yticklen=0.05,ytickformat='(a1)',$
;      position=[x0+3*dx+3*detax,0.07,x0+4*dx+3*detax,0.07+2.8*dx],xtickname = NAMES, /NODATA
;  
;  
;  
;    index1=where(event_qkx1 eq 0)
;    event_qkx1[index1]=!values.f_nan
;    index2=where(event_qkx2 eq 0)
;    event_qkx2[index2]=!values.f_nan
;    index3=where(event_qkx3 eq 0)
;    event_qkx3[index3]=!values.f_nan
;    index4=where(event_qkx4 eq 0)
;    event_qkx4[index4]=!values.f_nan
;  
;    top_flux=0.05
;    bottom_flux=-0.05
;  
;    ncolors=250
;    bottom=0
;    title='kinetic energy flux X components(10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
;    cgloadct,39,bottom=0,ncolors=ncolors
;    scaled1=calculate_colors(alog10(event_qkx1),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;    scaled2=calculate_colors(alog10(event_qkx2),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;    scaled3=calculate_colors(alog10(event_qkx3),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;    scaled4=calculate_colors(alog10(event_qkx4),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;    scaled1[index1]=255
;    scaled2[index2]=255
;    scaled3[index3]=255
;    scaled4[index4]=255
;  
;    tv,scaled1,x0,0.51,xsize=dx,ysize=2.8*dx,/normal
;    tv,scaled2,x0+dx+detax,0.51,xsize=dx,ysize=2.8*dx,/normal
;    tv,scaled3,x0+2*dx+2*detax,0.51,xsize=dx,ysize=2.8*dx,/normal
;    tv,scaled4,x0+3*dx+3*detax,0.51,xsize=dx,ysize=2.8*dx,/normal
;  
;   
;  
;    colorbar_new,position=[x0+4*dx+4*detax,0.51,x0+4*dx+5*detax,0.72],ticklen=-0.3,color=0,NCOLORS=256,$
;      range=[bottom_flux,top_flux],/vertical,/right,format='(f7.3)',title=title,charsize=1.0,/log
;    
;    loadct,39
;    xl=findgen(10)
;    yl=findgen(30)
;    plot, xl, yl, /NOERASE,  xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yrange=[15,- 15],yticks=6,yminor=5,yticklen=0.05,$
;      ytickv=[15,10,5,0,-5,-10,-15],position=[x0,0.51,x0+dx,0.51+2.8*dx],xtickname = NAMES, /NODATA
;    plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
;      position=[x0+dx+detax,0.51,x0+2*dx+detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
;    plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
;      position=[x0+2*dx+2*detax,0.51,x0+3*dx+2*detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
;    plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yticklen=0.05,ytickformat='(a1)',$
;      position=[x0+3*dx+3*detax,0.51,x0+4*dx+3*detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
;  
;    xyouts,0.125,0.97,'IMF Bz>0  dt>1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
;    xyouts,0.3,0.97,'IMF Bz>0  dt<1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
;    xyouts,0.475,0.97,'IMF Bz<0  dt>1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
;    xyouts,0.65,0.97,'IMF Bz< 0  dt<1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
;  
;    device,/close_file
;    set_plot,entry_device

  ;—————————————————————————————————————plot thermal energy flux distribution——————————————————————————————————————

  entry_device=!d.name
  set_plot,'ps'
  device,/color,Bits_per_pixel=8.0
  TVLCT, r, g, b,/Get
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median\'
  device,filename=output_dir+'thermal_energy_flux_2001_2009_median.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
  !p.multi=[0,4,1,0,0]
  loadct,39
  device,decomposed=0

  index1=where(event_qty1 eq 0)
  event_qty1[index1]=!values.f_nan
  index2=where(event_qty2 eq 0)
  event_qty2[index2]=!values.f_nan
  index3=where(event_qty3 eq 0)
  event_qty3[index3]=!values.f_nan
  index4=where(event_qty4 eq 0)
  event_qty4[index4]=!values.f_nan

  top_flux=1.5
  bottom_flux=-1.5

  ncolors=200
  bottom=0
  title='thermal energy flux Y components(10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
  cgloadct,39,bottom=0,ncolors=ncolors
  scaled1=calculate_colors(alog10(event_qty1),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
  scaled2=calculate_colors(alog10(event_qty2),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
  scaled3=calculate_colors(alog10(event_qty3),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
  scaled4=calculate_colors(alog10(event_qty4),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
  scaled1[index1]=255
  scaled2[index2]=255
  scaled3[index3]=255
  scaled4[index4]=255

  tv,scaled1,x0,0.07,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled2,x0+dx+detax,0.07,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled3,x0+2*dx+2*detax,0.07,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled4,x0+3*dx+3*detax,0.07,xsize=dx,ysize=2.8*dx,/normal

  loadct,39

  colorbar_new,position=[x0+4*dx+4*detax,0.07,x0+4*dx+5*detax,0.28],ticklen=-0.3,color=0,NCOLORS=256,$
    range=[bottom_flux,top_flux],/vertical,/right,format='(f7.3)',title=title,charsize=1.0,/log

  xl=findgen(10)
  yl=findgen(30)
  plot, xl, yl, /NOERASE,  xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yrange=[15,- 15],yticks=6,yminor=5,yticklen=0.05,$
    ytickv=[15,10,5,0,-5,-10,-15],position=[x0,0.07,x0+dx,0.07+2.8*dx],xtickname = NAMES, /NODATA
  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
    position=[x0+dx+detax,0.07,x0+2*dx+detax,0.07+2.8*dx],xtickname = NAMES, /NODATA
  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
    position=[x0+2*dx+2*detax,0.07,x0+3*dx+2*detax,0.07+2.8*dx],xtickname = NAMES, /NODATA
  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yticklen=0.05,ytickformat='(a1)',$
    position=[x0+3*dx+3*detax,0.07,x0+4*dx+3*detax,0.07+2.8*dx],xtickname = NAMES, /NODATA



  index1=where(event_qtx1 eq 0)
  event_qtx1[index1]=!values.f_nan
  index2=where(event_qtx2 eq 0)
  event_qtx2[index2]=!values.f_nan
  index3=where(event_qtx3 eq 0)
  event_qtx3[index3]=!values.f_nan
  index4=where(event_qtx4 eq 0)
  event_qtx4[index4]=!values.f_nan
  
  
  
  scaled1=bytescale(event_qtx1,range=[-0.3,0.3],top=256,bottom=0)
  
  top_flux=0.3
  bottom_flux=-0.3

  ncolors=256
  bottom=0
  title='thermal energy flux X components(10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
 ; cgloadct,72
  scaled1=calculate_colors(abs(event_qtx1),bottom_flux,top_flux,Bottom,Ncolors)
  scaled2=calculate_colors(alog10(abs(event_qtx2)),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
  scaled3=calculate_colors(alog10(abs(event_qtx3)),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
  scaled4=calculate_colors(alog10(abs(event_qtx4)),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
  ;scaled1[index1]=255
  scaled2[index2]=255
  scaled3[index3]=255
  scaled4[index4]=255

  tv,scaled1,x0,0.51,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled2,x0+dx+detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled3,x0+2*dx+2*detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled4,x0+3*dx+3*detax,0.51,xsize=dx,ysize=2.8*dx,/normal

  loadct,39

  colorbar_new,position=[x0+4*dx+4*detax,0.51,x0+4*dx+5*detax,0.72],ticklen=-0.3,color=0,NCOLORS=256,$
    range=[bottom_flux,top_flux],/vertical,/right,format='(f7.3)',title=title,charsize=1.0,/log

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
  xyouts,0.65,0.97,'IMF Bz< 0  dt<1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal

  device,/close_file
  set_plot,entry_device


  stop

end