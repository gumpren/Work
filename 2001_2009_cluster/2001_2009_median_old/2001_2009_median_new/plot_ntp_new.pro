pro plot_ntp_new
  start=systime(1)
  Re=6371.0
  
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  root_dir='C:\__Data\Datasave\2001_2009_median_new\'
  restore,filepath('event_n'+save_str+'.sav',root_dir=root_dir)
  restore,filepath('event_t'+save_str+'.sav',root_dir=root_dir)
  restore,filepath('event_p'+save_str+'.sav',root_dir=root_dir)

  bar_title0='Density (cm!u-3!n!x)'
  bar_title1='Temperature (keV)'
  bar_title2='Pressure (nPa)'
  bar_title=[bar_title0,bar_title1,bar_title2]

  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median_new\'
  cgps_open,output_dir+'n_t_p_2001_2009'+save_str+'.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(3,4,left=0.05,right=0.68,xgap=0.02,ygap=0.02,low=0.01,high=0.97)
  x=linspace(-20,-10,10*reverse_gap+1)
  v=linspace(-15,15,30*reverse_gap+1)

  event_n1=reform(event_n1,10*30*reverse_gap^2)
  event_n2=reform(event_n2,10*30*reverse_gap^2)
  event_n3=reform(event_n3,10*30*reverse_gap^2)
  event_n4=reform(event_n4,10*30*reverse_gap^2)

  factor_to_kev=1.0e6/(1000.0*11600)
  event_t1=reform(event_t1,10*30*reverse_gap^2)*factor_to_kev
  event_t2=reform(event_t2,10*30*reverse_gap^2)*factor_to_kev
  event_t3=reform(event_t3,10*30*reverse_gap^2)*factor_to_kev
  event_t4=reform(event_t4,10*30*reverse_gap^2)*factor_to_kev

  event_p1=reform(event_p1,10*30*reverse_gap^2)
  event_p2=reform(event_p2,10*30*reverse_gap^2)
  event_p3=reform(event_p3,10*30*reverse_gap^2)
  event_p4=reform(event_p4,10*30*reverse_gap^2)

  data=[[[event_n1],[event_n2],[event_n3],[event_n4]],[[event_t1],[event_t2],[event_t3],$
    [event_t4]],[[event_p1],[event_p2],[event_p3],[event_p4]]]
  idx=where(data eq 0)
  data[idx]=!values.f_nan
  
  
  bottom=0
  ncolors=253
  cgloadct,34,ncolors=ncolors,bottom=bottom
;  tvlct,r,g,b,/get
;  for ii=bottom,bottom+ncolors do begin
;    tvlct,[[r[ii]],[g[ii]],[b[ii]]],ii-bottom
;  endfor
   
;   TVLCT,cgColor('gray',/Triple),0 
;   TVLCT,cgColor('Purple',/Triple),253
;  color_table=rainbow_palette()
;  r=byte(reform(color_table[0,*]))
;  g=byte(reform(color_table[1,*]))
;  b=byte(reform(color_table[2,*]))
;  
;  tvlct,r,g,b
;  
  title0=[['B!dz_IMF!n!x>0  d!dt!n!x>1hr','B!dz_IMF!n!x>0  d!dt!n!x<1hr','B!dz_IMF!n!x<0  d!dt!n!x>1hr','B!dz_IMF!n!x< 0  d!dt!n!x<1hr'],$
    ['','','',''],['','','','']]
  xrange=[-20,-10]
  yrange=[15,-15]
  zrange1=[0.05,0.5];N
  zrange2=[0.15,6.0];T
  zrange3=[0.02,0.25];P
;  zrange1=[0.05,0.5];N
;  zrange2=[0.15,6.0];T
;  zrange3=[0.02,0.25];P
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
;  str_element,opt_bar,'ylog',1,/add
;  str_element,opt_bar,'yminor',9,/add
  
;  str_element,opt_bar,'OOB_Low',0,/add
;  str_element,opt_bar,'OOB_High',254,/add
  
;  cgColorbar, Divisions=16, NColors=15, Bottom=1, Range=[-10, 5], $
;    Title='Zonal Winds (m/s) Cocos Island', $
;    TLocation='top', /Discrete, Format='(i0)', Position=[0.125, 0.86, 0.9, 0.90], $
;    OOB_Low='0', OOB_High='17', TCharsize=cgDefCharsize()*1.25

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
      d={x:x,y:reform(data[*,j,i],10*reverse_gap,30*reverse_gap),v:v}
      color_fill,pos[i,j,*],d,xrange=xrange,yrange=yrange,zrange=zrange[*,i],top=bottom+ncolors,bottom=bottom,backcolor='white',zlog=1,opt_plot=opt_plot,opt_bar=opt_bar
    endfor
  endfor
  labels_stamp,pos[0,*,*],title0[*,0],charsize=0.8,/left_right_center,/up_out
  ;labels_stamp,pos[*,*,*],'  '+['(a)','(e)','(b)','(f)','(c)','(g)','(d)','(h)'],charsize=1.5,/left_in,/up_in
  ;labels_stamp,pos[1,*,*],'  '+['(e)','(f)','(g)','(h)'],charsize=1.5,/left_in,/up_in
  
  cgps_close
  stop
end