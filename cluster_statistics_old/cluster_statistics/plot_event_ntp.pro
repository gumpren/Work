pro ex_box, X0, Y0, X1, Y1, color
  polyfill, [X0, X0, X1, X1], [Y0, Y1, Y1, Y0], COL = color
end

pro plot_event_ntp
  start=systime(1)
  Re=6371.0
  
  atxt='_0.5_Z_0.5.sav'
  btxt='.sav'
  root_dir='\2001_2009_median'
  restore,filepath('OMNI_2001_2009_Bz_Vxyz_p_AE_SYMH.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('C3_FGM_2001_2009_Bxyz_Positionxyz.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('C3_CIS_2001_2009_n_vbxyz_p_T_need'+btxt,root_dir='C:\__Data\Datasave'+root_dir)
;  restore,filepath('event_p_2001_2009_median'+btxt,root_dir='C:\__Data\Datasave'+root_dir)
 ; restore,filepath('event_n_2001_2009_median'+btxt,root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('event_t_2001_2009_median_gap0.833.sav',root_dir='C:\__Data\Datasave'+root_dir)
  
  t_omni=(time_omni-time_omni[0])/60000.0d
  t_c3fgm=(time_c3fgm-time_omni[0])/60000.0d
 
  xno=4 & x0=0.05 & x1=0.95 & detax=0.025
  ;dx=(x1-x0-detax*(xno-1))/xno
  dx=0.15
  yno=1


  entry_device=!d.name
  set_plot,'ps'
  device,/color,Bits_per_pixel=8.0
  TVLCT, r, g, b,/Get
  output_dir='E:\OneDrive\IDLworks\cluster_statistics\ps'+root_dir
  device,filename=output_dir+'\event_t_state_2001_2009_median_gap0.833.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
  !p.multi=[0,4,1,0,0]
  loadct,39
  device,decomposed=0

;    index1=where(event_p1 eq 0)
;    event_p1[index1]=!values.f_nan
;    index2=where(event_p2 eq 0)
;    event_p2[index2]=!values.f_nan
;    index3=where(event_p3 eq 0)
;    event_p3[index3]=!values.f_nan
;    index4=where(event_p4 eq 0)
;    event_p4[index4]=!values.f_nan
;  
;    top_flux=0.50
;    bottom_flux=0.005
;;    top_flux=max([max(event_p1[where(finite(event_p1))]),max(event_p2[where(finite(event_p2))])$
;;        ,max(event_p3[where(finite(event_p3))]),max(event_p4[where(finite(event_p4))])])
;;    bottom_flux=min([min(event_p1[where(finite(event_p1))]),min(event_p2[where(finite(event_p2))])$
;;        ,min(event_p3[where(finite(event_p3))]),min(event_p4[where(finite(event_p4))])])
;    print,bottom_flux
;    print,top_flux
;   
;    ncolors=200
;    bottom=0
;    title='pressure(nPa)'
;    cgloadct,33,bottom=0,ncolors=ncolors
;    scaled1=calculate_colors(alog10(event_p1),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;    scaled2=calculate_colors(alog10(event_p2),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;    scaled3=calculate_colors(alog10(event_p3),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;    scaled4=calculate_colors(alog10(event_p4),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;    scaled1[index1]=255
;    scaled2[index2]=255
;    scaled3[index3]=255
;    scaled4[index4]=255
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
;
;
;  top_flux=1.5
;  bottom_flux=0.003
;;  top_flux=max([max(event_n1[where(finite(event_n1))]),max(event_n2[where(finite(event_n2))])$
;;    ,max(event_n3[where(finite(event_n3))]),max(event_n4[where(finite(event_n4))])])
;;  bottom_flux=min([min(event_n1[where(finite(event_n1))]),min(event_n2[where(finite(event_n2))])$
;;    ,min(event_n3[where(finite(event_n3))]),min(event_n4[where(finite(event_n4))])])
;  print,bottom_flux
;  print,top_flux
;  ncolors=200
;  bottom=0 
;  title='density(cm^-3)'
;  cgloadct,33,bottom=0,ncolors=ncolors
;  scaled1=calculate_colors(alog10(event_n1),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;  scaled2=calculate_colors(alog10(event_n2),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;  scaled3=calculate_colors(alog10(event_n3),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;  scaled4=calculate_colors(alog10(event_n4),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
;  scaled1[index1]=255
;  scaled2[index2]=255
;  scaled3[index3]=255
;  scaled4[index4]=255


  index1=where(event_t1 eq 0)
  event_t1[index1]=!values.f_nan
  index2=where(event_t2 eq 0)
  event_t2[index2]=!values.f_nan
  index3=where(event_t3 eq 0)
  event_t3[index3]=!values.f_nan
  index4=where(event_t4 eq 0)
  event_t4[index4]=!values.f_nan

  top_flux=5.5
  bottom_flux=1.0
  
;  top_flux=max([max(event_t1[where(finite(event_t1))]),max(event_t2[where(finite(event_t2))])$
;    ,max(event_t3[where(finite(event_t3))]),max(event_t4[where(finite(event_t4))])])
;  bottom_flux=min([min(event_t1[where(finite(event_t1))]),min(event_t2[where(finite(event_t2))])$
;    ,min(event_t3[where(finite(event_t3))]),min(event_t4[where(finite(event_t4))])])
  
  
  
  ncolors=250
  bottom=0
  title='temperature(keV)'
  cgloadct,34,bottom=0,ncolors=ncolors
  scaled1=calculate_colors(alog10(event_t1),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
 ; scaled4=calculate_colors(event_t4,bottom_flux,top_flux,Bottom,Ncolors)
  scaled2=calculate_colors(alog10(event_t2),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
  scaled3=calculate_colors(alog10(event_t3),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
  scaled4=calculate_colors(alog10(event_t4),alog10(bottom_flux),alog10(top_flux),Bottom,Ncolors)
  scaled1[index1]=255
  scaled2[index2]=255
  scaled3[index3]=255
  scaled4[index4]=255
  

  
;  cgPS_Open, FILENAME='E:\OneDrive\IDLworks\cluster_statistics\ps\'+'event_t'
; ; cgPS_Config(xsize=6,ysize=4.0,font=0,units='inches')
;  cgimage,scaled4
;  cgPS_Close
  
  
  tv,scaled1,x0,0.51,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled2,x0+dx+detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled3,x0+2*dx+2*detax,0.51,xsize=dx,ysize=2.8*dx,/normal
  tv,scaled4,x0+3*dx+3*detax,0.51,xsize=dx,ysize=2.8*dx,/normal

  
  
  colorbar_new,position=[x0+4*dx+4*detax,0.51,x0+4*dx+5*detax,0.72],ticklen=-0.3,color=0,NCOLORS=ncolors,$
    range=[bottom_flux,top_flux],/vertical,/right,format='(f7.3)',title=title,charsize=1.0,/log
  
  loadct,39
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

  ;  xyouts,0.17,0.15,'|V!Dx!n|',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  ;  xyouts,0.17,0.3,'P!Ddyn!n',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  ;  xyouts,0.17,0.45,'|B!Dz!n|',color=0,alignment=0.5,charsize=0.6,font=0,/normal


  device,/close_file
  set_plot,entry_device
  
  stop
end



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
