pro plot_ntp
  start=systime(1)
  Re=6371.0

  root_dir='\2001_2009_median'
  restore,filepath('event_p_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('event_n_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)
  restore,filepath('event_t_2001_2009_median.sav',root_dir='C:\__Data\Datasave'+root_dir)

  bar_title0='Density (cm!u-3!n!x)'
  bar_title1='Temperature (keV)'
  bar_title2='Pressure (nPa)'
  bar_title=[bar_title0,bar_title1,bar_title2]

  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median\'
  cgps_open,output_dir+'n_t_p_2001_2009_median_gap0.833.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(3,4,left=0.05,right=0.68,xgap=0.02,ygap=0.02,low=0.01,high=0.97)
  x=linspace(-20,-10,13)
  v=linspace(-15,15,37)

  event_n1=reform(event_n1,432)
  event_n2=reform(event_n2,432)
  event_n3=reform(event_n3,432)
  event_n4=reform(event_n4,432)
  
  event_t1=reform(event_t1,432)
  event_t2=reform(event_t2,432)
  event_t3=reform(event_t3,432)
  event_t4=reform(event_t4,432)
  
  event_p1=reform(event_p1,432)
  event_p2=reform(event_p2,432)
  event_p3=reform(event_p3,432)
  event_p4=reform(event_p4,432)

  data=[[[event_n1],[event_n2],[event_n3],[event_n4]],[[event_t1],[event_t2],[event_t3],$
  [event_t4]],[[event_p1],[event_p2],[event_p3],[event_p4]]]
  idx=where(data eq 0)
  data[idx]=!values.f_nan

  cgloadct,39
  title0=[['B!dz_IMF!n!x>0  d!dt!n!x>1hr','B!dz_IMF!n!x>0  d!dt!n!x<1hr','B!dz_IMF!n!x<0  d!dt!n!x>1hr','B!dz_IMF!n!x< 0  d!dt!n!x<1hr'],$
    ['','','',''],['','','','']]
  xrange=[-20,-10]
  yrange=[15,-15]
  zrange1=[0.05,0.5];N
  zrange2=[0.15,6.0];T
  zrange3=[0.02,0.25];P
  zrange=[[zrange1],[zrange2],[zrange3]]
 
  str_element,opt_plot,'charsize',0.6,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'XMINOR',2,/add
  str_element,opt_plot,'xticks',2,/add
  str_element,opt_plot,'xrange',xrange,/add
  str_element,opt_plot,'yrange',yrange,/add

  ;str_element,opt_bar,'position',[],/add
  str_element,opt_bar,'no_color_scale',0,/add
  str_element,opt_bar,'charsize',0.7,/add

  for i=0,2 do begin
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

      if i ne 2 then begin
        str_element,opt_plot,'xtickformat','(a1)',/add
        str_element,opt_plot,'xtitle',/delete
      endif else begin
        str_element,opt_plot,'xtickformat',/delete
        str_element,opt_plot,'xtitle','X(Re)',/add
      endelse

      if j eq 3 then str_element,opt_bar,'no_color_scale',0,/add else str_element,opt_bar,'no_color_scale',1,/add
      str_element,opt_bar,'position',[pos[i,j,2]+0.02,pos[i,j,1],pos[i,j,2]+0.05,pos[i,j,3]],/add
      d={x:x,y:reform(data[*,j,i],12,36),v:v}
      color_fill,pos[i,j,*],d,xrange=xrange,yrange=yrange,zrange=zrange[*,i],top=254,bottom=0,backcolor='white',zlog=1,opt_plot=opt_plot,opt_bar=opt_bar
    endfor
  endfor
  labels_stamp,pos[0,*,*],title0[*,0],charsize=0.8,/left_right_center,/up_out
  ;labels_stamp,pos[*,*,*],'  '+['(a)','(e)','(b)','(f)','(c)','(g)','(d)','(h)'],charsize=1.5,/left_in,/up_in
  ;labels_stamp,pos[1,*,*],'  '+['(e)','(f)','(g)','(h)'],charsize=1.5,/left_in,/up_in

  cgps_close
  stop
end