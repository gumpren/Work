pro cluster_energy_flux_density_statistics_plot_32_pieces
  
  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'   ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_median_30_pieces\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median_30_pieces\'
  
  
  restore,filepath('event_data'+save_str+'_list_32_pieces_duskflank.sav',root_dir=root_dir)
  factor_to_kev=1.0;1.0e6/(1000.0*11600)

  bar_title1='Density (cm!u-3!n!x)'
  bar_title2='Temperature (keV)'
  bar_title3='Pressure (nPa)'
  bar_title4='Velocity_x(km/s)'
  bar_title5='H!dX!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
  bar_title6='K!dX!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'

  zrange1=[0.05,0.5];N
  zrange2=[0.15,6.0];T
  zrange3=[0.01,0.2];P
  zrange4=[-50,50];V
  zrange5=[-0.4,0.4];H
  zrange6=[-0.001,0.001];K


  bar_title=[bar_title5,bar_title5,bar_title5,bar_title5]
  zrange=[[zrange5],[zrange5],[zrange5],[zrange5]]

  for i=0,31 do begin
    event_n[i]=reform(event_n[i],10*15*reverse_gap^2)
    event_t[i]=reform(event_t[i],10*15*reverse_gap^2*factor_to_kev)
    event_p[i]=reform(event_p[i],10*15*reverse_gap^2)
    event_vx[i]=reform(event_vx[i],10*15*reverse_gap^2)
    event_hx[i]=reform(event_hx[i],10*15*reverse_gap^2)
    event_kx[i]=reform(event_kx[i],10*15*reverse_gap^2)
    event_h_k_x[i]=reform(event_h_k_x[i],10*15*reverse_gap^2)
  endfor

  data=[[[event_hx[0]],[event_hx[1]],[event_hx[2]],[event_hx[3]]], $
        [[event_hx[4]],[event_hx[5]],[event_hx[6]],[event_hx[7]]], $
        [[event_hx[8]],[event_hx[9]],[event_hx[10]],[event_hx[11]]], $
        [[event_hx[12]],[event_hx[13]],[event_hx[14]],[event_hx[15]]]]
;  data=[[[event_hx[16]],[event_hx[17]],[event_hx[18]],[event_hx[19]]], $
;        [[event_hx[20]],[event_hx[21]],[event_hx[22]],[event_hx[23]]], $
;        [[event_hx[24]],[event_hx[25]],[event_hx[26]],[event_hx[27]]], $
;        [[event_hx[28]],[event_hx[29]],[event_hx[30]],[event_hx[31]]]]
  
  title_char='H_X_BZ_GE_0_32_pieces'
  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  x=linspace(-20,-10,10*reverse_gap+1)
  v=linspace(-15,15,30*reverse_gap+1)  ; connect to the return_vari function. follow the same start point
  xrange=[-20,-10]
  yrange=[15,-15]

  ;  title0=[['B!dz!n!x>0 10min<d!dt!n!x<30min','B!dz!n!x>0 30min<d!dt!n!x<90min','B!dz!n!x>0 d!dt!n!x>90min',$
  ;           'B!dz!n!x<0 10min<d!dt!n!x<30min','B!dz!n!x<0 30min<d!dt!n!x<90min','B!dz!n!x<0 d!dt!n!x>90min'],$
  ;           ['','','','','',''],['','','','','','']]
;  title0=[['B!dz!n!x>0 [05,15]','B!dz!n!x>0 [15,25]','B!dz!n!x>0 [25,35]','B!dz!n!x<0 [35,45]','B!dz!n!x<0 [45,55]'],$
;          ['B!dz!n!x>0 [55,65]','B!dz!n!x>0 [65,75]','B!dz!n!x>0 [75,85]','B!dz!n!x>0 [85,95]','B!dz!n!x>0 [95,105]'], $
;          ['B!dz!n!x>0 [105,115]','B!dz!n!x>0 [115,125]','B!dz!n!x>0 [125,135]','B!dz!n!x>0 [135,145]','B!dz!n!x>0 [145, ]']]
  title0=[['B!dz!n!x<0 [00,05]','B!dz!n!x<0 [05,15]','B!dz!n!x<0 [15,25]','B!dz!n!x<0 [25,35]'],$
          ['B!dz!n!x<0 [35,45]','B!dz!n!x<0 [45,55]','B!dz!n!x<0 [55,65]','B!dz!n!x<0 [65,75]'],$
          ['B!dz!n!x<0 [75,85]','B!dz!n!x<0 [85,95]','B!dz!n!x<0 [95,105]','B!dz!n!x<0 [105,115]'], $
          ['B!dz!n!x<0 [115,125]','B!dz!n!x<0 [125,135]','B!dz!n!x<0 [135,145]','B!dz!n!x<0 [145, ]']]

  ;  ;v      change : title,not change; image, change
  ;yrange change : title, change  ;  image, change
  idx=where(data eq 0)
  data[idx]=!values.f_nan
  pos=set_plot_position(4,4,left=0.01,right=0.84,xgap=0.03,ygap=0.03,low=0.01,high=0.96)
  ;cgloadct,38;,/reverse
  ;cgloadct,72,/reverse
  ;  restore,'E:\OneDrive\IDLworks\Other\blue_white_red_256.ctl'
  ;  tvlct,r,g,b
  

  ;str_element,extra,'title','test',/add
  str_element,opt_plot,'charsize',0.7,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'xticks',2,/add
  str_element,opt_plot,'xrange',xrange,/add
  str_element,opt_plot,'yrange',yrange,/add

  ;str_element,opt_bar,'position',[],/add
  str_element,opt_bar,'no_color_scale',0,/add
  str_element,opt_bar,'charsize',0.8,/add
  ;str_element,opt_bar,'title',bar_title,/add
  
  restore,'E:\OneDrive\IDLworks\Work\Other\blue_white_red_256.ctl'
  tvlct,r,g,b
  
  for i=0,3 do begin
    str_element,opt_bar,'title',bar_title[i],/add
    for j=0,3 do begin
      ;str_element,opt_plot,'title',title0[j,i],/add

;      if i eq 0 then begin
;        bottom=0
;        ncolors=253
;        cgloadct,34,ncolors=ncolors,bottom=bottom
;      endif else begin
;        restore,'E:\OneDrive\IDLworks\Other\blue_white_red_256.ctl'
;        tvlct,r,g,b
;      endelse
      if j ne 0 then begin
        str_element,opt_plot,'ytickformat','(a1)',/add
        str_element,opt_plot,'ytitle',/delete
      endif else begin
        str_element,opt_plot,'ytickformat',/delete
        str_element,opt_plot,'ytitle',bar_title[i],/add
      endelse

      if i ne 3 then begin
        str_element,opt_plot,'xtickformat','(a1)',/add
        str_element,opt_plot,'xtitle',/delete
      endif else begin
        str_element,opt_plot,'xtickformat',/delete
        str_element,opt_plot,'xtitle','X(Re)',/add
      endelse

      if j eq 3 then str_element,opt_bar,'no_color_scale',0,/add else str_element,opt_bar,'no_color_scale',1,/add
      str_element,opt_bar,'position',[pos[i,j,2]+0.02,pos[i,j,1],pos[i,j,2]+0.05,pos[i,j,3]],/add
      d={x:x,y:reform(data[*,j,i],10*reverse_gap,15*reverse_gap),v:v}
      color_fill,pos[i,j,*],d,xrange=xrange,yrange=yrange,zrange=zrange[*,i],top=255,bottom=0,backcolor='grey',opt_plot=opt_plot,opt_bar=opt_bar
      labels_stamp,pos[i,j,*],title0[j,i],charsize=0.8,/left_right_center,/up_out
    endfor                                                      ;[-0.3,0.3] thermal EFD range
  endfor

  ;labels_stamp,pos[*,*,*],'  '+['(a)','(e)','(b)','(f)','(c)','(g)','(d)','(h)'],charsize=1.5,/left_in,/up_in
  ;labels_stamp,pos[1,*,*],'  '+['(e)','(f)','(g)','(h)'],charsize=1.5,/left_in,/up_in

  cgps_close
  



end