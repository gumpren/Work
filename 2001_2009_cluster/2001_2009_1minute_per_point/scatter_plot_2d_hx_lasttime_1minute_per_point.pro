pro scatter_plot_2d_hx_lasttime_1minute_per_point

  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_1minute_per_point\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_1minute_per_point\'
  title_char='southward_scatter_plot_2d_ey_lasttime_1minute_per_point';


  restore,filename=root_dir+'scatter_event_data'+save_str+'_list_1minute_per_point.sav'
  restore,filename=root_dir+'scatter_raw_data'+save_str+'_list_1minute_per_point.sav'
  
  
;  for i=0,138 do begin
;    append_array,tt_north,t_last[i]
;    append_Array,hx_north,(H_Re[i])[*,0]
;  endfor
;
;  for i=139,238 do begin
;    append_Array,ttime,t_c3cis[i]
;    append_array,tt_south,t_last[i]
;    append_Array,hx_south,(H_Re[i])[*,0]
;  endfor
;  
  
    for i=139,278 do begin
    append_Array,ttime,t_c3cis[i]
    append_array,tt_south,t_last[i]
    append_Array,ey_south,E_GSM_y[i]
  endfor

  
  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0

    cgplot,tt_south,ey_south,psym=3,xrange=[5,144]
  ;  cgscatter2d,tt,hx,xtitle='last time',ytitle='Hx',psym=3
 ;   labels_stamp,title0[i],charsize=0.7,/left_right_center,/up_out

  cgps_close
;


  stop


end