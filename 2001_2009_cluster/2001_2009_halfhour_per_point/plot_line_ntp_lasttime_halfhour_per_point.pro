pro plot_line_ntp_lasttime_halfhour_per_point

  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_halfhour_per_point\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_halfhour_per_point\'
  title_char='line_n_lasttime_halfhour_per_point';

  title0=['median_n_Bz','average_n_Bz']
  nrange=[0.05,0.15]
  trange=[0.05,0.15]
  prange=[0.05,0.15]

  restore,filepath('raw_data'+save_str+'_list_halfhour_per_point.sav',root_dir=root_dir)

  x=indgen(16)+1

  median_n1=dblarr(16)
  average_n1=dblarr(16)
  median_n2=dblarr(16)
  average_n2=dblarr(16)
  
  median_t1=dblarr(16)
  average_t1=dblarr(16)
  median_t2=dblarr(16)
  average_t2=dblarr(16)
  
  median_p1=dblarr(16)
  average_p1=dblarr(16)
  median_p2=dblarr(16)
  average_p2=dblarr(16)
  
;  err_median_ey1=dblarr(16)
;  err_average_ey1=dblarr(16)
;  err_median_ey2=dblarr(16)
;  err_average_ey2=dblarr(16)
  ;  STDDEV()

;  ey_minus_per=dblarr(32)
;  for ii=0,31 do begin
;    index=where(E_gsm_y[ii] le 0,count)
;    ey_minus_per[ii]=count/float(n_elements(E_gsm_y[ii]))
;  endfor


  for i=0,15 do begin
    median_n1[i]=median(density[i])
    average_n1[i]=average(density[i],/nan)
    median_n2[i]=median(density[i+16])
    average_n2[i]=average(density[i+16],/nan)
       
    median_t1[i]=median(temperature[i])
    average_t1[i]=average(temperature[i],/nan)
    median_t2[i]=median(temperature[i+16])
    average_t2[i]=average(temperature[i+16],/nan)
     
    median_p1[i]=median(pressure[i])
    average_p1[i]=average(pressure[i],/nan)
    median_p2[i]=median(pressure[i+16])
    average_p2[i]=average(pressure[i+16],/nan)


    ;event data
    ;    median_ey1[i]=median(event_ey[i])
    ;    average_ey1[i]=average(event_ey[i])
    ;
    ;    median_ey2[i]=median(event_ey[i+16])
    ;    average_ey2[i]=average(event_ey[i+16])


    ;      err_median_ey1[i]=STDDEV(H_Re.(i)[*,0],/nan)
    ;      err_median_ey2[i]=STDDEV(H_Re.(i+15)[*,0],/nan)
  endfor

  a=[[[1],[2]], $
     [[3],[4]]]
 
  get_Data=[[[median_n1],[median_n2]], $
            [[average_n1],[average_n2]]]  
           
  ;  err_bar=[[[err_median_ey1],[err_median_ey2]],  $
  ;           [[err_average_ey1],[err_average_ey2]] ]

  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(2,1,left=0.05,right=0.92,xgap=0.1,ygap=0.06,low=0.01,high=0.95)

  ;  str_element,opt_plot,'charsize',0.6,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'XMINOR',1,/add
  ; str_element,opt_plot,'xticks',2,/add
  ; str_element,opt_plot,'X(Re)',xtitle,/add
  ; str_element,opt_plot,'average H along Y',ytitle,/add



  for i=0,1 do begin
    ;    for j=0,1 do begin
    ;      if i ne 1 then begin
    ;        str_element,opt_plot,'xtickformat','(a1)',/add
    ;        str_element,opt_plot,'xtitle',/delete
    ;      endif else begin
    ;        str_element,opt_plot,'xtickformat',/delete
    ;        str_element,opt_plot,'xtitle','Time',/add
    ;      endelse

    ;      if j eq 0 then begin
    ;        str_element,opt_plot,'ytitle',ytitle[0],/add
    ;      endif else begin
    ;        str_element,opt_plot,'ytitle',ytitle[1],/add
    ;      endelse

    str_element,opt_plot,'yrange',prange,/add
    
    str_element,opt_plot,'xticks',15,/add
    str_element,opt_plot,'charsize',0.5,/add
    ;str_element,opt_plot,'xtitle','last_time',/add
    str_element,opt_plot,'xtickname',['[0,0.5]','[0.5,1.0]','[1.0,1.5]','[1.5,2.0]','[2.0,2.5]','[2.5,3.0]',$
      '[3.0,3.5]','[3.5,4.0]','[4.0,4.5]','[4.5,5.0]','[5.0,5.5]', $
      '[5.5,6.0]','[6.0,6.5]','[6.5,7.0]','[7.0,7.5]','[7.5, 8.0]'],/add

    cgplot,x,get_Data[*,0,i],position=pos[i,0,*],_extra=opt_plot,/normal,/noerase
    cgoplot,x,get_Data[*,1,i],color='red',position=pos[i,0,*],_extra=opt_plot,/normal,/noerase
    labels_stamp,pos[i,0,*],title0[i],charsize=0.7,/left_right_center,/down_out

    ;      p = ERRORPLOT(x, get_Data[*,i,j], err_bar[*,i,j], XRANGE=[1,15], $
    ;        XTITLE="Day", YTITLE="Distance (miles)", $
    ;        TITLE="Average distance bears walk in a day")
   endfor

  
  cgText, 0.97, 0.65, 'Northward IMF Bz', ALIGNMENT=0, /NORMAL ,charsize=0.8
  cgText, 0.97, 0.63, 'Southward IMF Bz', ALIGNMENT=0, /NORMAL ,COLOR='RED',charsize=0.8

  ;  cgplot,x,aaa,position=pos[0,0,*],xrange=[-20,-10],_extra=opt_plot
  ;
  ;  cgplot,x,aaa,position=pos[0,1,*],xrange=[-20,-10],_extra=opt_plot

  cgps_close



  stop


end