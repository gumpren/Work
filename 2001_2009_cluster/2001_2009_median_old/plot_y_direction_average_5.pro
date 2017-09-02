  pro plot_y_direction_average_5
  
    Re=6371.0
    reverse_gap=5.0/5.0
    save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'+'_mean'
    ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
    root_dir='C:\__Data\Datasave\2001_2009_median_new_5\'
    output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median_new_5\'
    title_char='H_K_x_time_dependence_mean'
    
    ee=1
    tt=300
  
    title0=[['median_hx_Bz_North','median_hx_Bz_South'],$
            ['average_hx_Bz_North','average_hx_Bz_South']]
    
    
    restore,filepath('event_data'+save_str+'.sav',root_dir=root_dir)
      
    x=indgen(15)+1
    
    median_h_k_x1=dblarr(15)
    average_h_k_x1=dblarr(15)
    median_h_k_x2=dblarr(15)
    average_h_k_x2=dblarr(15)
 
    err_median_hx1=dblarr(15)
    err_average_hx1=dblarr(15)
    err_median_hx2=dblarr(15)
    err_average_hx2=dblarr(15)
  ;  STDDEV()
    
    for i=0,14 do begin
      median_h_k_x1[i]=median(H_K_Re_x.(i))
      average_h_k_x1[i]=mean(H_K_Re_x.(i),/nan)
      
      median_h_k_x2[i]=median(H_K_Re_x.(i+15))
      average_h_k_x2[i]=mean(H_K_Re_x.(i+15),/nan)
      
;      median_hx1[i]=median(H_K_Re.(i)[*,0])
;      average_hx1[i]=average(H_k_Re.(i)[*,0],/nan)
;
;      median_hx2[i]=median(H_K_Re.(i+15)[*,0])
;      average_hx2[i]=average(H_K_Re.(i+15)[*,0],/nan)
      
;      err_median_hx1[i]=STDDEV(H_Re.(i)[*,0],/nan)
;      err_median_hx2[i]=STDDEV(H_Re.(i+15)[*,0],/nan)
    endfor
    
  get_Data=[[[median_h_k_x1],[median_h_k_x2]],  $
            [[average_h_k_x1],[average_h_k_x2]] ]  
;  err_bar=[[[err_median_hx1],[err_median_hx2]],  $
;            [[err_average_hx1],[err_average_hx2]] ]
  
  cgps_open,output_dir+title_char+save_str+'_new'+string(tt)+'.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(2,2,left=0.05,right=0.93,xgap=0.1,ygap=0.06,low=0.01,high=0.6)
  
  str_element,opt_plot,'charsize',0.6,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'XMINOR',2,/add
  str_element,opt_plot,'xticks',2,/add
  str_element,opt_plot,'X(Re)',xtitle,/add
  ;  str_element,opt_plot,'average H along Y',ytitle,/add
  
  
 
  for i=0,1 do begin
    for j=0,1 do begin
      if i ne 1 then begin
        str_element,opt_plot,'xtickformat','(a1)',/add
        str_element,opt_plot,'xtitle',/delete
      endif else begin
        str_element,opt_plot,'xtickformat',/delete
        str_element,opt_plot,'xtitle','Time',/add
      endelse
  
;      if j eq 0 then begin
;        str_element,opt_plot,'ytitle',ytitle[0],/add
;      endif else begin
;        str_element,opt_plot,'ytitle',ytitle[1],/add
;      endelse
  
      cgplot,x,get_Data[*,i,j],position=pos[i,j,*],xrange=[1,15],yrange=[0,0.25],_extra=opt_plot,/normal,/noerase
     ; cgoplot,x,get_Data2[*,i,j],color='red',position=pos[i,j,*],xrange=[-20,-10],yrange=yrange,_extra=opt_plot,/normal,/noerase
      labels_stamp,pos[i,j,*],title0[i,j],charsize=0.8,/left_right_center,/up_out
;      p = ERRORPLOT(x, get_Data[*,i,j], err_bar[*,i,j], XRANGE=[1,15], $
;        XTITLE="Day", YTITLE="Distance (miles)", $
;        TITLE="Average distance bears walk in a day")
    endfor
  endfor
  
  
  ;  cgplot,x,aaa,position=pos[0,0,*],xrange=[-20,-10],_extra=opt_plot
  ;
  ;  cgplot,x,aaa,position=pos[0,1,*],xrange=[-20,-10],_extra=opt_plot
  
  cgps_close
  
  
  
  stop
  
  
  end