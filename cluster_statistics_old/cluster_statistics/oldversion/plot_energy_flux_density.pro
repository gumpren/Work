pro plot_energy_flux_density
  ;�� ����λ��+�ܶ� �ļ�,�������

  ;restore,filepath('C3_CIS_2001_2003_n_vbxyz_p_T_need .sav',root_dir='C:\__Data\Datasave')
  restore,filepath('event_qk_2001_2009_median.sav',root_dir='C:\__Data\Datasave')
  restore,filepath('event_qt_2001_2009_median.sav',root_dir='C:\__Data\Datasave')

  x_div=10
  y_div=30

  vector_qk=fltarr(x_div,y_div)
 ; vector_v(*,*)=sqrt((event_vx1(*,*))^2+(event_vy1(*,*))^2)

  ;  max_H=max(vector_H)
  ;  max_O=max(vector_O)
  ;  length_H=5.0
  ;  length_O=length_H*(max_O/max_H)
  ;  print,max_H

  ;xy�����

  x=findgen(x_div)
  y=findgen(y_div)
  x(*)=x(*)-20.0
  y(*)=y(*)-15.0

  xno=4 & x0=0.05 & x1=0.95 & detax=0.025
  ;dx=(x1-x0-detax*(xno-1))/xno
  dx=0.15
  no=1
  

  entry_device=!d.name
  set_plot,'ps'
  device,/color,Bits_per_pixel=8.0
  TVLCT, r, g, b,/Get
  output_dir='E:\OneDrive\IDLworks\cluster_statistics\ps\'
  device,filename=output_dir+'energy_flux_density_thermal_2001_2009_median.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
  !p.multi=[0,4,1,0,0]
  loadct,39
  device,decomposed=0



  VELOVECT,event_qtx1,event_qty1,X,Y,COLOR=0,MISSING=1000,LENGTH=1.5,$;,LENGTH=value,/OVERPLOT,/nodata,/DOTS,
    position=[x0,0.51,x0+dx,0.51+2.8*dx],background=255,/noerase,$;,/nodata
    xticks=5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],$
    yticks=6,ytickv=[15,10,5,0,-5,-10,-15],yminor=5,yticklen=0.05,yrange=[15,-15],$;
    xtitle='X!DGSM!N(R!DE!N)',$;
    ytitle='Y!DGSM!N(R!DE!N)',charsize=0.8
  VELOVECT,event_qtx2,event_qty2,X,Y,COLOR=0,MISSING=1000,LENGTH=1.500,$;,LENGTH=value,/OVERPLOT,/nodata,/DOTS,
    position=[x0+dx+detax,0.51,x0+2*dx+detax,0.51+2.8*dx],background=255,/noerase,$;,/nodata
    xticks=5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],$
    yticks=6,ytickv=[15,10,5,0,-5,-10,-15],yminor=5,yticklen=0.05,yrange=[15,-15],$;
    xtitle='X!DGSM!N(R!DE!N)',charsize=0.8

  VELOVECT,event_qtx3,event_qty3,X,Y,COLOR=0,MISSING=1000,LENGTH=1.50,$;,LENGTH=value,/OVERPLOT,/nodata,/DOTS,
    position=[x0+2*dx+2*detax,0.51,x0+3*dx+2*detax,0.51+2.8*dx],background=255,/noerase,$;,/nodata
    xticks=5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],$
    yticks=6,ytickv=[15,10,5,0,-5,-10,-15],yminor=5,yticklen=0.05,yrange=[15,-15],$;
    xtitle='X!DGSM!N(R!DE!N)',charsize=0.8

  VELOVECT,event_qtx4,event_qty4,X,Y,COLOR=0,MISSING=1000,LENGTH=1.500,$;,LENGTH=value,/OVERPLOT,/nodata,/DOTS,
    position=[x0+3*dx+3*detax,0.51,x0+4*dx+3*detax,0.51+2.8*dx],background=255,/noerase,$;,/nodata
    xticks=5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],$
    yticks=6,ytickv=[15,10,5,0,-5,-10,-15],yminor=5,yticklen=0.05,yrange=[15,-15],$;
    xtitle='X!DGSM!N(R!DE!N)',charsize=0.8


  xyouts,0.125,0.97,'IMF Bz>0  dt>1 hr',color=0,alignment=0.5,charsize=0.5,font=0,/normal
  xyouts,0.3,0.97,'IMF Bz>0  dt<1 hr',color=0,alignment=0.5,charsize=0.5,font=0,/normal
  xyouts,0.475,0.97,'IMF Bz<0  dt>1 hr',color=0,alignment=0.5,charsize=0.5,font=0,/normal
  xyouts,0.65,0.97,'IMF Bz< 0  dt>1 hr',color=0,alignment=0.5,charsize=0.5,font=0,/normal

  ;xyouts,x0+0.02,y1-0.03,'(!3f!X) C1',color=0,/normal,charsize=0.8,font=0


  device,/close_file                        ; �ر�PostScript�ļ�plotting_filename.ps
  Set_plot,entry_device                     ; �ָ�ԭ�豸entry_device




end