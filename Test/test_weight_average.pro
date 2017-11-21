pro test_weight_average
  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_5minute_per_point\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_5minute_per_point\'
  title_char='line_hx_lasttime_5minute_per_point_0_margin_dawnflank';

  title0=['median_hx_Bz','average_hx_Bz']
  ytitle='H'+cgsymbol('sub')+'x'

  restore,filename=root_dir+'raw_data'+save_str+'_list_5minute_per_point_0_margin_full_dawnflank.sav'
  x=indgen(30)
  
  median_hx1=dblarr(30)
  average_hx1=dblarr(30)
  median_hx2=dblarr(30)
  average_hx2=dblarr(30)
  
  

  for i=0,29 do begin
    median_hx1[i]=median((H_Re[i])[*,0])
    average_hx1[i]=average((H_Re[i])[*,0],/nan)

    median_hx2[i]=median((H_Re[i+29])[*,0])
    average_hx2[i]=average((H_Re[i+29])[*,0],/nan)

    print,i
    ;event data
    ;    median_hx1[i]=median(event_hx[i])
    ;    average_hx1[i]=average(event_hx[i])
    ;
    ;    median_hx2[i]=median(event_hx[i+16])
    ;    average_hx2[i]=average(event_hx[i+16])
    ;      err_median_hx1[i]=STDDEV(H_Re.(i)[*,0],/nan)
    ;      err_median_hx2[i]=STDDEV(H_Re.(i+15)[*,0],/nan)
  endfor



  stop

end