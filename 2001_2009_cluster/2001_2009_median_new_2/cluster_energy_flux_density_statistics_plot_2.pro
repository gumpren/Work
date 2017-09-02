pro cluster_energy_flux_density_statistics_plot_2
  
    Re=6371.0
    reverse_gap=5.0/5.0
    save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'   ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
    root_dir='C:\__Data\Datasave\2001_2009_median_new_2\'
    output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median_new_2\'
  
    ;;________________________________plot_n_t_p_______________________
    ;
    ;  ee=2
    ;
    ;  restore,filepath('event_n'+save_str+'.sav',root_dir=root_dir)
    ;  restore,filepath('event_t'+save_str+'.sav',root_dir=root_dir)
    ;  restore,filepath('event_p'+save_str+'.sav',root_dir=root_dir)
    ;
    ;  bar_title1='Density (cm!u-3!n!x)'
    ;  bar_title2='Temperature (keV)'
    ;  bar_title3='Pressure (nPa)'
    ;  bar_title=[bar_title1,bar_title2,bar_title3]
    ;
    ;  event_n1=reform(event_n1,10*30*reverse_gap^2)
    ;  event_n2=reform(event_n2,10*30*reverse_gap^2)
    ;  event_n3=reform(event_n3,10*30*reverse_gap^2)
    ;  event_n4=reform(event_n4,10*30*reverse_gap^2)
    ;  event_n5=reform(event_n5,10*30*reverse_gap^2)
    ;  event_n6=reform(event_n6,10*30*reverse_gap^2)
    ;
    ;  factor_to_kev=1.0;1.0e6/(1000.0*11600)
    ;  event_t1=reform(event_t1,10*30*reverse_gap^2)*factor_to_kev
    ;  event_t2=reform(event_t2,10*30*reverse_gap^2)*factor_to_kev
    ;  event_t3=reform(event_t3,10*30*reverse_gap^2)*factor_to_kev
    ;  event_t4=reform(event_t4,10*30*reverse_gap^2)*factor_to_kev
    ;  event_t5=reform(event_t5,10*30*reverse_gap^2)*factor_to_kev
    ;  event_t6=reform(event_t6,10*30*reverse_gap^2)*factor_to_kev
    ;
    ;  event_p1=reform(event_p1,10*30*reverse_gap^2)
    ;  event_p2=reform(event_p2,10*30*reverse_gap^2)
    ;  event_p3=reform(event_p3,10*30*reverse_gap^2)
    ;  event_p4=reform(event_p4,10*30*reverse_gap^2)
    ;  event_p5=reform(event_p5,10*30*reverse_gap^2)
    ;  event_p6=reform(event_p6,10*30*reverse_gap^2)
    ;
    ;  data1=[[[event_n1],[event_n2],[event_n3]],[[event_n4],[event_n5],[event_n6]]]
    ;  data2=[[[event_t1],[event_t2],[event_t3]],[[event_t4],[event_t5],[event_t6]]]
    ;  data3=[[[event_p1],[event_p2],[event_p3]],[[event_p4],[event_p5],[event_p6]]]
    ;
    ;  zrange1=[0.05,0.5];N
    ;  zrange2=[0.15,6.0];T
    ;  zrange3=[0.02,0.25];P
    ;
    ;  title_char1='n'
    ;  title_char2='t'
    ;  title_char3='p'
    ;
    ;  case ee of
    ;    1:begin
    ;       zrange=zrange1
    ;       data=data1
    ;       title_char=title_char1
    ;      end
    ;    2:begin
    ;       zrange=zrange2
    ;       data=data2
    ;       title_char=title_char2
    ;      end
    ;    3:begin
    ;       zrange=zrange3
    ;       data=data3
    ;       title_char=title_char3
    ;      end
    ;  endcase
    ;
    ;
    ;  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
    ;  pos=set_plot_position(2,3,left=0.05,right=0.63,xgap=0.03,ygap=0.05,low=0.01,high=0.8)
    ;  x=linspace(-20,-10,10*reverse_gap+1)
    ;  v=linspace(-15,15,30*reverse_gap+1)
    ;  xrange=[-20,-10]
    ;  yrange=[15,-15]
    ;
    ;
    ;  bottom=0
    ;  ncolors=253
    ;  cgloadct,34,ncolors=ncolors,bottom=bottom
    ;  ;  tvlct,r,g,b,/get
    ;  ;  for ii=bottom,bottom+ncolors do begin
    ;  ;    tvlct,[[r[ii]],[g[ii]],[b[ii]]],ii-bottom
    ;  ;  endfor
    ;
    ;  ;   TVLCT,cgColor('gray',/Triple),0
    ;  ;   TVLCT,cgColor('Purple',/Triple),253
    ;  ;  color_table=rainbow_palette()
    ;  ;  r=byte(reform(color_table[0,*]))
    ;  ;  g=byte(reform(color_table[1,*]))
    ;  ;  b=byte(reform(color_table[2,*]))
    ;  ;
    ;  ;  tvlct,r,g,b
    ;  ;
    ;   title0=[['B!dz!n!x>0 10min<d!dt!n!x<30min','B!dz!n!x>0 30min<d!dt!n!x<90min','B!dz!n!x>0 d!dt!n!x>90min'],$
    ;           ['B!dz!n!x<0 10min<d!dt!n!x<30min','B!dz!n!x<0 30min<d!dt!n!x<90min','B!dz!n!x<0 d!dt!n!x>90min']]
    ;
    ;  ;  zrange1=[0.05,0.5];N
    ;  ;  zrange2=[0.15,6.0];T
    ;  ;  zrange3=[0.02,0.25];P
    ;  ;  1/reverse_gapzrange=[[zrange1],[zrange2],[zrange3]]
    ;
    ;  str_element,opt_plot,'charsize',0.6,/add
    ;  str_element,opt_plot,'yticklen',0.05,/add
    ;  str_element,opt_plot,'XMINOR',2,/add
    ;  str_element,opt_plot,'xticks',2,/add
    ;  str_element,opt_plot,'xrange',xrange,/add
    ;  str_element,opt_plot,'yrange',yrange,/add
    ;
    ;  ;str_element,opt_bar,'position',[],/add
    ;  str_element,opt_bar,'no_color_scale',0,/add
    ;  str_element,opt_bar,'charsize',0.7,/add
    ;  str_element,opt_bar,'title',bar_title[ee-1],/add
    ;  ;  str_element,opt_bar,'ylog',1,/add
    ;  ;  str_element,opt_bar,'yminor',9,/add
    ;
    ;  ;  str_element,opt_bar,'OOB_Low',0,/add
    ;  ;  str_element,opt_bar,'OOB_High',254,/add
    ;
    ;  ;  cgColorbar, Divisions=16, NColors=15, Bottom=1, Range=[-10, 5], $
    ;  ;    Title='Zonal Winds (m/s) Cocos Island', $
    ;  ;    TLocation='top', /Discrete, Format='(i0)', Position=[0.125, 0.86, 0.9, 0.90], $
    ;  ;    OOB_Low='0', OOB_High='17', TCharsize=cgDefCharsize()*1.25
    ;
    ;
    ;
    ;  idx=where(data eq 0)
    ;  data[idx]=!values.f_nan
    ;
    ;
    ;  for i=0,1 do begin
    ;    for j=0,2 do begin
    ;      ;str_element,opt_plot,'title',title0[j,i],/add
    ;      if j ne 0 then begin
    ;        str_element,opt_plot,'ytickformat','(a1)',/add
    ;        str_element,opt_plot,'ytitle',/delete
    ;      endif else begin
    ;        str_element,opt_plot,'ytickformat',/delete
    ;        str_element,opt_plot,'ytitle','Y(Re)',/add
    ;      endelse
    ;
    ;      if i ne 1 then begin
    ;        str_element,opt_plot,'xtickformat','(a1)',/add
    ;        str_element,opt_plot,'xtitle',/delete
    ;      endif else begin
    ;        str_element,opt_plot,'xtickformat',/delete
    ;        str_element,opt_plot,'xtitle','X(Re)',/add
    ;      endelse
    ;
    ;      if j eq 2 then str_element,opt_bar,'no_color_scale',0,/add else str_element,opt_bar,'no_color_scale',1,/add
    ;      str_element,opt_bar,'position',[pos[i,j,2]+0.03,pos[i,j,1],pos[i,j,2]+0.05,pos[i,j,3]],/add
    ;      d={x:x,y:reform(data[*,j,i],10*reverse_gap,30*reverse_gap),v:v}
    ;      color_fill,pos[i,j,*],d,xrange=xrange,yrange=yrange,zrange=zrange,top=bottom+ncolors,bottom=bottom,backcolor='white',zlog=1,opt_plot=opt_plot,opt_bar=opt_bar
    ;      labels_stamp,pos[i,j,*],title0[j,i],charsize=0.8,/left_right_center,/up_out
    ;    endfor
    ;  endfor
    ;  ;labels_stamp,pos[0,*,*],title0[*,0],charsize=0.8,/left_right_center,/up_out
    ;  ;labels_stamp,pos[*,*,*],'  '+['(a)','(e)','(b)','(f)','(c)','(g)','(d)','(h)'],charsize=1.5,/left_in,/up_in
    ;  ;labels_stamp,pos[1,*,*],'  '+['(e)','(f)','(g)','(h)'],charsize=1.5,/left_in,/up_in
    ;
    ;
    ;  cgps_close
    ;
  
    ;________________________________plot_energy_flux_density_______________________
  
  
  
  
    ee=1
  
  
    restore,filepath('H_Re_xy'+save_str+'.sav',root_dir=root_dir)
  ;  restore,filepath('K_Re_xy'+save_str+'.sav',root_dir=root_dir)
  
    bar_title1='H!dX!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
    bar_title2='H!dY!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
    bar_title3='K!dX!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
    bar_title4='K!dY!N!X (10!u16!n!xergs!u-1!n!xRe!u2!n!x)'
  
    zrange1=[-0.3,0.3]
    zrange2=[-0.3,0.3]
    zrange3=[-0.001,0.001]
    zrange4=[-0.001,0.001]
  
    H_Re_x1=reform(H_Re_x1,300*reverse_gap^2)
    H_Re_x2=reform(H_Re_x2,300*reverse_gap^2)
    H_Re_x3=reform(H_Re_x3,300*reverse_gap^2)
    H_Re_x4=reform(H_Re_x4,300*reverse_gap^2)
    H_Re_x5=reform(H_Re_x5,300*reverse_gap^2)
    H_Re_x6=reform(H_Re_x6,300*reverse_gap^2)
    H_Re_x7=reform(H_Re_x7,300*reverse_gap^2)
    H_Re_x8=reform(H_Re_x8,300*reverse_gap^2)
    H_Re_x9=reform(H_Re_x9,300*reverse_gap^2)
    H_Re_x10=reform(H_Re_x10,300*reverse_gap^2)
    
  
    H_Re_y1=reform(H_Re_y1,300*reverse_gap^2)
    H_Re_y2=reform(H_Re_y2,300*reverse_gap^2)
    H_Re_y3=reform(H_Re_y3,300*reverse_gap^2)
    H_Re_y4=reform(H_Re_y4,300*reverse_gap^2)
    H_Re_y5=reform(H_Re_y5,300*reverse_gap^2)
    H_Re_y6=reform(H_Re_y6,300*reverse_gap^2)
    H_Re_y7=reform(H_Re_y7,300*reverse_gap^2)
    H_Re_y8=reform(H_Re_y8,300*reverse_gap^2)
    H_Re_y9=reform(H_Re_y9,300*reverse_gap^2)
    H_Re_y10=reform(H_Re_y10,300*reverse_gap^2)

  
;    K_Re_x1=reform(K_Re_x1,300*reverse_gap^2)
;    K_Re_x2=reform(K_Re_x2,300*reverse_gap^2)
;    K_Re_x3=reform(K_Re_x3,300*reverse_gap^2)
;    K_Re_x4=reform(K_Re_x4,300*reverse_gap^2)
;    K_Re_x5=reform(K_Re_x5,300*reverse_gap^2)
;    K_Re_x6=reform(K_Re_x6,300*reverse_gap^2)
;  
;    K_Re_y1=reform(K_Re_y1,300*reverse_gap^2)
;    K_Re_y2=reform(K_Re_y2,300*reverse_gap^2)
;    K_Re_y3=reform(K_Re_y3,300*reverse_gap^2)
;    K_Re_y4=reform(K_Re_y4,300*reverse_gap^2)
;    K_Re_y5=reform(K_Re_y5,300*reverse_gap^2)
;    K_Re_y6=reform(K_Re_y6,300*reverse_gap^2)
;  
    data1=[[[H_Re_x1],[H_Re_x2],[H_Re_x3],[H_Re_x4],[H_Re_x5]],$
           [[H_Re_x6],[H_Re_x6],[H_Re_x8],[H_Re_x9],[H_Re_x10]]]
    data2=[[[H_Re_y1],[H_Re_y2],[H_Re_y3],[H_Re_y4],[H_Re_y5]],$
           [[H_Re_y6],[H_Re_y6],[H_Re_y8],[H_Re_y9],[H_Re_y10]]]
;    data3=[[[K_Re_x1],[K_Re_x2],[K_Re_x3]],$
;      [[K_Re_x4],[K_Re_x5],[K_Re_x6]]]
;    data4=[[[K_Re_y1],[K_Re_y2],[K_Re_y3]],$
;      [[K_Re_y4],[K_Re_y5],[K_Re_y6]]]
  
    title_char1='thermal_energy_flux_x'
    title_char2='thermal_energy_flux_y'
;    title_char3='kinetic_energy_flux_x'
;    title_char4='kinetic_energy_flux_y'
  
    case ee of
      1:begin
         bar_title=bar_title1
         title_char=title_char1
         data=data1
         zrange=zrange1
        end
      2:begin
         bar_title=bar_title2
         title_char=title_char2
         data=data2
         zrange=zrange2
        end
;  3:begin
;  bar_title=bar_title3
;  title_char=title_char3
;  data=data3
;  zrange=zrange3
;  end
;  4:begin
;  bar_title=bar_title4
;  title_char=title_char4
;  data=data4
;  zrange=zrange4
;  end
   endcase
  
  
  
  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  x=linspace(-20,-10,10*reverse_gap+1)
  v=linspace(-15,15,30*reverse_gap+1)  ; connect to the return_vari function. follow the same start point
  xrange=[-20,-10]
  yrange=[15,-15]
  title0=[['B!dz!n!x>0 5~15min','B!dz!n!x>0 15~30min','B!dz!n!x>0 30~60min','B!dz!n!x>0 60~90min','B!dz!n!x>0 >90min'],$
          ['B!dz!n!x<0 5~15min','B!dz!n!x<0 15~30min','B!dz!n!x<0 30~60min','B!dz!n!x<0 60~90min','B!dz!n!x<0 >90min']]

  
  ;  ;v      change : title,not change; image, change
  ;yrange change : title, change  ;  image, change
  idx=where(data eq 0)
  data[idx]=!values.f_nan
  pos=set_plot_position(2,5,left=0.01,right=0.95,xgap=0.04,ygap=0.04,low=0.01,high=0.95)
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
  
  ;  cgplots,0.457,0.95,psym=cgsymcat('filled circle'),symsize=2,color='blue'
  ;  cgplots,0.457,0.5,psym=cgsymcat('filled circle'),symsize=2,color='blue'
  ;  xx=0.1*findgen(10)
  ;  cgplots,xx,sin(xx),psym=cgsymcat('filled circle'),symsize=2,color='blue'
  
  ;str_element,extra,'title','test',/add
  str_element,opt_plot,'charsize',0.8,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'XMINOR',2,/add
  str_element,opt_plot,'xrange',xrange,/add
  str_element,opt_plot,'yrange',yrange,/add
  
  ;str_element,opt_bar,'position',[],/add
  str_element,opt_bar,'no_color_scale',0,/add
  str_element,opt_bar,'charsize',0.8,/add
  str_element,opt_bar,'title',bar_title,/add
  
  for i=0,1 do begin
    for j=0,4 do begin
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
  
      if j eq 4 then str_element,opt_bar,'no_color_scale',0,/add else str_element,opt_bar,'no_color_scale',1,/add
      str_element,opt_bar,'position',[pos[i,j,2]+0.02,pos[i,j,1],pos[i,j,2]+0.05,pos[i,j,3]],/add
      d={x:x,y:reform(data[*,j,i],10*reverse_gap,30*reverse_gap),v:v}
      color_fill,pos[i,j,*],d,xrange=xrange,yrange=yrange,zrange=zrange,top=255,bottom=0,backcolor='grey',opt_plot=opt_plot,opt_bar=opt_bar
      labels_stamp,pos[i,j,*],title0[j,i],charsize=0.8,/left_right_center,/up_out
    endfor                                                      ;[-0.3,0.3] thermal EFD range
  endfor
  
  ;labels_stamp,pos[*,*,*],'  '+['(a)','(e)','(b)','(f)','(c)','(g)','(d)','(h)'],charsize=1.5,/left_in,/up_in
  ;labels_stamp,pos[1,*,*],'  '+['(e)','(f)','(g)','(h)'],charsize=1.5,/left_in,/up_in
  
  cgps_close
  
  
    end