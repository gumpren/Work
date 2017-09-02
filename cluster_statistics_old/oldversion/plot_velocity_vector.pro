 pro plot_velocity_vector   ;,filename,satellitename,element,x0,x1,y0,y1,tickname,BOTTOM=bottom


  ;锟斤拷 锟斤拷锟斤拷位锟斤拷+锟杰讹拷 锟侥硷拷,锟斤拷锟斤拷锟斤拷锟�

 ; restore,filepath('C3_CIS_2001_2003_n_vbxyz_p_T_need_addbeta.sav',root_dir='C:\__Data\Datasave')
  restore,filepath('event_vxy_2001_2009_gap1.00000Re.sav',root_dir='C:\__Data\Datasave\2001_2009_median_new')
  
  x_div=10 
  y_div=30
  
  vector_v=fltarr(x_div,y_div)
  vector_v(*,*)=sqrt((event_vx1(*,*))^2+(event_vy1(*,*))^2)
 
;  max_H=max(vector_H)
;  max_O=max(vector_O)
;  length_H=5.0
;  length_O=length_H*(max_O/max_H)
;  print,max_H

  ;xy锟斤拷锟斤拷锟�
  
  x=findgen(x_div)
  y=findgen(y_div)
  x(*)=x(*)-20.0
  y(*)=y(*)-15.0

;  ;去锟斤拷0锟斤拷
;  for i=0,x_div-1 do begin
;    for j=0,y_div-1 do begin
;      if H_Vx[i,j] eq 0 then begin
;        H_Vx[i,j]=1001
;      endif
;      if H_Vy[i,j] eq 0 then begin
;        H_Vy[i,j]=1001
;      endif
;      if O_Vx[i,j] eq 0 then begin
;        O_Vx[i,j]=1001
;      endif
;      if O_Vy[i,j] eq 0 then begin
;        O_Vy[i,j]=1001
;      endif
;    endfor
;  endfor
;  ;锟斤拷锟杰讹拷     锟斤拷维锟街诧拷图

  xno=4 & x0=0.05 & x1=0.95 & detax=0.025
  ;dx=(x1-x0-detax*(xno-1))/xno
  dx=0.15
  no=1

  entry_device=!d.name
  set_plot,'ps'
  device,/color,Bits_per_pixel=8.0
  TVLCT, r, g, b,/Get
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median_new\'
  device,filename=output_dir+'velocity_vector_2001_2009_median_test.ps',xsize=5.5,ysize=6.5,xoffset=1,yoffset=2,/inches,/encapsulated
  !p.multi=[0,4,1,0,0]
  loadct,39
  device,decomposed=0



  VELOVECT,event_vx1,event_vy1,X,Y,COLOR=0,MISSING=1000,LENGTH=3.0,$;,LENGTH=value,/OVERPLOT,/nodata,/DOTS,
    position=[x0,0.51,x0+dx,0.51+2.8*dx],background=255,/noerase,$;,/nodata
    xticks=5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],$
    yticks=6,ytickv=[15,10,5,0,-5,-10,-15],yminor=5,yticklen=0.05,yrange=[15,-15],$;
    xtitle='X!DGSM!N(R!DE!N)',$;
    ytitle='Y!DGSM!N(R!DE!N)',charsize=0.8
  VELOVECT,event_vx2,event_vy2,X,Y,COLOR=0,MISSING=1000,LENGTH=3.0,$;,LENGTH=value,/OVERPLOT,/nodata,/DOTS,
    position=[x0+dx+detax,0.51,x0+2*dx+detax,0.51+2.8*dx],background=255,/noerase,$;,/nodata
    xticks=5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],$
    yticks=6,ytickv=[15,10,5,0,-5,-10,-15],yminor=5,yticklen=0.05,yrange=[15,-15],$;
    xtitle='X!DGSM!N(R!DE!N)',charsize=0.8
    
  VELOVECT,event_vx3,event_vy3,X,Y,COLOR=0,MISSING=1000,LENGTH=3.0,$;,LENGTH=value,/OVERPLOT,/nodata,/DOTS,
    position=[x0+2*dx+2*detax,0.51,x0+3*dx+2*detax,0.51+2.8*dx],background=255,/noerase,$;,/nodata
    xticks=5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],$
    yticks=6,ytickv=[15,10,5,0,-5,-10,-15],yminor=5,yticklen=0.05,yrange=[15,-15],$;
    xtitle='X!DGSM!N(R!DE!N)',charsize=0.8
    
  VELOVECT,event_vx4,event_vy4,X,Y,COLOR=0,MISSING=1000,LENGTH=3.0,$;,LENGTH=value,/OVERPLOT,/nodata,/DOTS,
    position=[x0+3*dx+3*detax,0.51,x0+4*dx+3*detax,0.51+2.8*dx],background=255,/noerase,$;,/nodata
    xticks=5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],$
    yticks=6,ytickv=[15,10,5,0,-5,-10,-15],yminor=5,yticklen=0.05,yrange=[15,-15],$;
    xtitle='X!DGSM!N(R!DE!N)',charsize=0.8
  
  
  xyouts,0.125,0.97,'IMF Bz>0  dt>1 hr',color=0,alignment=0.5,charsize=0.5,font=0,/normal
  xyouts,0.3,0.97,'IMF Bz>0  dt<1 hr',color=0,alignment=0.5,charsize=0.5,font=0,/normal
  xyouts,0.475,0.97,'IMF Bz<0  dt>1 hr',color=0,alignment=0.5,charsize=0.5,font=0,/normal
  xyouts,0.65,0.97,'IMF Bz< 0  dt<1 hr',color=0,alignment=0.5,charsize=0.5,font=0,/normal

  ;xyouts,x0+0.02,y1-0.03,'(!3f!X) C1',color=0,/normal,charsize=0.8,font=0


  device,/close_file                        ; 锟截憋拷PostScript锟侥硷拷plotting_filename.ps
  Set_plot,entry_device                     ; 锟街革拷原锟借备entry_device




end