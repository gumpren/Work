pro plot_massflux_xy
  root_dir='\2001_2009_median'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median\'
  
  restore,filepath('event_vxy_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('event_n_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)
  bar_title1='Massflux_x(kg*km/s)'
  bar_title2='Massflux_y(kg*km/s)'
  bar_title=[[bar_title1],[bar_title2]]
  cgps_open,output_dir+'massflux_xy_2001_2009_median_gap0.833.ps',xsize=6.0,ysize=7.0
  event_mfx1=reform(event_vx1*event_n1,432)
  event_mfx2=reform(event_vx2*event_n2,432)
  event_mfx3=reform(event_vx3*event_n3,432)
  event_mfx4=reform(event_vx4*event_n4,432)
  event_mfy1=reform(event_vy1*event_n1,432)
  event_mfy2=reform(event_vy2*event_n2,432)
  event_mfy3=reform(event_vy3*event_n3,432)
  event_mfy4=reform(event_vy4*event_n4,432)
  data=[[[event_mfx1],[event_mfx2],[event_mfx3],[event_mfx4]],$
       [[event_mfy1],[event_mfy2],[event_mfy3],[event_mfy4]]]
       
  pos=set_plot_position(2,4,left=0.01,right=0.9,low=0.01,high=0.95,xgap=0.04,ygap=0.02)
  x=linspace(-20,-10,13)
  v=linspace(-15,15,37)
  xrange=[-20,-10]
  yrange=[15,-15]
  idx=where(data eq 0)
  data[idx]=!values.f_nan

  restore,'E:\OneDrive\IDLworks\blue_white_red_256.ctl'
  tvlct,r,g,b
  title0=[['B!dz_IMF!n!x>0  d!dt!n!x>1hr','B!dz_IMF!n!x>0  d!dt!n!x<1hr','B!dz_IMF!n!x<0  d!dt!n!x>1hr','B!dz_IMF!n!x< 0  d!dt!n!x<1hr'],$
    ['','','','']]
  str_element,opt_plot,'charsize',0.9,/add
  str_element,opt_plot,'xminor',2,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'xticks',2,/add

  str_element,opt_bar,'charsize',0.9,/add


  for i=0,1 do begin
    for j=0,3 do begin
      str_element,opt_bar,'title',bar_title[i],/add
      if (i eq 0) then begin
        str_element,opt_plot,'xtitle',/delete
        str_element,opt_plot,'xtickformat','(a1)',/add
      endif else begin
        str_element,opt_plot,'xtickformat',/delete
        str_element,opt_plot,'xtitle','X(Re)',/add
      endelse

      if (j ne 0) then begin
        str_element,opt_plot,'ytickformat','(a1)',/add
        str_element,opt_plot,'ytitle',/delete
      endif else begin
        str_element,opt_plot,'ytickformat',/delete
        str_element,opt_plot,'ytitle','Y(Re)',/add
      endelse

      if j ne 3 then begin
        str_element,opt_bar,'no_color_scale',1,/add
      endif else begin
        str_element,opt_bar,'no_color_scale'
      endelse


      d={x:x,y:reform(data[*,j,i],12,36),v:v}
      color_fill,pos[i,j,*],d,xrange=xrange,yrange=yrange,zrange=[-20,20],top=255,bottom=0,backcolor='grey',opt_plot=opt_plot,opt_bar=opt_bar
    endfor
  endfor

  labels_stamp,pos[0,*,*],title0[*,0],charsize=1.15,/left_right_center,/up_out
  labels_stamp,pos[*,*,*],'  '+['(a)','(e)','(b)','(f)','(c)','(g)','(d)','(h)'],charsize=1.5,/left_in,/up_in

  cgps_close
  stop




end