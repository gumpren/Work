pro scatter_plot_2d_hx_lasttime_1minute_per_point

  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_1minute_per_point\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_1minute_per_point\'
  title_char='scatter_plot_2d_hx_lasttime_1minute_per_point';


  restore,filename=root_dir+'scatter_event_data_ey_gt_0'+save_str+'_list_1minute_per_point.sav'

  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0

  str_element,opt_plot,'charsize',0.6,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'XMINOR',2,/add
  str_element,opt_plot,'xticks',2,/add
  str_element,opt_plot,'X(Re)',xtitle,/add
  ;  str_element,opt_plot,'average H along Y',ytitle,/add

  str_element,opt_plot,'xtickname',['0','5','15','25','35','45','55','65','75','85','95', $
      '105','115','125','135','145',cgsymbol('infinity')],/add
  str_element,opt_plot,'xticks',16,/add
  str_element,opt_plot,'charsize',0.7,/add
  str_element,opt_plot,'xtitle',cgsymbol('delta')+'t',/add
  str_element,opt_plot,'ytitle',ytitle,/add


  
  for i=0,278 do begin
    append_array,tt,t_last[i]
    append_Array,hx,(H_Re[i])[*,0]
  endfor

  
    cgscatter2d,tt,hx,xtitle='last time',ytitle='Hx'
 ;   labels_stamp,title0[i],charsize=0.7,/left_right_center,/up_out


  cgps_close



  stop


end