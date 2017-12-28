
pro scatter_plot_2d_hx_lasttime_1minute_per_point
  h_Factor=1.0/(6.371^2*1.0e3)
  
  ;1W/m^2=6.371^2*1.0e3(1.0e16*erg/(Re^2*s))
  
  region_str='_duskflank'
  
  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_1minute_per_point\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_1minute_per_point\'
  title_char='northward_scatter_plot_2d_hx_lasttime_1minute_per_point'+region_str;
    
  restore,filename=root_dir+'raw_data'+save_str+'_list_1minute_per_point'+region_str+'.sav'
  
  x=indgen(139)+5  
  median_hx_north=dblarr(139)
  average_hx_north=dblarr(139)
  median_hx_south=dblarr(139)
  average_hx_south=dblarr(139)


  for i=0,138 do begin
    H_Re[i]=H_Re[i]*h_factor
    H_Re[i+139]=H_Re[i+139]*h_factor
    
    median_hx_north[i]=median((H_Re[i])[*,0])
    average_hx_north[i]=average((H_Re[i])[*,0],/nan)

    median_hx_south[i]=median((H_Re[i+139])[*,0])
    average_hx_south[i]=average((H_Re[i+139])[*,0],/nan)
    
    
    append_array,tt_north,t_last[i]
    append_Array,hx_north,(H_Re[i])[*,0]

    append_array,tt_south,t_last[i+139]
    append_Array,hx_south,(H_Re[i+139])[*,0]
  endfor  
   
    
  ;cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
   cgdisplay
   
   idx_north_gt0=where(hx_north gt 0 )
   t_north_gt0=tt_north[idx_north_gt0]
   hx_north_gt0=hx_north[idx_north_gt0]
   
   cgplot,t_north_gt0,alog10(hx_north_gt0),psym=3,ylog=ylog,xrange=[5.5,144.5],yrange=[-10,-2];,yrange=[-12,12]
   
   idx_north_lt0=where(hx_north lt 0 )
   t_north_lt0=tt_north[idx_north_lt0]
   hx_north_lt0=hx_north[idx_north_lt0]
   
   cgoplot,t_north_lt0,alog10(-hx_north_lt0),psym=3,ylog=ylog,color='royal blue'
  
  
   cgplot,x,alog10(average_hx_north),xrange=[5.5,144.5],yrange=[-10,-2],ylog=ylog,color='red',_extra=opt_plot,/normal,/noerase
  
  ;  cgscatter2d,tt,hx,xtitle='last time',ytitle='Hx',psym=3
 ;   labels_stamp,title0[i],charsize=0.7,/left_right_center,/up_out
  stop
  print,'a'
  cgps_close
  


  stop


end