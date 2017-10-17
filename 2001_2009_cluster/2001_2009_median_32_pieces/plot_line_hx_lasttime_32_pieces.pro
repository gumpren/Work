pro plot_line_hx_lasttime_32_pieces
  
  Re=6371.0
  reverse_gap=5.0/5.0
  save_str='_2001_2009_gap'+string(1/reverse_gap,format='(f5.3)')+'Re'
  ;string(1/reverse_gap,format='(f5.3)')   STRCOMPRESS(1/reverse_gap,/remove)
  root_dir='C:\__Data\Datasave\2001_2009_median_30_pieces\'
  output_dir='E:\OneDrive\IDLworks\PS\cluster_statistics\2001_2009_median_30_pieces\'
  title_char='line_hx_lasttime_32_pieces_5_30_far';

  ee=1
  tt=300

  title0=['median_hx_Bz','average_hx_Bz']
         
  
  restore,filepath('event_data'+save_str+'_list_32_pieces_5_30_far.sav',root_dir=root_dir)

  x=indgen(16)+1

  median_hx1=dblarr(16)
  average_hx1=dblarr(16)
  median_hx2=dblarr(16)
  average_hx2=dblarr(16)

  err_median_hx1=dblarr(16)
  err_average_hx1=dblarr(16)
  err_median_hx2=dblarr(16)
  err_average_hx2=dblarr(16)
  ;  STDDEV()

  for i=0,15 do begin
    median_hx1[i]=median((H_Re[i])[*,0])
    average_hx1[i]=average((H_Re[i])[*,0],/nan)

    median_hx2[i]=median((H_Re[i+16])[*,0])
    average_hx2[i]=average((H_Re[i+16])[*,0],/nan)
    
    ;event data
;    median_hx1[i]=median(event_hx[i])
;    average_hx1[i]=average(event_hx[i])
;
;    median_hx2[i]=median(event_hx[i+16])
;    average_hx2[i]=average(event_hx[i+16])
 
    
    ;      err_median_hx1[i]=STDDEV(H_Re.(i)[*,0],/nan)
    ;      err_median_hx2[i]=STDDEV(H_Re.(i+15)[*,0],/nan)
  endfor

  a=[[[1],[2]], $
     [[3],[4]]]
  
  get_Data=[[[median_hx1],[median_hx2]],  $
           [[average_hx1],[average_hx2]]]
;  err_bar=[[[err_median_hx1],[err_median_hx2]],  $
;           [[err_average_hx1],[err_average_hx2]] ]

  cgps_open,output_dir+title_char+save_str+'.ps',xsize=6.0,ysize=7.0
  pos=set_plot_position(2,1,left=0.05,right=0.92,xgap=0.1,ygap=0.06,low=0.01,high=0.7)

;  str_element,opt_plot,'charsize',0.6,/add
  str_element,opt_plot,'yticklen',0.05,/add
  str_element,opt_plot,'XMINOR',1,/add
 ; str_element,opt_plot,'xticks',2,/add
 ; str_element,opt_plot,'X(Re)',xtitle,/add
  ;  str_element,opt_plot,'average H along Y',ytitle,/add
  


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
      if i eq 0 then begin
           str_element,opt_plot,'yrange',[0,0.25],/add
      endif else begin
           str_element,opt_plot,'yrange',[-2.5,2.5],/add
      endelse
      str_element,opt_plot,'xticks',15,/add
      str_element,opt_plot,'charsize',0.5,/add
      ;str_element,opt_plot,'xtitle','last_time',/add
      str_element,opt_plot,'xtickname',['[0,05]','[05,15]','[15,25]','[25,35]','[35,45]','[45,55]',$
                                       '[55,65]','[65,75]','[75,85]','[85,95]','[95,105]', $
                                      '[105,115]','[115,125]','[125,135]','[135,145]','[145, ]'],/add
      
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