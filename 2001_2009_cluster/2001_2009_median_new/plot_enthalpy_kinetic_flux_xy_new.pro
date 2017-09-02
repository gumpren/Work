pro plot_enthalpy_kinetic_flux_xy_new
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  root_dir='C:\__Data\Datasave\2001_2009_median_new\'
  
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median_new\'

  restore,filepath('H_Re_xy'+save_str+'.sav',root_dir=root_dir)
  bar_title0='H!dX!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
  bar_title1='H!dY!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
  bar_title=[bar_title0,bar_title1]
  cgps_open,output_dir+'enthalpy_energy_flux'+save_str+'.ps',xsize=6.0,ysize=7.0
  H_Re_x1=reform(H_Re_x1,300*reverse_gap^2)
  H_Re_x2=reform(H_Re_x2,300*reverse_gap^2)
  H_Re_x3=reform(H_Re_x3,300*reverse_gap^2)
  H_Re_x4=reform(H_Re_x4,300*reverse_gap^2)
  H_Re_y1=reform(H_Re_y1,300*reverse_gap^2)
  H_Re_y2=reform(H_Re_y2,300*reverse_gap^2)
  H_Re_y3=reform(H_Re_y3,300*reverse_gap^2)
  H_Re_y4=reform(H_Re_y4,300*reverse_gap^2)
  
  data=[[[H_Re_x1],[H_Re_x2],[H_Re_x3],[H_Re_x4]],$
     [[H_Re_y1],[H_Re_y2],[H_Re_y3],[H_Re_y4]]]
  zrange=[-0.3,0.3]


;  restore,filepath('K_Re_xy'+save_str+'.sav',root_dir=root_dir)
;  bar_title0='K!dX!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
;  bar_title1='K!dY!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
;  bar_title=[bar_title0,bar_title1]
;  cgps_open,output_dir+'kinetic_energy_flux'+save_str+'.ps',xsize=6.0,ysize=7.0
;  K_Re_x1=reform(K_Re_x1,300*reverse_gap^2)
;  K_Re_x2=reform(K_Re_x2,300*reverse_gap^2)
;  K_Re_x3=reform(K_Re_x3,300*reverse_gap^2)
;  K_Re_x4=reform(K_Re_x4,300*reverse_gap^2)
;  K_Re_y1=reform(K_Re_y1,300*reverse_gap^2)
;  K_Re_y2=reform(K_Re_y2,300*reverse_gap^2)
;  K_Re_y3=reform(K_Re_y3,300*reverse_gap^2)
;  K_Re_y4=reform(K_Re_y4,300*reverse_gap^2)
;  data=[[[K_Re_x1],[K_Re_x2],[K_Re_x3],[K_Re_x4]],$
;    [[K_Re_y1],[K_Re_y2],[K_Re_y3],[K_Re_y4]]]
;  zrange=[-0.001,0.001]


  x=linspace(-20,-10,10*reverse_gap+1)
  v=linspace(-15,15,30*reverse_gap+1)  ; connect to the return_vari function. follow the same start point
  xrange=[-20,-10]
  yrange=[15,-15]
  title0=[['B!dz_IMF!n!x>0  d!dt!n!x>1hr','B!dz_IMF!n!x>0  d!dt!n!x<1hr','B!dz_IMF!n!x<0  d!dt!n!x>1hr','B!dz_IMF!n!x< 0  d!dt!n!x<1hr'],$
    ['','','','']]
  ;v      change : title,not change; image, change
  ;yrange change : title, change   ; image, change

  idx=where(data eq 0)
  data[idx]=!values.f_nan
  pos=set_plot_position(2,4,left=0.01,right=0.9,xgap=0.04,ygap=0.03,low=0.01,high=0.95)
  ;cgloadct,38;,/reverse
  ;cgloadct,72,/reverse
  restore,'E:\OneDrive\IDLworks\Other\blue_white_red_256.ctl'
  

;  openr,lun,filepath('rgb255.txt',root_dir='E:\OneDrive\Matlabworks'),/get_lun
;  rgb=dBlarr(3,256)
;  readf,lun,rgb
;  free_lun,lun
;  r=reverse(reform(rgb[0,*]))
;  g=reverse(reform(rgb[1,*]))
;  b=reverse(reform(rgb[2,*]))
  
  tvlct,r,g,b
  
   

  ;str_element,extra,'title','test',/add
  str_element,opt_plot,'charsize',0.9,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'XMINOR',2,/add
  str_element,opt_plot,'xrange',xrange,/add
  str_element,opt_plot,'yrange',yrange,/add

  ;str_element,opt_bar,'position',[],/add
  ;str_element,opt_bar,'no_color_scale',0,/add
  str_element,opt_bar,'charsize',0.9,/add

  for i=0,1 do begin
    str_element,opt_bar,'title',bar_title[i],/add
    for j=0,3 do begin
      ;str_element,opt_plot,'title',title0[j,i],/add
      if j ne 0 then begin
        str_element,opt_plot,'ytickformat','(a1)',/add
        str_element,opt_plot,'ytitle',/delete
      endif else begin
        str_element,opt_plot,'ytickformat',/delete
        str_element,opt_plot,'ytitle','Y(Re)',/add
      endelse

      if i eq 0 then begin
        str_element,opt_plot,'xtickformat','(a1)',/add
        str_element,opt_plot,'xtitle',/delete
      endif else begin
        str_element,opt_plot,'xtickformat',/delete
        str_element,opt_plot,'xtitle','X(Re)',/add
      endelse

      if j eq 3 then str_element,opt_bar,'no_color_scale',0,/add else str_element,opt_bar,'no_color_scale',1,/add
      str_element,opt_bar,'position',[pos[i,j,2]+0.02,pos[i,j,1],pos[i,j,2]+0.05,pos[i,j,3]],/add
      d={x:x,y:reform(data[*,j,i],10*reverse_gap,30*reverse_gap),v:v}
      color_fill,pos[i,j,*],d,xrange=xrange,yrange=yrange,zrange=zrange,top=255,bottom=0,backcolor='grey',opt_plot=opt_plot,opt_bar=opt_bar
    endfor                                                      ;[-0.3,0.3] thermal EFD range
  endfor
  labels_stamp,pos[0,*,*],title0[*,0],charsize=1.15,/left_right_center,/up_out
  labels_stamp,pos[*,*,*],'  '+['(a)','(e)','(b)','(f)','(c)','(g)','(d)','(h)'],charsize=1.5,/left_in,/up_in
  ;labels_stamp,pos[1,*,*],'  '+['(e)','(f)','(g)','(h)'],charsize=1.5,/left_in,/up_in

  cgps_close
  stop
end