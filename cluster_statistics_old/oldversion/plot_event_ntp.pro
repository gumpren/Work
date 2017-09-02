
pro plot_event_ntp
  start=systime(1)
  Re=6371.0

  root_dir='\2001_2009_median'
  restore,filepath('OMNI_2001_2009_Bz_Vxyz_p_AE_SYMH.sav',root_dir='C:\__Data\Datasave'+root_dir)
 ; restore,filepath('C3_FGM_2001_2009_Bxyz_Positionxyz.sav',root_dir='C:\__Data\Datasave'+root_dir)
 ; restore,filepath('time_need_omni_to_c3fgm_2001_2009.sav',root_dir='C:\__Data\Datasave'+root_dir)
 ; restore,filepath('C3_CIS_2001_2009_n_vbxyz_p_t_need.sav',root_dir='C:\__Data\Datasave'+root_dir)

  restore,filepath('event_p_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('event_n_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('event_t_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)

  xno=4 & x0=0.05 & x1=0.95 & detax=0.025
  dx=0.15
  yno=1



;  entry_device=!d.name
;  set_plot,'ps'
;  device,/color,Bits_per_pixel=8.0
;  TVLCT, r, g, b,/Get
;  output_dir='E:\OneDrive\IDLworks\ps\cluster_statistics'+root_dir
;  device,filename=output_dir+'\event_p_state_2001_2009_median_gap0.833.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
;  !p.multi=[0,4,1,0,0]
;  device,decomposed=0

      index1=where(event_p1 eq 0)
      event_p1[index1]=!values.f_nan
      index2=where(event_p2 eq 0)
      event_p2[index2]=!values.f_nan
      index3=where(event_p3 eq 0)
      event_p3[index3]=!values.f_nan
      index4=where(event_p4 eq 0)
      event_p4[index4]=!values.f_nan
  
      top_flux=0.25
;      bottom_flux=0.005
;      top_flux=max([max(event_p1[where(finite(event_p1))]),max(event_p2[where(finite(event_p2))])$
;          ,max(event_p3[where(finite(event_p3))]),max(event_p4[where(finite(event_p4))])])
      bottom_flux=min([min(event_p1[where(finite(event_p1))]),min(event_p2[where(finite(event_p2))])$
          ,min(event_p3[where(finite(event_p3))]),min(event_p4[where(finite(event_p4))])])
      print,'bottom_flux',bottom_flux
      print,'top_flux',top_flux
  
      ncolors=250
      bottom=0
      title='pressure(nPa)'
      cgloadct,39,bottom=0,ncolors=ncolors
      scaled1=calculate_colors(alog10(event_p1),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
      scaled2=calculate_colors(alog10(event_p2),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
      scaled3=calculate_colors(alog10(event_p3),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
      scaled4=calculate_colors(alog10(event_p4),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
      scaled1[index1]=255
      scaled2[index2]=255
      scaled3[index3]=255
      scaled4[index4]=255
;  ;cal rsd of n
;  index_1=where(event_n1 ne 0)
;  index_2=where(event_n2 ne 0)
;  index_3=where(event_n3 ne 0)
;  index_4=where(event_n4 ne 0)
;  origin_n1=event_n1[index_1]
;  origin_n2=event_n2[index_2]
;  origin_n3=event_n3[index_3]
;  origin_n4=event_n4[index_4]
;
;  rsd_n1=stddev(origin_n1)/average(origin_n1)
;  rsd_n2=stddev(origin_n2)/average(origin_n2)
;  rsd_n3=stddev(origin_n3)/average(origin_n3)
;  rsd_n4=stddev(origin_n4)/average(origin_n4)
;
;
  index1=where(event_n1 eq 0)
  event_n1[index1]=!values.f_nan
  index2=where(event_n2 eq 0)
  event_n2[index2]=!values.f_nan
  index3=where(event_n3 eq 0)
  event_n3[index3]=!values.f_nan
  index4=where(event_n4 eq 0)
  event_n4[index4]=!values.f_nan

  top_flux=0.5
  ;  bottom_flux=0.003
  ;  top_flux=max([max(event_n1[where(finite(event_n1))]),max(event_n2[where(finite(event_n2))])$
  ;    ,max(event_n3[where(finite(event_n3))]),max(event_n4[where(finite(event_n4))])])
  bottom_flux=min([min(event_n1[where(finite(event_n1))]),min(event_n2[where(finite(event_n2))])$
    ,min(event_n3[where(finite(event_n3))]),min(event_n4[where(finite(event_n4))])])
  print,'N_min',bottom_flux
  print,'N_max',top_flux

  ncolors=250
  bottom=0
  title='density(cm^-3)'
  title1='stddev of density'
  cgloadct,39,bottom=0,ncolors=ncolors
  scaled1=calculate_colors(alog10(event_n1),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
  scaled2=calculate_colors(alog10(event_n2),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
  scaled3=calculate_colors(alog10(event_n3),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
  scaled4=calculate_colors(alog10(event_n4),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
  scaled1[index1]=255
  scaled2[index2]=255
  scaled3[index3]=255
  scaled4[index4]=255



    index1=where(event_t1 eq 0)
    event_t1[index1]=!values.f_nan
    index2=where(event_t2 eq 0)
    event_t2[index2]=!values.f_nan
    index3=where(event_t3 eq 0)
    event_t3[index3]=!values.f_nan
    index4=where(event_t4 eq 0)
    event_t4[index4]=!values.f_nan
  
    top_flux=6.0
  ;  bottom_flux=0.5
;    top_flux=max([max(event_t1[where(finite(event_t1))]),max(event_t2[where(finite(event_t2))])$
;      ,max(event_t3[where(finite(event_t3))]),max(event_t4[where(finite(event_t4))])])
    bottom_flux=min([min(event_t1[where(finite(event_t1))]),min(event_t2[where(finite(event_t2))])$
      ,min(event_t3[where(finite(event_t3))]),min(event_t4[where(finite(event_t4))])])
    print,'T_max',top_flux
    print,'T_min',bottom_flux
  
    ncolors=250
    bottom=0
    title='temperature(keV)'
    cgloadct,39,bottom=0,ncolors=ncolors
    scaled1=calculate_colors(alog10(event_t1),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
    ;scaled4=calculate_colors(event_t4,bottom_flux,top_flux,Bottom,Ncolors)
    scaled2=calculate_colors(alog10(event_t2),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
    scaled3=calculate_colors(alog10(event_t3),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
    scaled4=calculate_colors(alog10(event_t4),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
    scaled1[index1]=255
    scaled2[index2]=255
    scaled3[index3]=255
    scaled4[index4]=255


;  plot std_dev of n
;  tv,stddev_1,x0,0.08,xsize=dx,ysize=0.5,/normal
;  tv,stddev_2,x0+dx+detax,0.08,xsize=dx,ysize=0.5,/normal
;  tv,stddev_3,x0+2*dx+2*detax,0.08,xsize=dx,ysize=0.5,/normal
;  tv,stddev_4,x0+3*dx+3*detax,0.08,xsize=dx,ysize=0.5,/normal


  tv,scaled1,x0,0.51,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled2,x0+dx+detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled3,x0+2*dx+2*detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled4,x0+3*dx+3*detax,0.51,xsize=dx,ysize=2.8*dx,/normal

  colorbar_new,position=[x0+4*dx+4*detax,0.51,x0+4*dx+5*detax,0.72],ticklen=-0.3,color=0,NCOLORS=ncolors,$
    range=[bottom_flux,top_flux],/vertical,/right,format='(f7.3)',title=title,charsize=1.0,/log

;  colorbar_new,position=[x0+4*dx+4*detax,0.08,x0+4*dx+5*detax,0.29],ticklen=-0.3,color=0,NCOLORS=ncolors,$
;    range=[bottom_flux,top_flux],/vertical,/right,format='(f7.3)',title=title1,charsize=1.0,/log



  xl=findgen(10)
  yl=findgen(30)
  plot, xl, yl, /NOERASE,  xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yrange=[15,- 15],yticks=6,yminor=5,yticklen=0.05,$
    ytickv=[15,10,5,0,-5,-10,-15],position=[x0,0.51,x0+dx,0.51+2.8*dx],xtickname = NAMES,xthick=3, ythick=3, /NODATA
  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
    position=[x0+dx+detax,0.51,x0+2*dx+detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
    position=[x0+2*dx+2*detax,0.51,x0+3*dx+2*detax,0.51+2.8*dx],xtickname = NAMES, /NODATA
  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yticklen=0.05,ytickformat='(a1)',$
    position=[x0+3*dx+3*detax,0.51,x0+4*dx+3*detax,0.51+2.8*dx],xtickname = NAMES,  /NODATA

;  plot, xl, yl, /NOERASE,  xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yrange=[15,- 15],yticks=6,yminor=5,yticklen=0.05,$
;    ytickv=[15,10,5,0,-5,-10,-15],position=[x0,0.08,x0+dx,0.5],xtickname = NAMES, /NODATA
;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
;    position=[x0+dx+detax,0.08,x0+2*dx+detax,0.5],xtickname = NAMES, /NODATA
;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yminor=5,yticklen=0.05,ytickformat='(a1)',$
;    position=[x0+2*dx+2*detax,0.08,x0+3*dx+2*detax,0.5],xtickname = NAMES, /NODATA
;  plot, xl, yl, /NOERASE, xticks =5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],yticks=6,yticklen=0.05,ytickformat='(a1)',$
;    position=[x0+3*dx+3*detax,0.08,x0+4*dx+3*detax,0.5],xtickname = NAMES, /NODATA


  xyouts,0.125,0.97,'IMF Bz>0  dt>1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  xyouts,0.3,0.97,'IMF Bz>0  dt<1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  xyouts,0.475,0.97,'IMF Bz<0  dt>1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  xyouts,0.65,0.97,'IMF Bz< 0  dt<1 hr',color=0,alignment=0.5,charsize=0.6,font=0,/normal

  device,/close_file
  set_plot,entry_device
 
  stop
end

;cgPS_Open, FILENAME='E:\OneDrive\IDLworks\ps\cluster_statistics\'+'event_t4'
;; cgPS_Config(xsize=6,ysize=4.0,font=0,units='inches')
;cgimage,scaled4
;cgPS_Close



;  maxn=[max(event_n1),max(event_n2),max(event_n3),max(event_n4)]
;  print,maxn
;
;  index1=where(event_n1 eq 0)
;  event_n1[index1]=!values.f_nan
;  index2=where(event_n2 eq 0)
;  event_n2[index2]=!values.f_nan
;  index3=where(event_n3 eq 0)
;  event_n3[index3]=!values.f_nan
;  index4=where(event_n4 eq 0)
;  event_n4[index4]=!values.f_nan
;
;  ncolors=250
;  cgloadct,33,bottom=0,ncolors=ncolors
;
;;  index_gt1=where(event_n1 gt 1.0)
;;  event_n1[index1]=!values.f_nan
;
;  scaled1=bytscl(event_n1,min=0,max=max(event_n1,/nan),top=ncolors-2,/nan) ;max=max(event_n1,/nan)
;  scaled2=bytscl(event_n2,min=0,max=max(event_n2,/nan),top=ncolors-2,/nan)
;  scaled3=bytscl(event_n3,min=0,max=max(event_n3,/nan),top=ncolors-2,/nan)
;  scaled4=bytscl(event_n4,min=0,max=max(event_n4,/nan),top=ncolors-2,/nan)
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
;  ;device,decomposed=0
;
;  colorbar_new,position=[x0+4*dx+4*detax,0.51,x0+4*dx+5*detax,0.72],ticklen=-0.3,color=0,NCOLORS=256,$
;    range=[0,max(maxn)],/vertical,/right,format='(f7.2)',title='density',charsize=1.0
