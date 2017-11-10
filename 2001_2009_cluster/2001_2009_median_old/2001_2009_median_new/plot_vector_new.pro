pro plot_vector_new
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  root_dir='C:\__Data\Datasave\2001_2009_median_new\'
  
  restore,filepath('event_vxy'+save_str+'.sav',root_dir=root_dir)
  restore,filepath('K_Re_xy'+save_str+'.sav',root_dir=root_dir)
  restore,filepath('H_Re_xy'+save_str+'.sav',root_dir=root_dir)

  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median_new\'
  cgps_open,output_dir+'velocity_vector'+save_str+'.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(3,4,left=0.01,right=0.9,xgap=0.02,ygap=0.02,low=0.01,high=0.95)

;  cgHistoplot
;  HISTOGRAM(
  bar_title0='Velocity (cm!u-3!n!x)'
  bar_title1='K (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
  bar_title2='H (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
  bar_title=[bar_title0,bar_title1,bar_title2]

  vx1=reform(event_vx1,10*30*reverse_gap^2) & vx2=reform(event_vx2,10*30*reverse_gap^2) & vx3=reform(event_vx3,10*30*reverse_gap^2) & vx4=reform(event_vx4,10*30*reverse_gap^2)
  vy1=reform(event_vy1,10*30*reverse_gap^2) & vy2=reform(event_vy2,10*30*reverse_gap^2) & vy3=reform(event_vy3,10*30*reverse_gap^2) & vy4=reform(event_vy4,10*30*reverse_gap^2)
  qkx1=reform(K_Re_x1,10*30*reverse_gap^2)  & qkx2=reform(K_Re_x2,10*30*reverse_gap^2)  & qkx3=reform(K_Re_x3,10*30*reverse_gap^2)  & qkx4=reform(K_Re_x4,10*30*reverse_gap^2)
  qky1=reform(K_Re_y1,10*30*reverse_gap^2)  & qky2=reform(K_Re_y2,10*30*reverse_gap^2)  & qky3=reform(K_Re_y3,10*30*reverse_gap^2)  & qky4=reform(K_Re_y4,10*30*reverse_gap^2)
  qhx1=reform(H_Re_x1,10*30*reverse_gap^2)  & qhx2=reform(H_Re_x2,10*30*reverse_gap^2)  & qhx3=reform(H_Re_x3,10*30*reverse_gap^2)  & qhx4=reform(H_Re_x4,10*30*reverse_gap^2)
  qhy1=reform(H_Re_y1,10*30*reverse_gap^2)  & qhy2=reform(H_Re_y2,10*30*reverse_gap^2)  & qhy3=reform(H_Re_y3,10*30*reverse_gap^2) & qhy4=reform(H_Re_y4,10*30*reverse_gap^2)

  event_x=[[[vx1],[vx2],[vx3],[vx4]],$
    [[qhx1],[qhx2],[qhx3],[qhx4]],$
    [[qkx1],[qkx2],[qkx3],[qkx4]]]
  event_y=[[[vy1],[vy2],[vy3],[vy4]],$
    [[qhy1],[qhy2],[qhy3],[qhy4]],$
    [[qky1],[qky2],[qky3],[qky4]]]

  x=linspace(-20,-10,10*reverse_gap+1)
  y=linspace(-15,15,30*reverse_gap+1)
;  xrange=minmax(x)
;  yrange=minmax(y)
  xrange=[-20,-10]
  yrange=[15,-15]

  title0=['B!dz_IMF!n!x>0 d!dt!n!x>1hr','B!dz_IMF!n!x>0 d!dt!n!x<1hr','B!dz_IMF!n!x<0 d!dt!n!x>1hr','B!dz_IMF!n!x<0 d!dt!n!x<1hr']

  str_element,opt_plot,'charsize',0.9,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'XMINOR',2,/add
  str_element,opt_plot,'xrange',xrange,/add
  str_element,opt_plot,'yrange',yrange,/add

  str_element,opt_bar,'charsize',0.9,/add

  missing=[80,0.3,0.001]
  ; overplot=dblarr(3,4)
  ; REPLICATE_INPLACE,overplot,1
  for i=0,2 do begin
    str_element,opt_bar,'title',bar_title[i],/add
    for j=0,3 do begin
      if j ne 0 then begin
        str_element,opt_plot,'ytickformat','(a1)',/add
        str_element,opt_plot,'ytitle',/delete
      endif else begin
        str_element,opt_plot,'ytickformat',/delete
        str_element,opt_plot,'ytitle','Y(Re)',/add
      endelse

      if i ne 2 then begin
        str_element,opt_plot,'xtickformat','(a1)',/add
        str_element,opt_plot,'xtitle',/delete
      endif else begin
        str_element,opt_plot,'xtickformat',/delete
        str_element,opt_plot,'xtitle','X(Re)',/add
      endelse

      cgplot,reform(event_x[*,j,i],10*reverse_gap,30*reverse_gap),reform(event_y[*,j,i],10*reverse_gap,30*reverse_gap),xlog=xlog,ylog=ylog,position=pos[i,j,*],$
        /normal,/nodata,/noerase,_extra=opt_plot

    endfor
  endfor

  for i=0,2 do begin
    for j=0,3 do begin
      ;str_element,opt_bar,'title',bar_title[i],/add
      ;cgDrawVectors,reform(event_x[*,j,i],12,36),reform(event_y[*,j,i],12,36),X[0:n_elements(x)-2],Y[0:n_elements(y)-2]
      ;cgArrow,
      VELOVECT,reform(event_x[*,j,i],10*reverse_gap,30*reverse_gap),reform(event_y[*,j,i],10*reverse_gap,30*reverse_gap),X[0:n_elements(X)-2],(reverse(Y))[0:n_elements(Y)-2] $
        ,COLOR=0,MISSING=missing[i],LENGTH=1.5,$;,LENGTH=value,/OVERPLOT,/nodata,/DOTS,
       position=pos[i,j,*], /noerase,xstyle=4,ystyle=4,xrange=xrange,yrange=[15,-15];,_extra=opt_plot ;,/nodata,background=240
      ;        ,xticks=5,xtickv=[-20,-18,-16,-14,-12,-10],xminor=2,xrange=[-20,-10],$
      ;        yticks=6,ytickv=[15,10,5,0,-5,-10,-15],yminor=5,yticklen=0.05,yrange=[15,-15],$;
      ;        xtitle='X!DGSM!N(R!DE!N)',$;
      ;        ytitle='Y!DGSM!N(R!DE!N)',charsize=0.8
      print,i
    endfor
  endfor
  labels_stamp,pos[0,*,*],title0[*,0],charsize=0.8,/left_right_center,/up_out

;  labels_stamp,pos[*,3,*],bar_title0[*,0],charsize=0.8,/up_down_center,/right_out
  xyouts,0.99,0.8,'V (80km/s)',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  xyouts,0.99,0.5,'H (0.3 (10!u16!n!xergs!u-1!n!xRe!u2!n!x))',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  xyouts,0.99,0.2,'K (0.001(10!u16!n!xergs!u-1!n!xRe!u2!n!x))',color=0,alignment=0.5,charsize=0.6,font=0,/normal
  cgps_close
  stop

end