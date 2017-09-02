pro plot_enthalpy_kinetic_flux_xy
   root_dir='\2001_2009_median'
   output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median\'
   
;   restore,filepath('event_qh_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)
;   bar_title0='H!dX!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
;   bar_title1='H!dY!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
;   bar_title=[bar_title0,bar_title1]
;   cgps_open,output_dir+'enthalpy_energy_flux_2001_2009_median_gap0.833.ps',xsize=6.0,ysize=7.0
;   qhx1=reform(event_qhx1,432)
;   qhx2=reform(event_qhx2,432)
;   qhx3=reform(event_qhx3,432)
;   qhx4=reform(event_qhx4,432)
;   qhy1=reform(event_qhy1,432)
;   qhy2=reform(event_qhy2,432)
;   qhy3=reform(event_qhy3,432)
;   qhy4=reform(event_qhy4,432)
;   data=[[[qhx1],[qhx2],[qhx3],[qhx4]],$
;     [[qhy1],[qhy2],[qhy3],[qhy4]]]
;   zrange=[-0.3,0.3]

   
   restore,filepath('event_qk_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)
   bar_title0='K!dX!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
   bar_title1='K!dY!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
   bar_title=[bar_title0,bar_title1]
   cgps_open,output_dir+'kinetic_energy_flux_2001_2009_median_gap0.833.ps',xsize=6.0,ysize=7.0
   qkx1=reform(event_qkx1,432)
   qkx2=reform(event_qkx2,432)
   qkx3=reform(event_qkx3,432)
   qkx4=reform(event_qkx4,432)
   qky1=reform(event_qky1,432)
   qky2=reform(event_qky2,432)
   qky3=reform(event_qky3,432)
   qky4=reform(event_qky4,432)
   data=[[[qkx1],[qkx2],[qkx3],[qkx4]],$
         [[qky1],[qky2],[qky3],[qky4]]]
   zrange=[-0.0008,0.0008]

     
   x=linspace(-20,-10,13)
   v=linspace(-15,15,37)  ; connect to the return_vari function. follow the same start point
   xrange=[-20,-10]
   yrange=[15,-15]
   ;v      change : title,not change; image, change
   ;yrange change : title, change   ; image, change
   
   idx=where(data eq 0)
   data[idx]=!values.f_nan
   pos=set_plot_position(2,4,left=0.01,right=0.9,xgap=0.04,ygap=0.02,low=0.01,high=0.95) 
   ;cgloadct,72,/reverse
   restore,'E:\OneDrive\IDLworks\blue_white_red_256.ctl'
   tvlct,r,g,b
   title0=[['B!dz_IMF!n!x>0  d!dt!n!x>1hr','B!dz_IMF!n!x>0  d!dt!n!x<1hr','B!dz_IMF!n!x<0  d!dt!n!x>1hr','B!dz_IMF!n!x< 0  d!dt!n!x<1hr'],$
    ['','','','']]

   ;str_element,extra,'title','test',/add
   str_element,opt_plot,'charsize',0.9,/add
   str_element,opt_plot,'yticklen',0.05,/add
   str_element,opt_plot,'XMINOR',2,/add
   str_element,opt_plot,'xrange',xrange,/add
   str_element,opt_plot,'yrange',yrange,/add
 
   ;str_element,opt_bar,'position',[],/add
   str_element,opt_bar,'no_color_scale',0,/add
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
      d={x:x,y:reform(data[*,j,i],12,36),v:v}
      color_fill,pos[i,j,*],d,xrange=xrange,yrange=yrange,zrange=zrange,top=255,bottom=0,backcolor='grey',opt_plot=opt_plot,opt_bar=opt_bar
    endfor                                                      ;[-0.3,0.3] thermal EFD range
   endfor
   labels_stamp,pos[0,*,*],title0[*,0],charsize=1.15,/left_right_center,/up_out
   labels_stamp,pos[*,*,*],'  '+['(a)','(e)','(b)','(f)','(c)','(g)','(d)','(h)'],charsize=1.5,/left_in,/up_in
   ;labels_stamp,pos[1,*,*],'  '+['(e)','(f)','(g)','(h)'],charsize=1.5,/left_in,/up_in
   
   cgps_close
   stop
end